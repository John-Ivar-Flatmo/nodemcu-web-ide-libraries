--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--require

--require
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--settings

--settings
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--vars
UTIL = {}
--vars
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--events

--events
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--funcitons
function tableCount (table)
local tcCount = 0
for index in pairs(table) do
tcCount = tc-count+1
end --count pairs
return tcCount
end --tableCount

function jsonParse (string)

end --jsonParse

function jsonStringify (string)

end --jsonstringify

function UTIL.round (num) --NOTE IMPLEMENT rounding factor
return (num-(num % 1))
end --UTIL.round

function UTIL.clamp (num,down,up)
if down > num then
return down
elseif num > up then--if down > num
return up
else --if num > up
return num
end --if num fine
end --UTIL.clamp

function wifiConnect (wCfg)
ssid = wCfg.station.ssid
pass = wCfg.station.pass
ssidAp = wCfg.ap.ssid
passAp = wCfg.ap.pass
wifi.sta.on("connected", function()
print("connected to: "..ssid.."(NO IP)")
end)
wifi.sta.on("got_ip", function(event, inf) 
print("connected to: "..ssid.." with ip: "..inf.ip)
end)

if wCfg == nil then
print("ERR wifi config missing")
else
print("ip requested: "..wCfg.station.ip)
wifi.sta.setip(wCfg.station)
end
--wifi.start()
if wCfg.mode == "station" then
--wifi.setphymode(wifi.PHYMODE_N); --low range high transfer low power
wifi.mode(wifi.STATION)
else--station
--wifi.setphymode(wifi.PHYMODE_G); --medium range medium transfer medium power
end --station
if wCfg.mode == "stationap" then
wifi.mode(wifi.STATIONAP)
end --stationap

if wCfg.mode == "ap" then
wifi.mode(wifi.SOFTAP)
end --stationap

wifi.start()
if wCfg.mode == "station" or wCfg.mode == "stationap" then
print("connecting to: "..ssid)
wCfgSta = {}
wCfgSta.ssid = wCfg.station.ssid
wCfgSta.pwd = wCfg.station.pass
wCfgSta.auto = wCfg.station.auto
wCfgSta.save = wCfg.station.save
wifi.sta.config(wCfgSta)
--wifi.sta.connect() --not needed since auto connect
end --station/stationap

if wCfg.mode == "ap" or wCfg.mode == "stationap" then
wCfgAp = {}
wCfgAp.ssid = wCfg.ap.ssid
wCfgAp.pwd = wCfg.ap.pass
wCfgAp.hidden = wCfg.ap.hidden
wCfgAp.max = wCfg.ap.max
wCfgAp.auth = wCfg.ap.auth
wCfgAp.save = wCfg.ap.save
wifi.ap.config(wCfgAp)
end --ap/stationap

end --wifiConnect
--functions
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--runtime

--runtime
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
