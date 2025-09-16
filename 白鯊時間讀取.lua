send48c = "send_command send48c:"
sendrel8 = "send_command sendrel8:"
ipad = "send_command ipad:"


local status = "'"..'{"cmd_header":"hscmd-get-system-time","cmd_body":{ "english":"y"}}'.."'"
local rel1on = "'HS-REL-setrelay-01-on'"
local rel2on = "'HS-REL-setrelay-02-on'"
local rel3on = "'HS-REL-setrelay-03-on'"
local rel4on = "'HS-REL-setrelay-04-on'"
local rel5on = "'HS-REL-setrelay-05-on'"
local rel6on = "'HS-REL-setrelay-06-on'"
local rel7on = "'HS-REL-setrelay-07-on'"
local rel8on = "'HS-REL-setrelay-08-on'"
local rel1off = "'HS-REL-setrelay-01-off'"
local rel2off = "'HS-REL-setrelay-02-off'"
local rel3off = "'HS-REL-setrelay-03-off'"
local rel4off = "'HS-REL-setrelay-04-off'"
local rel5off = "'HS-REL-setrelay-05-off'"
local rel6off = "'HS-REL-setrelay-06-off'"
local rel7off = "'HS-REL-setrelay-07-off'"
local rel8off = "'HS-REL-setrelay-08-off'"


local allon = {
	{command = sendrel8..rel1on,time = "1"},
	{command = sendrel8..rel2on,time = "1000"},
	{command = sendrel8..rel3on,time = "2000"},
	{command = sendrel8..rel4on,time = "3000"},
	{command = sendrel8..rel5on,time = "4000"},
	{command = sendrel8..rel6on,time = "5000"},
	{command = sendrel8..rel7on,time = "6000"},
	{command = sendrel8..rel8on,time = "7000"},
}

local alloff = {
	{command = sendrel8..rel8off,time = "1"},
	{command = sendrel8..rel7off,time = "1000"},
	{command = sendrel8..rel6off,time = "2000"},
	{command = sendrel8..rel5off,time = "3000"},
	{command = sendrel8..rel4off,time = "4000"},
	{command = sendrel8..rel3off,time = "5000"},
	{command = sendrel8..rel2off,time = "6000"},
	{command = sendrel8..rel1off,time = "7000"},
}

local min_10 = "3A31303A"
local min_20 = "3A32303A"
local min_30 = "3A33303A"
local min_40 = "3A34303A"
local min_50 = "3A35303A"
local min_00 = "3A30303A"




function data_event(name,data)

	datastr = "s20="..data

	if string.find(data,min_00) then            
		datastr = "Delay:delay00;"
			delay00 = alloff
	end
	
	if string.find(data,min_10) then            
		datastr = "Delay:delay10;"
			delay10 = allon
	end

	if string.find(data,min_20) then            
		datastr = "Delay:delay20;"
			delay20 = alloff
	end

	if string.find(data,min_30) then            
		datastr = "Delay:delay30;"
			delay30 = allon
	end

	if string.find(data,min_40) then            
		datastr = "Delay:delay40;"
			delay40 = alloff
	end
	
	if string.find(data,min_50) then            
		datastr = "Delay:delay50;"
			delay50 = allon
	end
	
	return datastr
end

data_event(data,"3A32303A")
print(datastr)

function button_event(join,value)
	buttonstr1 = ''
	buttonstr2 = ''
	--====發送按鈕同步/delay指令====--
--=============================================================================================================================================================================================================
	--====發送設備控制碼====--
	if join == 777 and value == 1 then
	buttonstr1 = send48c.."'"..'{"cmd_header":"hscmd-get-system-time","cmd_body":{ "english":"y"}}'.."'"
	end

	buttonstr = buttonstr1..buttonstr2
	return buttonstr
end
button_event(777,1)
print(buttonstr)