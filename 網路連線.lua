sendipad    = "send_command sendipad:"	      --192.168.0.201
sendandroid = "send_command sendandroid:"	  --192.168.0.200


function ViewComboOut(ComboTable)
	for _, item in ipairs(ComboTable) do
		print("", item.command)
	end
end


function data_event(name,data)
   datastr=''
   
   if string.find(data, 'connect') == 1 then   	--如果ipad或android有連線到路由器
		datastr="Delay:connect;"
		connect = {
		{command = "d10=1,d20=0",time = "1"}, 		--連線成功顯示綠燈
		{command = "d10=0,d20=1",time = "5000"}, 	--連線成功顯示綠燈
		}
	end
   
	if string.find(data, 'wifi_connected') == 1 then   --如果ipad或android有連線到路由器
		datastr = "Stop:click;"		--暫停延遲避免開啟網路異常頁面
	end
	if string.find(data, 'connect') == 1 then    --如果ipad或android有連線到路由器
	datastr="Delay:connect;"
	connect = {
		{command = "d10=1,d20=0",time = "1"},   --連線成功顯示綠燈
		{command = sendipad.."'ok'",time = "1000"},  --連線成功顯示綠燈
		{command = "d10=0,d20=1",time = "5000"},  --連線成功顯示綠燈
	}
	end
 
	if string.find(data, 'ok') == 1 then   --如果ipad或android有連線到路由器
	datastr = "Stop:connect;"  --暫停延遲避免開啟網路異常頁面
	end
	return datastr
end

function button_event(join,value)
	buttonstr = ''
	buttonstr1 = ''		--互鎖同步
	buttonstr2 = ''		--網路同步
	buttonstr3 = ''		--控制碼
	
	if join > 0 and join < 10000 then	--發送給需要同步的平板
		buttonstr1 = sendipad.."'".."click"..join.."'"..sendandroid.."'".."click"..join.."'"	--發送互鎖同步
	end	
	
	if join > 0 and join < 10000 and value == 0 then
		buttonstr2="Delay:click;"
		click = {
		{command = sendipad.."'wifi_connected'"..sendandroid.."'wifi_connected'",time = "1"}, --發送網路同步
		{command = sendipad.."'wifi_connected'"..sendandroid.."'wifi_connected'",time = "100"}, --連續發送避免丟包
		{command = sendipad.."'wifi_connected'"..sendandroid.."'wifi_connected'",time = "500"}, --連續發送避免丟包
		{command = "p888=1",time = "5000"}, --跳頁至網路異常頁面
		}
	end
	
	if join == 800 and value == 1 then		--斷線時重新發送同步
		buttonstr3 = sendipad.."'wifi_connected'"..sendandroid.."'wifi_connected'"		--發送網路同步
	end


	
	
	buttonstr = buttonstr1..buttonstr2..buttonstr3
	return buttonstr

end

button_event(10,1)
print(buttonstr)
