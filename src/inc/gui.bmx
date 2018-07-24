MKL_Version "Scyndi IDE - Scyndi_IDE.bmx","18.07.24"
MKL_Lic     "Scyndi IDE - Scyndi_IDE.bmx","GNU General Public License 3"

Global SIWin:tgadget = CreateWindow("",0,0,ClientWidth(Desktop()),ClientHeight(Desktop()),Null,window_titlebar|window_status)
Global SIWW = ClientWidth (SIWIN)
Global SIWH = ClientHeight(SIWIN)
Global SIPan:tgadget = CreatePanel(0,0,SIWW,SIWH,SIWin)
SetGadgetColor SIPAN,$A,$0,$10

Global Scyndi:tgadget = createpanel(0,0,96,96,SIWIN)
SetGadgetPixmap scyndi,LoadPixmap("incbin::Scyndi.png")