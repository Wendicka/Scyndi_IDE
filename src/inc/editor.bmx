Rem
	Scyndi IDE
	Editor data
	
	
	
	(c) Jeroen P. Broks, 2018, All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
Version: 18.07.26
End Rem

MKL_Version "Scyndi IDE - editor.bmx","18.07.26"
MKL_Lic     "Scyndi IDE - editor.bmx","GNU General Public License 3"

Global Sources:TList = New TList

Function gotfile(f$)
	Local ret:Byte = False
	For Local p:tsourcepanel=EachIn sources 
		ret = ret Or p.filename=f
	Next
	Return ret
End Function

Function DoNewFile(n$="")
	Local nonamefile$
	If Not n
		Repeat
			noname:+1
			nonamefile=config.C("NONAME")+"NoName_"+Hex(noname)+".ssf"
		Until (Not gotfile(nonamefile))		
	EndIf
	If gotfile(n) Return Notify("Huh? I already have a file with that name, don't I?")
	Local p:tsourcepanel = New tsourcepanel
	If n
		p.filename = n
	Else
		p.filename = nonamefile
	EndIf
	ListAddLast sources,p
	AddGadgetItem tabber,StripDir(p.filename)
	SelectTab CountList(sources)
End Function

Function NewFile()
	DoNewFile
End Function

Global hlcd=1000

Global ssfkeywords$[] = "PROGRAM SCRIPT MODULE FOR FORU FOREACH END VAR CONST TYPE IMPORT VOID PROCEDURE PROC FUNC FUNCTION DEF ENUM IF WHILE DO LOOP REPEAT UNTIL STRING INTEGER FLOAT BOOLEAN TRUE FALSE ARRAY MAP BEGIN".split(" ")
Function EndHLWord(P:tgadget,invar Var,c,str$)
	Local word$
	If invar=-1 Return
	If c-invar = 1
		word = Chr(str[invar])
	ElseIf c<>invar 
		word=str[invar..c]	
	EndIf
	DebugLog "endword:"+word
	Select Chr(word[0])
		Case "$","%","0","1","2","3","4","5","6","7","8","9"
			FormatTextAreaText p,$00,$b4,$ff,0,invar,(c-invar)+1
		Case "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","_"
			Local keyword
			For Local kw$=EachIn ssfkeywords
				keyword=keyword Or (kw=word)
			Next
			If keyword 
				FormatTextAreaText p,$bf,$ff,$00,0,invar,(c-invar)'+1
			Else
				FormatTextAreaText p,$ee,$ff,$dd,0,invar,(c-invar)'+1
			EndIf
	End Select	
	invar=-1				
End Function

Function HighLightSSF(sp:tgadget)
	Local src$=GadgetText(sp).ToUpper()
	Local instring=-1
	Local incomment=-1
	Local innumber=-1
	Local inword=-1
	
	SetGadgetColor sp,$ff,$ff,$ff,False
	For Local i=0 Until (Len src)
		Local c$=Chr(src[i])
		Select c
			Case "A","B","C","D","E","F"				
				If innumber<0 And inword<0 And incomment<0 And instring<0
					inword=i
				EndIf
			Case "G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","_"
				If innumber>=0 
					endhlword sp,innumber,i,src			 
				ElseIf inword<0 And incomment<0 And instring<0
					inword=i
				EndIf
			Case "$","%","0","1","2","3","4","5","6","7","8","9"
				If inword<0 And innumber<0 And incomment<0 And instring<0
					innumber=i
				EndIf				
			Case "~q"
				If incomment < 0
					If instring < 0
						endhlword sp,innumber,i,src
						endhlword sp,inword,i,src
						instring=i 
					Else
						FormatTextAreaText sp,$b4,$00,$ff,0,instring,(i-instring)+1
						instring=-1
					EndIf
				EndIf
			Case "{"
				If instring < 0
					If incomment < 0 
						endhlword sp,innumber,i,src
						endhlword sp,inword,i,src
						incomment=i
					EndIf
				EndIf
			Case "}"
				If incomment >=0
					FormatTextAreaText sp,$2f,$2f,$2f,0,incomment,(i-incomment)+1
					incomment=-10
				EndIf
			Default
				endhlword sp,innumber,i,src
				endhlword sp,inword,i,src				
		End Select		
		If i+1=(Len src)
			'DebugLog "end"
			endhlword sp,innumber,i+1,src
			endhlword sp,inword,i+1,src				
		EndIf		
	Next
End Function

Function HighLight()
	Local i=SelectedGadgetItem(tabber); If Not i Return
	Local p:tsourcepanel = tsourcepanel(sources.valueatindex(i-1))
	Local sp:tgadget = p.source
	DebugLog "Highlighting: "+p.filename
	SetGadgetColor sp,$bf,$ff,$00,False ' Basis
	Local e$=ExtractExt(p.filename).tolower()
	Select e
		Case "ssf"
			HighlightSSF sp
	End Select
End Function


CallBack_Action.Add qb_new,NewFile
CallBack_Menu.AddNum 1001,NewFile
