Rem
	Scyndi IDE
	main
	
	
	
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
Strict
Framework maxgui.drivers
Import    brl.eventqueue
Import    brl.pngloader
Import    tricky_units.MKL_Version
Import    tricky_units.GINI
Import    tricky_units.Dirry

Import "incbin/incbin.bmx"

MKL_Version "Scyndi IDE - Scyndi_IDE.bmx","18.07.26"
MKL_Lic     "Scyndi IDE - Scyndi_IDE.bmx","GNU General Public License 3"

Include "inc/targets.bmx"
Include "inc/gui.bmx"
Include "inc/events.bmx"

Include "inc/crash.bmx"
Include "inc/config.bmx"
Include "inc/editor.bmx"

Include "inc/finit.bmx"	' Fini + init hahah... this is the last init stuff before running

Include "inc/run.bmx"	' Run
