Rem
	Scyndi IDE
	Run
	
	
	
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
Version: 18.07.28
End Rem
MKL_Version "Scyndi IDE - run.bmx","18.07.28"
MKL_Lic     "Scyndi IDE - run.bmx","GNU General Public License 3"

Repeat
	S_pollEvent
	If hlcd>-100 hlcd:-1
	If hlcd=0
		Highlight
	EndIf
	'If Right(hlcd,2)="00" Print hlcd
	If eid DoNeedFile 'Print "Event: "+eid
	Select eid
		Case event_gadgetaction
			CallBack_Action.call esrc
			hlcd=20000
			For Local p:tsourcepanel = EachIn sources
				If esrc=p.source 
					updatesource p
					p.modified=True
				EndIf
				If esrc=p.outline
					p.outlinegoto
				endif
			Next
		Case EVENT_GADGETSELECT	
			For Local p:tsourcepanel = EachIn sources
				If esrc=p.source updatesource p
			Next
		Case event_menuaction
			callback_Menu.callnum edata
		Case event_windowclose,event_appterminate
			End 
	End Select
Forever
