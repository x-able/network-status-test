send48cs = "send_command send48cs:"
earthquake = "send_command earthquake:"
ipad = "send_command ipad:"
localpanel = "send_command localpanel:"

local MODwallid = "'"..'{"cmd_header": "hscmd-video-wall-scene-call","cmd_body": {"WallID": "'
local MODscene = '","SceneName":"'
local MODend = '"},"cmd_end" :{"Operator":"admin","Token": 0,"Err_code" : "0","Err_str" : ""}}'.."'"
--使用方法 MODwallid..電視牆id..MODscene..場景名稱..MODend
--WallID 對應電視牆ID (電視牆1,電視牆2...) SceneName對應場景名稱
local connectstat = 0

--心跳指令
local tcpheartbeat = '{"json_header": "hscmd-client-heartbeat-tcp","format": {}}'


--[[
local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("dkjson") -- 使用 dkjson 來解析 JSON，需先安裝 dkjson 模組



-- NewsAPI 的 URL
local url = "https://newsapi.org/v2/everything?q=tesla&from=2024-10-20&sortBy=publishedAt&apiKey=e82644755e1f4c48ab14e9b36463b737"

-- 保存 HTTP 回應
local response_body = {}
local _, status_code = http.request{
    url = url,
    sink = ltn12.sink.table(response_body)
}

-- 確認請求是否成功
if status_code == 200 then
    local response_json = table.concat(response_body) -- 將回應數據轉換成字符串
    local data, _, err = json.decode(response_json) -- 解析 JSON 數據

    if err then
        print("Error decoding JSON:", err)
    else
        -- 打印所有新聞的標題
        for _, article in ipairs(data.articles) do
            str = "s5678="..article.title
        end
    end
else
    print("HTTP request failed with status code:", status_code)
return str
end


local cmdhead = {		
[1]='hscmd%-video%-wall%-win%-get',   --視窗查詢 
[2]='hscmd%-server%-heartbeat%-tcp'	  --心跳指令
}

]]

--[[
function Input(text)
	if(text=="語音測試")then
	str="s20=密碼正確"
	else 
	str = "s20=密碼錯誤"
	end
	return str
end
]]


function data_event(name,data)
	datastr = "s20="..data
	
	
	if string.find(data,'connect') then
		datastr = ipad.."d200=1,s201=已連線,d300=0"
	end
	

	--[[
	
	if name =="earthquake" then
		redata = cjson.decode(data)
		datastr = "s5678="..redata.title
	end
	
	
	if string.find(data,cmdhead[2]) then
		datastr = send48cs..tcpheartbeat
	end


--==大屏回顯==--




--預覽畫面join id 需跟 設備id相同;編碼器預覽畫面join id +1000--
if name =="send48cs" then
	redata = cjson.decode(data)
	--datastr = "s20="..redata.cmd_body.Walls[1].Windows[1].TxID
	
	
	if redata ~= nil then
		local VedioList = redata.cmd_body.Walls[1].Windows
		VedioFileNum = #VedioList
		if redata.cmd_body.Walls[1].WallID == "1" then
		
			
			for i = 1, VedioFileNum do
			local win_tx = redata.cmd_body.Walls[1].Windows[i].TxID
			if tostring(win_tx):sub(1, 1) == "0" then
				win_tx = win_tx + 1000
			end
			datastr = datastr .. "v10" .. i .. "=" .. win_tx .. ","
			end
				
		end
	end
	
end
	if name == "ipad" then 
		datastr = "Delay:connect;"
		connect = {
		{command = "d200=1,s201=已連線",time = "1"},
		}
	end
	
]]

	return datastr
end



function button_event(join,value)
	buttonstr1 = ''
	buttonstr2 = ''
	if join > 0 and join < 500 then 
		buttonstr2 = "Delay:stat;"
		stat = { 
		{command = ipad.."'connect'",time = "1"},
		{command = "d200=0,s201=未連線，請檢查網路",time = "1"},
		{command = "d300=1",time = "1"},
		}
	end
	
	if join == 11 and value == 1 then
		buttonstr = send48cs..MODwallid.."1"..MODscene.."TEST1"..MODend
	end
	
	if join == 12 and value == 1 then
		buttonstr = send48cs..MODwallid.."1"..MODscene.."TEST2"..MODend
	end
	
	if join == 13 and value == 1 then
		buttonstr = send48cs..MODwallid.."1"..MODscene.."TEST3"..MODend
	end

	if join == 14 and value == 1 then
		buttonstr = send48cs..MODwallid.."1"..MODscene.."TEST4"..MODend
	end
	
	--[[
	if join == 101 and value == 0 then
		buttonstr = "Delay:stat;"
		stat = {
		{command = ipad.."'connect'",time = "1"},
		{command = "d200=0,s201=未連線，請檢查網路",time = "1"},
		}
	end
	]]
	buttonstr = buttonstr1..buttonstr2
	return buttonstr
end





