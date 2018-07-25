MKL_Version "Scyndi IDE - Scyndi_IDE.bmx","18.07.24"
MKL_Lic     "Scyndi IDE - Scyndi_IDE.bmx","GNU General Public License 3"

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
Global qbfw=ClientWidth(quickbutton_pan)
Global qbw = qbfw / 3
Global qbfh=ClientHeight(quickbutton_pan)
Global qbh = qbfh / 3
Global qb_new    :tgadget = CreateButton("New"   ,qbw*0,qbh*0,qbw,qbh,quickbutton_pan)
Global qb_open   :tgadget = CreateButton("Open"  ,qbw*0,qbh*1,qbw,qbh,quickbutton_pan)
Global qb_save   :tgadget = CreateButton("Save"  ,qbw*0,qbh*2,qbw,qbh,quickbutton_pan)

Global qb_cut    :tgadget = CreateButton("Cut"   ,qbw*1,qbh*0,qbw,qbh,quickbutton_pan)
Global qb_copy   :tgadget = CreateButton("Copy"  ,qbw*1,qbh*1,qbw,qbh,quickbutton_pan)
Global qb_paste  :tgadget = CreateButton("Paste" ,qbw*1,qbh*2,qbw,qbh,quickbutton_pan)

Global qb_find   :tgadget = CreateButton("Find"   ,qbw*2,qbh*0,qbw,qbh,quickbutton_pan)
Global qb_replace:tgadget = CreateButton("Replace",qbw*2,qbh*1,qbw,qbh,quickbutton_pan)
Global qb_build  :tgadget = CreateButton("Build"  ,qbw*2,qbh*2,qbw,qbh,quickbutton_pan)

' Editor
Global tabber:tgadget = CreateTabber(0,96,SIWW,SIWH-296,SIPan)
AddGadgetItem tabber,"Scyndi IDE"
Global tbw = ClientWidth(tabber)
Global tbh = ClientHeight(tabber)
Global about:tgadget = CreateLabel("",0,0,tbw,tbh,tabber)
SetGadgetColor about,$A,$0,$10,True
SetGadgetColor about,$b4,$ff,0,False
SetGadgetFont about,LookupGuiFont:TGuiFont( GUIFONT_monospaced )

Global pancrcol
Type TSourcePanel
	Field Panel:Tgadget
	Field Source:Tgadget
	Field Outline:Tgadget
End Type

Type Tsrccol
	Field r:Byte
	Field g:Byte
	Field b:Byte
End Type
Global srccol:tsrccol[10]
For Local i:Byte=0 Until 10 
	srccol[i]=New tsrccol
Next
srccol[0].r=$00	srccol[0].g=$0b	srccol[0].b=$0f
srccol[1].r=$0f	srccol[1].g=$00	srccol[1].b=$0f
srccol[2].r=$00	srccol[2].g=$0f	srccol[2].b=$0f
srccol[3].r=$0f	srccol[3].g=$0b	srccol[3].b=$0b
srccol[4].r=$0b	srccol[4].g=$06	srccol[4].b=$00
srccol[5].r=$00	srccol[5].g=$00	srccol[5].b=$0f
srccol[6].r=$0b	srccol[6].g=$06	srccol[6].b=$00
srccol[7].r=$0b	srccol[7].g=$0f	srccol[7].b=$00
srccol[8].r=$00	srccol[8].g=$0f	srccol[8].b=$0b
srccol[9].r=$0b	srccol[9].g=$00	srccol[9].b=$0f

' Control console
Global console:tgadget = CreateTextArea(0,SIWH-200,SIWW,200,SIPan)
SetGadgetColor console,$00,$00,$00
SetGadgetColor console,$7f,$7f,$7f,False


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
