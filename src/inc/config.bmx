Rem
	Scyndi_ID
	Configuration manager
	
	
	
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
MKL_Version "Scyndi IDE - config.bmx","18.07.26"
MKL_Lic     "Scyndi IDE - config.bmx","GNU General Public License 3"

Const cconfigfile$ = "$AppSupport$/Scyndi_IDE/Config.gini"
Global configfile$ = Dirry(cconfigfile)

Global config:TIni = New TIni
config.D "target","NodeJS"
config.D "NoName",Dirry("$AppSupport$/Scyndi_IDE/NoName/")
If Not CreateDir(Dirry("$AppSupport$/Scyndi_IDE/NoName/"),True) crash "I could not create "+Dirry("$AppSupport$/Scyndi_IDE/NoName/")

If FileType(configfile) LoadIni configfile,config,True

For Local i=0 Until Len(targets)
	If targets[i]=config.c("target") 
		edata=5000+i
		PickTarget
	EndIf
Next