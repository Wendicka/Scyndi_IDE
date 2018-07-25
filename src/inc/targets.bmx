Rem
	Scyndi IDE
	Targets
	
	
	
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
Version: 18.07.25
End Rem
MKL_Version "Scyndi IDE - targets.bmx","18.07.25"
MKL_Lic     "Scyndi IDE - targets.bmx","GNU General Public License 3"

Global targets$[]
Function init_targets()
	Local mtargets:TList=New TList
	ListAddLast mtargets,"Wendicka"
	ListAddLast mtargets,"Lua"
	ListAddLast mtargets,"Php"
	ListAddLast mtargets,"Go"
	'targets=String[](ListToArray(mtargets))
	targets = New String[CountList(mtargets)]
	For Local i=0 Until CountList(mtargets)
		targets[i]=String(mtargets.valueatindex(i))
	Next
End Function
init_targets


