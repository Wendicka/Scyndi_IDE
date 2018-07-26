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
CallBack_Action.Add qb_new,NewFile
CallBack_Menu.AddNum 1001,NewFile
