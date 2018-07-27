Rem
	Scyndi IDE
	POPEN manager
	
	
	
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
Strict

Import tricky_units.MKL_Version
Import gale.mgui
Import jcr6.fileasjcr
Import brl.eventqueue

Incbin "popen.lua"

Private

MKL_Version "Scyndi IDE - popen.bmx","18.07.27"
MKL_Lic     "Scyndi IDE - popen.bmx","GNU General Public License 3"

Global jcr:TJCRDir=Raw2JCR("incbin::popen.lua","popen.lua")

Type LuaAPI
	Method platform$()
		?macos
			Return "Mac"
		?win32
			Return "Windows"
		?Linux
			Return "Linux
		?
	End Method

	Method Send(receive$)
		PollEvent
		DebugLog "Send: "+receive
		Local con:TGadget = GALE_ConsoleGadget
		Local o$,r$,g$,b$
		Local ar:Byte=$7f
		Local ag:Byte=$7f
		Local ab:Byte=$7f
		Local ansinums[] = New Int[0]		
		Local ansinum$
		Local inansi
		Local i=0		
		While i < Len (receive)	
			If Not inansi		
				If i+1 < (Len receive) And receive[i]=27 And receive[i+1]=Asc("[") 'receive[i..i+1]=Chr(27)+"[" 
					i:+2
					inansi=True
					ansinums = New Int[0]
					ansinum=""
					'Print "Ansi on"
				ElseIf receive[i]=13
					o=""
					r=""
					g=""
					b=""
					i:+1
				ElseIf receive[i]=8
					o=o[..Len(o)-1]
					r=r[..Len(o)-1]
					g=g[..Len(o)-1]
					b=b[..Len(o)-1]
					i:+1
				Else
					o:+Chr(receive[i])
					r:+Chr(ar)
					g:+Chr(ag)
					b:+Chr(ab)
					i:+1
				EndIf
			Else
				Select Chr(receive[i])
					Case "0","1","2","3","4","5","6","7","8","9"
						ansinum:+Chr(receive[i])
						i:+1
					Case ";"
						'Print "add code: "+ansinum
						ansinums=ansinums[..(Len ansinums)+1]
						ansinums[Len(ansinums)-1]=ansinum.toint()
						ansinum=""
						i:+1
					Case "m"
						'Print "add code: "+ansinum
						ansinums=ansinums[..(Len ansinums)+1]
						ansinums[Len(ansinums)-1]=ansinum.toint()
						ansinum=""
						For Local acode=EachIn ansinums
							'Print "got code: "+acode
							Select acode
								Case 30	ar=$00	ag=$00	ab=$00
								Case 31	ar=$ff	ag=$00	ab=$00
								Case 32 ar=$00	ag=$ff	ab=$00
								Case 33	ar=$ff	ag=$ff	ab=$00
								Case 34	ar=$00	ag=$00	ab=$ff
								Case 35	ar=$ff	ag=$00	ab=$ff
								Case 36	ar=$00	ag=$ff	ab=$ff
								Case 37	ar=$ff	ag=$ff	ab=$ff
								Case  0	ar=$7f	ag=$7f	ab=$7f
							End Select
						Next
						'Print "Ansi off"
						inansi=False	
						i:+1
					Default
						inansi=False
						i:+1
				End Select
			EndIf
		Wend
		Local lengte=Len(GadgetText(con))
		For Local i=0 Until (Len o)
			AddTextAreaText con,Chr(o[i])
			FormatTextAreaText con,r[i],g[i],b[i],0,lengte+i,1
		Next
		AddTextAreaText con,"~n"
		For Local i=1 To 10
			PollEvent		
		Next
	End Method

End Type

GALE_Register New LuaAPI,"bma"

Global script:TLua = GALE_LoadScript(jcr,"popen.lua")


Public

Function StartPOpen(opdracht$,omschrijving$)
	DebugLog omschrijving
	script.Run "startpopen",[opdracht,omschrijving]
End Function
