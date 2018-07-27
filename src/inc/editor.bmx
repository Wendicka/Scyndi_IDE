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
Version: 18.07.27
End Rem

MKL_Version "Scyndi IDE - editor.bmx","18.07.27"
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
CallBack_Action.Add qb_new,NewFile
CallBack_Menu.AddNum 1001,NewFile

Global hlcd=1000

Global ssfkeywords$[] = "PROGRAM SCRIPT MODULE FOR FORU FOREACH END VAR CONST TYPE IMPORT VOID PROCEDURE PROC FUNC FUNCTION DEF ENUM IF WHILE DO LOOP REPEAT UNTIL STRING INTEGER FLOAT BOOLEAN TRUE FALSE ARRAY MAP BEGIN MOD OR AND NOT".split(" ")
Function EndHLWord(P:TGadget,invar Var,c,str$)
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
			FormatTextAreaText p,$00,$b4,$ff,0,invar,(c-invar)'+1
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

Function HighLightSSF(sp:TGadget)
	Local src$=GadgetText(sp).ToUpper()
	Local instring=-1
	Local incomment=-1
	Local innumber=-1
	Local inword=-1
	Local backslash
	
	SetGadgetColor sp,$ff,$ff,$ff,False
	For Local i=0 Until (Len src)
		Local c$=Chr(src[i])
		Select c
			Case "."
				If Not (innumber<0 And incomment<0 And instring<0)
					endhlword sp,innumber,i,src
					endhlword sp,inword,i,src				
				EndIf			
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
					ElseIf (Not backslash)
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
		If (Not backslash) And c="\"
			backslash=True
		Else
			backslash=False
		EndIf
	Next
	
End Function

Function HighLight()
	Local i=SelectedGadgetItem(tabber); If Not i Return
	Local p:tsourcepanel = tsourcepanel(sources.valueatindex(i-1))
	Local sp:TGadget = p.source
	SetTextAreaTabs  sp,40
	DebugLog "Highlighting: "+p.filename
	SetGadgetColor sp,$bf,$ff,$00,False ' Basis
	Local e$=ExtractExt(p.filename).tolower()
	Select e
		Case "ssf"
			HighlightSSF sp
	End Select
End Function

Function cbcut()
	Local g:TGadget=ActiveGadget()
	Local c=GadgetClass(G)
	'Print "cut"
	If c=gadget_textarea Or c=gadget_textfield GadgetCut g
End Function
Function cbcopy()
	Local g:TGadget=ActiveGadget()
	Local c=GadgetClass(G)
	'Print "copy"
	If c=gadget_textarea Or c=gadget_textfield GadgetCopy g
End Function
Function cbpaste()
	Local g:TGadget=ActiveGadget()
	Local c=GadgetClass(G)
	'Print "paste"
	If c=gadget_textarea Or c=gadget_textfield GadgetPaste g
End Function
callback_action.add	qb_cut,		cbcut
callback_action.add	qb_copy,	cbcopy
callback_action.add	qb_paste,	cbpaste
callback_menu.addnum	2003,		cbcut
callback_menu.addnum	2004,		cbcopy
callback_menu.addnum	2005,		cbpaste


Function MyOpenFile()
	Local file$=RequestFile("Please choose a file","Scyndi Source File:ssf,scf;Wendicka Source File:wsf;GINI is not INI:GINI",False)
	If Not file Return
	If Not FileType(file) Return Notify("File not found")
	Local src$=LoadString(file)
	Local p:tsourcepanel = New tsourcepanel
	p.named=True
	p.filename=file
	SetGadgetText p.source,src
	ListAddLast sources,p
	AddGadgetItem tabber,StripDir(p.filename)
	SelectTab CountList(sources)	
End Function
callback_action.add	qb_open,	myopenfile
callback_menu.addnum	1002,		myopenfile



Function MySave(p:tsourcepanel,ask=1)
	' ask: 0 = never
	'      1 = only if unnamed
	'      2 = always
	Local file$=p.filename
	If (ask=1 And (Not p.named)) Or ask=2
		file = RequestFile("Please name your file","Scyndi Source File:ssf;Wendicka Source File:wsf;GINI is Not INI:GINI",True)
		If Not file Return
		p.filename=file
		renametabs
		p.named=True
	EndIf
	Local bt:TStream = WriteFile(file)
	If Not bt Return Notify("Saving ~q"+file+"~q failed")
	WriteString bt,TextAreaText(p.source)
	CloseFile bt
	SetStatusText SIWIN,p.filename+" has been saved"
	p.modified=False
End Function
	
Function Save()
	Local i=SelectedGadgetItem(tabber)
	If Not i Return
	Local p:tsourcepanel = tsourcepanel(sources.valueatindex(i-1))
	mysave p
End Function
Function SaveAs()
	Local i=SelectedGadgetItem(tabber)
	If Not i Return
	Local p:tsourcepanel = tsourcepanel(sources.valueatindex(i-1))
	mysave p,2
End Function
Function SaveAll()
	SetGadgetText console,""
	For Local p:tsourcepanel = EachIn sources
		If p.modified
			AddTextAreaText console,"Saving: "+p.filename+"~n"
			Mysave p
		EndIf
	Next
	Local r,g,b
	Local l = Len(GadgetText(console))
	For Local i=0 Until l
		r=((Double(i)/l)*255)
		g=255-r
		FormatTextAreaText console,r,g,b,0,i,1
	Next
End Function

CallBack_Menu.addnum 	1003,		Save
callback_menu.addnum 	1004,		SaveAs
callBack_menu.addnum	1005,		saveall
callback_action.add	qb_save,	Save




Function UpdateSource(panel:tsourcepanel)
	Local cursorpos=TextAreaCursor(panel.source,TEXTAREA_CHARS)
	Local cursorlen=TextAreaSelLen(panel.source,TEXTAREA_CHARS)
	Local cursorlin=TextAreaLine(panel.source,cursorpos)+1
	Local	c = cursorpos+cursorlen
	If cursorlin Then c:-TextAreaChar(panel.source,cursorlin-1)
	Local statustext$
	If panel.named statustext=panel.filename+" "
	If panel.modified statustext:+"*"
	statustext :+"~t"   
	Select ExtractExt(panel.filename)
		Case "ssf"	statustext :+ "Scyndi Source File"
		Case "scf"	statustext :+ "Scyndi Code File"
		Case "wsf"	statustext :+ "Wendicka Source File"
		Case "gigi"	statustext :+ "GINI Is Not Ini"
		Default		statustext :+" Unknown File Type"
	End Select
	statustext :+ "~tLine:"+cursorlin+"; Char: "+Int(c+1)
	'"~t~t"+LocalizeString("{{status_line_char}}").Replace("%1",cursorline).Replace("%2",(c+1))
	SetStatusText SIWIN, statustext
End Function



Function Build(p:tsourcepanel)
	saveall
	Local b$=AppDir
	Local a$=""
	Local flags$
	?MacOs
	b:+"/Scyndi_IDE.app/Contents/Resources"
	?Win32
	b=Replace(b,"\","/")
	a:+".exe"
	If b.find(" ") >= 0
		Notify "In windows there may be no spaces in the path where Scyndi_IDE is installed or things will not work the way they should. This is a Windows issue, nothing this program can do about!"
		Return
	EndIf
	?
	Local builder$
	Select ExtractExt(p.filename)
		Case "scf","ssf"
			builder=b+"/scorpion"+a
			flags="-target Lua" ' temp tag
			?win32
			flags:+" -ansi ON"
			?
		Case "wsf"
			builder=b+"/wendicka_build"+a
		Case "gini"
			Notify "You cannot build GINI files!"
			Return
		Default
			Notify "This IDE does not know how to build that filetype"
			Return
	End Select
	If Not FileType(builder)
		Notify "I need "+builder+" but it does not appear to be there, sorry!"
		Return
	EndIf
	Local commando$=builder
	If builder.find(" ") >= 0
		commando="~q"+commando+"~q"
	EndIf
	commando :+ " "+flags+" ~q"+p.filename+"~q"
	SetStatusText siwin,"Building: "+p.filename+" (this may take take)"
	startpopen commando,"Building: "+p.filename
	SetStatusText siwin,"Build: "+p.filename
End Function
Function cbbuild()
	Local i=SelectedGadgetItem(tabber)
	Local p:tsourcepanel = tsourcepanel ( sources.valueatindex(i-1) )
	build p
End Function
CallBack_Action.add qb_build,	cbbuild
CallBack_Menu.addnum	4001,	cbbuild
