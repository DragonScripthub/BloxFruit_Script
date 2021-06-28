--getgenv().Key = "1ciFGQyHM1dI"

local http_request = http_request
if syn then 
    http_request = syn.request
elseif SENTINEL_V2 then
    http_request = request 
end
local getservice = game.GetService
local httpservice = getservice(game, "HttpService")

local function http_request_get(url, headers) 
    return http_request({Url=url,Method="GET",Headers=headers or nil}).Body 
end
local function jsondecode(json)
	local jsonTable = {}
	 pcall(function() jsonTable = httpservice.JSONDecode(httpservice,json) end)
	return jsonTable
end

local body = http_request_get('https://httpbin.org/get')
local decoded = jsondecode(body)
local hwid_list = {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint"};
local hwid = "";



for i, v in next, hwid_list do
    if decoded.headers[v] then
        hwid = decoded.headers[v];
        break
    end
end

local data = jsondecode(http_request_get("http://localhost/server.php?key="..Key))
--print (data.Hwid)
--print (hwid)
if data.Key == getgenv().Key then
    if data.Blacklist == "False" then
        if data.Hwid == hwid then
            print("Wait For Script")
            --loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
	elseif data.Hwid == "Unknown" then
         http_request_get("http://localhost/changehwid.php?key="..Key .."&hwid="..hwid)
         game.Players.LocalPlayer:Kick("\nUpdate Whitelist สำเร็จ\nรันใหม่อีกครั้ง")
        else
            game.Players.LocalPlayer:Kick("คุณพยายามรันเครื่องอื่น")
        end 
    else
        game.Players.LocalPlayer:Kick("\nKey ติด Blacklist")
    end
else
    game.Players.LocalPlayer:Kick("\nKey ผิดกรุณาติดต่อแอดมิน\nหรือ Script ดับ")
end
