--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--require

--require
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--settings
--wifi settings
wCfg={}
wCfg.mac="" --leave empty:"" for default/auto detect
wCfg.mode="stationap"
--wifi station settings
wCfg.station={}
wCfg.station.ssid="WIFISSID"
wCfg.station.pass="WIFIPASS"
wCfg.station.ip="192.168.1.80"
wCfg.station.netmask="255.255.255.0"
wCfg.station.gateway="192.168.1.1"
wCfg.station.dns="8.8.8.8"
--wifi ap settings
wCfg.ap={}
wCfg.ap.ssid="JIFRC"
wCfg.ap.pass="WIFIPASS" --pass must be 8 char long otherwise no pass
wCfg.ap.ip="192.168.1.1"
wCfg.ap.dhcp="false"
wCfg.ap.dns="8.8.8.8"
wCfg.ap.hidden=false
wCfg.ap.max=4 --max clients 1-4
wCfg.ap.auth=wifi.OPEN -- | wifi.OPEN(default) | wifi.WPA_PSK | wifi.WPA2_PSK | wifi.WPA_WPA2_PSK |
wCfg.ap.save=true
--settings
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--vars

--vars
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--events

--events
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--funcitons

--functions
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--runtime
print("init.lua started")
print("runtime setup")
--node.egc.setmode(node.egc.ALWAYS, 3072)
--node.egc.setmode(node.egc.ON_ALLOC_FAILURE)
print("loading libraries")
dofile("jif-lib-util.lua")
dofile("jif-lib-time.lua")
dofile("jif-lib-pwm.lua")

wifiConnect(wCfg)
print("starting web ide for remote code editing")
dofile("jif-browsercode.lua")

if pcall(dofile("app.lua")) then --launch app.lua if it exists otherwise do nothing
--ran sucessfully
else
print("no app.lua, a file by the name app.lua will be started after initialization if provided")
end
--runtime
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
