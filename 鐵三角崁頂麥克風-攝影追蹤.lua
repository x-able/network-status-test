send48cs = "send_command send48cs:"
sendandroid = "send_command sendandroid:"
earthquake = "send_command earthquake:"

local send232ip = "'"..'{"json_header": "hscmd-transfer-uart-data","format": {"ip": ["'
local send232data = '"],"format":"hex","data": "'
local send232end = '"}}'.."'"
--使用方法 send232ip..盒子IP..send232data..數據/控制碼..send232end

--==================================================切換指定TX到指定RX(白鯊、劍魚V8)==========================================================
local TXheader = "'"..'{"cmd_header": "hscmd-switch-signal","cmd_body": {"user": "admin","operation":"switch","jurisdiction":"n","mode":"1x1","rxid":"","matrix": [{"txid": "'
local TXbody = '","rtp": "","port": "","ch": "vadsr","rxid": "'
local TXend = '","win":"1","type":"tx"}]}}'.."'"



--使用方法 TXheader..編碼器ID..TXbody..解碼器ID..TXend
preset = {
[1] = "8101043F0200FF",
[2] = "8101043F0201FF"
}
--[[
local preset1 = "$81,$01,$04,$3F,$02,$00,$FF"
local preset2 = "$81,$01,$04,$3F,$02,$01,$FF"
]]
local sendpreset = "8101043F0200FF"

test = send232ip.."169.254.100.1"..send232data..sendpreset..send232end
function data_event(name,data)
	datastr= "s20="..data
	
	return datastr
end


function button_event(join,value)
str = ''

return str 
end


function Input(text)
if(text=="admin")then
str="s20=密碼正確"
else 
str = "s20=密碼錯誤"
end

return str
end	

--123--123



print(datastr)














