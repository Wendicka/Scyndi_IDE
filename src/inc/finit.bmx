Rem
	Scyndi IDE
	FINIT (Fini Init)
	
	
	
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
MKL_Version "Scyndi IDE - finit.bmx","18.07.27"
MKL_Lic     "Scyndi IDE - finit.bmx","GNU General Public License 3"

SetGadgetText SIWIN,"Scyndi IDE - Version "+MKL_NewestVersion()+" - Coded by: Jeroen P. Broks"

SetGadgetText about,"Scyndi IDE~nCoded by: Jeroen P. Broks~n(c) Jeroen P. Broks 2018-20"+Left(MKL_NewestVersion(),2)+"~nReleased under the terms of the General Public License version 3~n~n"+MKL_GetAllversions()
SetGadgetFont about,fwfont

GALE_ConsoleGadget = console
