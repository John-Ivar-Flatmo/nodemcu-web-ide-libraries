--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--require
server = {}
--require
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--settings
server.port = 80
--settings
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--vars
console = "console start \n"
files = "";
--html plan, 1 page file browser on left controll buttons on top editor rest of page
htmlIndex = [=[
<!DOCTYPE html>
<html>
<head>
<title>Index</title>
</head>
<div class="gridContain">
<div class="gridMenu"> <!-- Menu bar -->
<button class="butt-def" id="butt-restart" type="button">
Restart
</button>
<button class="butt-def" id="butt-browse" type="button">
Browse
</button>
<button class="butt-def" id="butt-delete" type="button">
Delete
</button>
<button class="butt-def" id="butt-load" type="button">
Load
</button>
<button class="butt-def" id="butt-save" type="button">
Save
</button>
<button class="butt-def" id="butt-run" type="button">
Run
</button>
<textarea id="fileName" placeholder="FILE.EXTENSTION" rows="1" cols="20"></textarea>

<!-- Network menu -->
<textarea id="wifissid" placeholder="WIFI SSID" rows="1" cols="30"></textarea>
<textarea id="wifipass" placeholder="WIFI PASS" rows="1" cols="20"></textarea>
<button class="butt-def" id="butt-disconnect" type="button">
Disconnect
</button>
<button class="butt-def" id="butt-connect" type="button">
Connect
</button>

</div> <!--gridMenu -->
<div class="gridBrowse"> <!-- File browser -->
DELETE ME
</div> <!--gridBrowse -->
<div class="gridEdit"> <!-- Editing area -->
<textarea class="texta-full" id="texta-edit" rows="10" cols="50"></textarea>
</div> <!--gridEdit -->
<div class="gridConsole"> <!-- Editing area -->
<textarea class="texta-full" id="texta-console" rows="10" cols="50"></textarea>
<button class="butt-def" id="butt-refresh" type="button">
Refresh
</button>
</div> <!--gridConsole -->
</div> <!--gridcontain -->
<style>
html {
margin: 0;
min-height: 100%;
background-color: rgb(100,100,100);
}
body {
margin: 0;
min-height: 100%;
}
.gridContain {
display: grid;
margin: 0;
min-height: 100%;
grid-template-columns: 10% 10% 10% 10% 10% 10% 10% 10% 10% 10%;
}
.gridMenu {
grid-column-start: 1;
grid-column-end: 10;
grid-row-start: 1;
grid-row-end: 1;
}
.gridBrowse {
grid-column-start: 1;
grid-column-end: 1;
grid-row-start: 2;
grid-row-end: 10;
}
.gridEdit {
grid-column-start: 2;
grid-column-end: 10;
grid-row-start: 2;
grid-row-end: 5;
}
.gridConsole {
grid-column-start: 2;
grid-column-end: 10;
grid-row-start: 6;
grid-row-end: 10;
}

.texta-full {
width: 100%;
height: 100%;
}
textarea {
background-color: rgb(80,80,80);
color: rgb(150,150,150)
}
</style>
<script>
//var

//var end
//functions
function loadFile (filName) {

};
function saveFile () {
xmlReq = new XMLHttpRequest();;
xmlReq.open("POST", window.location.href, true);
xmlReq.setRequestHeader("Content-Type", "application/json");
xmlReq.send(JSON.stringify({
"funcSaveFile": "true",
"file": document.getElementById("fileName").value, //name of file the text shuld be saved to
"cont": document.getElementById("texta-edit").value //actuall code/text to send to server
})); //object end
}; //saveFile end

function runFile () {
xmlReq = new XMLHttpRequest();
xmlReq.open("POST", window.location.href, true);
xmlReq.setRequestHeader("Content-Type", "application/json");
xmlReq.send(JSON.stringify({
"funcRunFile": "true",
"file": document.getElementById("fileName").value, //name of file the text shuld be saved to
})); //object end
}; //runFile end

function refreshConsole () {
//document.getElementById("texta-console").value = "refreshing"
xmlReq = new XMLHttpRequest();
xmlReq.open("POST", window.location.href, true);
xmlReq.setRequestHeader("Content-Type", "application/json");
xmlReq.onreadystatechange = function() {
if (xmlReq.readyState === 4) {
document.getElementById("texta-console").value = xmlReq.response;
}; //stat = 4
}; //state change
xmlReq.send(JSON.stringify({
"funcRefreshConsole": "true"
})); //object end
}; //refreshConsole end

function restart () {
xmlReq = new XMLHttpRequest();
xmlReq.open("POST", window.location.href, true);
xmlReq.setRequestHeader("Content-Type", "application/json");
xmlReq.send(JSON.stringify({
"funcRestart": "true"
})); //object end
}; //restart end

function deleteFile () {
xmlReq = new XMLHttpRequest();
xmlReq.open("POST", window.location.href, true);
xmlReq.setRequestHeader("Content-Type", "application/json");
xmlReq.send(JSON.stringify({
"funcDeleteFile": "true",
"file": document.getElementById("fileName").value, //name of file that shuld be deleted
})); //object end
}; //deleteFile end

function disconnect () {

}; //disconnect

function connect () {

}; //connect

//functions

//events
document.getElementById("butt-restart").addEventListener("click",restart);
document.getElementById("butt-save").addEventListener("click",saveFile);
document.getElementById("butt-load").addEventListener("click",loadFile);
document.getElementById("butt-delete").addEventListener("click",deleteFile);
document.getElementById("butt-run").addEventListener("click",runFile);
document.getElementById("butt-disconnect").addEventListener("click",disconnect);
document.getElementById("butt-connect").addEventListener("click",connect);
document.getElementById("butt-refresh").addEventListener("click",refreshConsole);

//events
//intervals
//setInterval(function(){refreshConsole()},1000);
//intervals

</script>
</html>

]=]



--vars
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--functions

function updateFiles ()
fils = file.list()
for nam,siz in pairs(fils) do
files = (files.."\n"..nam)
end --for end
end --updateFiles end
function startHttpEditor ()
server.server = net.createServer()
srv = server.server
srv:listen(server.port, function(conn)
conn:on("receive",function(sock, data)
function sockClose()
sock:close()
end
print(data) --DEBUG
--dat = sjson.decode(data) --write streaming json parser for efficeint memory use, and to reomve  dependency on sjson
--dat = {}
--local jDecoder = sjson.decoder()
--jDecoder:write(data)
--decoded = false
--while decoded == false do --this while loop can be optomized but i dident have time
--if pcall(jDecoder.result()) then
--dat = jDecoder.result()
--decoded = true
--else--decoded
----do nothing
--end --decoded not
if string.find(data,"GET") ~= nil then
print("GET")
if sock == nil then
print("ERROR f jif-browsercode l startHttpEditor s sock = nil") else
--sock:send("HTTP/1.1 200 OK\r\n\r\nOK") --test line if htmlIndex stops working to see if code is the issue
sock:on("sent",sockClose)
sock:send(htmlIndex)
end --sock nil else end

print("checking for non json data")
if string.find(data,"{") then
dataJsonStart = string.find(data,"{")
print("dataJsonStart: "..dataJsonStart) --debug
dataJsonEnd = string.find(data,"}")
print("dataJsonEnd: "..dataJsonEnd) --debug
dataJson = string.sub(data,dataJsonStart,DataJsonEnd)
print("dataJson: "..dataJson) --debug
dat = sjson.decode(dataJson)

end --json data

--else
--print("NOGET")
end--get end

if string.find(data,"POST") ~= nil then
print("POST")

print("checking for non json data")
if string.find(data,"{") then
dataJsonStart = string.find(data,"{")
print("dataJsonStart: "..dataJsonStart) --debug
dataJsonEnd = string.find(data,"}")
print("dataJsonEnd: "..dataJsonEnd) --debug
dataJson = string.sub(data,dataJsonStart,DataJsonEnd)
print("dataJson: "..dataJson) --debug
dat = sjson.decode(dataJson)
if dat.funcSaveFile == "true" then
if dat.file ~= nil and dat.cont ~= nil then
if file.open(dat.file,"w+") then --w+ is file write mode that replaces existing content
file.write(dat.cont)
file.close()
end --file open data.file
end --file/cont ! nil
sock:on("sent",sockClose)
sock:send("HTTP/1.1 200 OK\r\nServer: NodeMCU on ESP32\r\n\r\n");
end --funcsavefile ! nil

if dat.funcRefreshConsole == "true" then
print("FUN refreshConsole: sending var console");
consl={}
consl.console = console
cons = sjson.encode(consl)
sock:on("sent", sockClose)
sock:send("HTTP/1.1 200 OK\r\nServer: NodeMCU on ESP32\r\nAccept-Ranges: bytes\r\nContent-Type: application/json\r\nContent-Lnegth: "..string.len(cons).."\r\n\r\n"..cons);
end --funcRefreshConsole

if dat.funcRunFile == "true" then
print("FUN RunFile: running: "..dat.file);
dofile(dat.file);
sock:on("sent",sockClose)
sock:send("HTTP/1.1 200 OK\r\nServer: NodeMCU on ESP32\r\n\r\n");
end --funcRunFle

if dat.funcDeleteFile == "true" then
print("FUN DeleteFile: running: "..dat.file);
file.remove(dat.file);
sock:on("sent",sockClose)
sock:send("HTTP/1.1 200 OK\r\nServer: NodeMCU on ESP32\r\n\r\n");
end --funcDeleteFle

if dat.funcRestart == "true" then
print("FUN Restart: running: ");
sock:on("sent",sockClose)
sock:send("HTTP/1.1 200 OK\r\nServer: NodeMCU on ESP32\r\n\r\n"); --has to be ran before reset command so that it is executed.
node.restart();
end --funcRestart

end --json data
--else --post else
--print("NOPOST")
end--post end

end) --conn on recive end
end) --listen end
end --startHttpEditor end
--funcitons
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--events

--events
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--runtime
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--editor

--editor
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--runtime
print("jif-browsercode.lua started")
updateFiles()
print("jif-browsercode.lua waiting for ip")
wifi.sta.on("got_ip", function(event, inf) 
print("connected with ip: "..inf.ip)
startHttpEditor();
end)


--runtime
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--
--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--

