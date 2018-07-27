--[[
	Scyndi IDE
	Script for all this!
	
	
	
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
]]
local realprint = print

local send = bma.Send
local platform = bma.Platform()

local function print(a,b,c,d,e,f)
	local r = ""..a
	if b then r = r .. "\t"..b end
	if c then r = r .. "\t"..c end
	if d then r = r .. "\t"..d end
	if e then r = r .. "\t"..e end
	if f then r = r .. "\t"..f end
	send ( r .. "\n" )
end

function startpopen(opdracht,omschrijving)
	print(omschrijving)
	local bt = io.popen(opdracht)
	local l
	repeat
		l = bt:read("*line")
		if l then send(l) end
	until not l
	bt:close()
	print("\nOperation completed!")
end
