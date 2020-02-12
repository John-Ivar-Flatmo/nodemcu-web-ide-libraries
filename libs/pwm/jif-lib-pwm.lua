--this is a pulse width modulation library for esp32 running nodemcu
--requires | jif-lib-time |
--essensialy it does math so you dont have to
--all variables have the prefix PWM so that it can be directly manipulated if desired


--library function explainations
--frequency = 10 --total amount of triggers per secound
--drive = 0 --percentage of triggers that output

--var
PWM = {}
PWMpins = {}

--func

function PWM.task (pin)
if PWMpins[pin].triggers == PWMpins[pin].delay then
PWMpins[pin].triggers = 0
if PWMpins[pin].state == 0 then
--print("off")
gpio.write(pin, 0)
PWMpins[pin].state = 1
else --if state 0
--print("on")
gpio.write(pin, 1)
PWMpins[pin].state = 0
end --if state 1
--print("trigg 1")
end --if trigg
PWMpins[pin].triggers = PWMpins[pin].triggers+1
--print("triggers: "..PWMpins[pin].triggers.."/"..PWMpins[pin].delay)
--print("trigg 0")
end --PWM.task

function PWM.stop (pin)
time.stop(PWMpins[pin].timer)
end --PWM.stop

function PWM.update (pin,config) --runs stop(pin) then config(config)
PWM.stop(pin)
PWM.config(pin,config)
end --PWM.update

function PWM.config (pin,conf)
if(conf.drive > 0) then
PWMpins[pin] = {}
PWMpins[pin].frequency = conf.frequency
PWMpins[pin].drive = conf.drive
PWMpins[pin].triggers = 0
PWMpins[pin].delay = math.floor(1/PWMpins[pin].drive)
PWMpins[pin].state = 0

gpio.config({
  gpio=pin,
  dir=gpio.OUT,
  opendrain=0,
  pull=gpio.PULL_UP_DOWN
})

PWMpins[pin].timer = time.interval(math.floor(1000/PWMpins[pin].frequency),function() return PWM.task(pin) end)
end --conf > 0
end --PWM.config
