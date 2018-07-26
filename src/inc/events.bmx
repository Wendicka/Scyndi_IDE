Rem
	Scyndi IDE
	Event manager
	
	
	
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
MKL_Version "Scyndi IDE - events.bmx","18.07.26"
MKL_Lic     "Scyndi IDE - events.bmx","GNU General Public License 3"

Global EID 
Global ESrc:TGadget 

Function S_WaitEvent()
	WaitEvent
	EID=EventID()
	ESrc=tgadget(EventSource())
End Function

Type tcbfun
	f : Function()
End Type	

Type MyCallBack 
	Field	map:tmap
	
	Method add(key:Object,fun:Function())
		Local f:tbcfun = New tbsfun
		f.f = fun
		MapInsert Self,key,f
	End Method
	
	Method addnum(key,fun Function())
		add Self,Hex(key),fun
	End Method
	
	Method call(key:Object)
		tbcfun(MapValueForKey(Self,key)()
	End Method
	
	Method callnum(key)
		call Hex(key)
	End Method
End Type

Global CallBack_Action:mycallback = New mycallback
Global callback_Menu:Mycallback = New mycallback
		
		
		
