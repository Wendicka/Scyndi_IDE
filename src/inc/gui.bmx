Rem
	Scyndi IDE
	gui definitions
	
	
	
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
MKL_Version "Scyndi IDE - gui.bmx","18.07.25"
MKL_Lic     "Scyndi IDE - gui.bmx","GNU General Public License 3"

Global SIWin:tgadget = CreateWindow("",0,0,ClientWidth(Desktop()),ClientHeight(Desktop()),Null,window_titlebar|window_status|window_menu)
Global SIWW = ClientWidth (SIWIN)
Global SIWH = ClientHeight(SIWIN)
Global SIPan:tgadget = CreatePanel(0,0,SIWW,SIWH,SIWin)
SetGadgetColor SIPAN,$A,$0,$10

Global Scyndi:tgadget = CreatePanel(0,0,96,96,SIWIN)
SetGadgetPixmap scyndi,LoadPixmap("incbin::Scyndi.png")


' Quick buttons
Global quickbutton_pan:tgadget = CreatePanel(96,0,SIWW-96,96,SIPan)
SetGadgetColor quickbutton_pan,$5,0,$8

' Editor



' Menu
Global menu_file:tgadget = CreateMenu("File",0,WindowMenu(SIWIN))
CreateMenu "New",1001,menu_file,Key_N,modifier_command
CreateMenu "",0,menu_file
CreateMenu "Open",1002,menu_file,Key_O,modifier_command
Global open_recent:tgadget = CreateMenu("Open Recent",0,menu_file)
CreateMenu "",0,menu_file
CreateMenu "Save",1003,menu_file,Key_S,modifier_command
CreateMenu "Save As",1004,menu_file,Key_S,modifier_command | modifier_shift
CreateMenu "Save All",1005,menu_file,Key_s,Modifier_command | modifier_shift | modifier_alt
?Not MacOS
CreateMenu "",0,menu_file
CreateMenu "Quit",9999,menu_file,Key_F4,modifier_Alt
?


Global menu_edit:tgadget = CreateMenu("Edit",0,WindowMenu(SIWIN))
CreateMenu "Undo",2001,menu_edit,key_Z,modifier_command
CreateMenu "Redo",2002,menu_edit,key_z,modifier_command | modifier_shift
CreateMenu "",0,menu_edit
CreateMenu "Cut",2003,menu_edit,key_x,modifier_command
CreateMenu "Copy",2004,menu_edit,key_c,modifier_command
CreateMenu "Paste",2005,menu_edit,key_v,modifier_command

Global menu_search:tgadget = CreateMenu("Search",0,WindowMenu(SIWIN))
CreateMenu "Find",3001,menu_search,Key_f,modifier_command
CreateMenu "Find Next",3002,Menu_search,key_g,modifier_command
CreateMenu "",0,menu_search
CreateMenu "Replace",3003,menu_search,Key_f,Modifier_command|modifier_shift
CreateMenu "",0,menu_search
CreateMenu "Go To Line",3004,menu_search,Key_l,modifier_command

Global menu_project:Tgadget = CreateMenu("Project",0,WindowMenu(SIWIN))
CreateMenu "Build",4001,menu_project,key_b,modifier_command
CreateMenu "",0,menu_project
Global menu_target:tgadget = CreateMenu("Target",0,menu_project)
For Local i=0 Until Len(targets)
	CreateMenu targets[i],5000+i,menu_target
Next



UpdateWindowMenu menu_file
