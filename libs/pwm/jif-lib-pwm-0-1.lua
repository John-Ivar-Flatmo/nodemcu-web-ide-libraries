--this is a pulse width modulation library for esp32 running nodemcu
--requires | time | events |
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
if PWMpins[pin].triggers == PWMpins[pin].frequency then
PWMpins[pin].triggers = 0
if PWMpins[pin].state == 0 then
print("off")
gpio.write(pin, 0)
PWMpins[pin].state = 1
else --if state 0
print("on")
gpio.write(pin, 1)
PWMpins[pin].state = 0
end --if state 1
end --if trigg
PWMpins[pin].triggers = PWMpins[pin].triggers+1
print("triggers: "..PWMpins[pin].triggers)
if PWMpins[pin].running == true then
print("running")
--node.task.post(function () PWM.delay((100000/PWMpins[pin].frequency),(function () PWM.task(pin) end))end)
else --if running end

end --else running end
end --PWM.task

function PWM.config (pin,conf)
PWMpins[pin] = {}
PWMpins[pin].frequency = conf.frequency
PWMpins[pin].drive = conf.drive
PWMpins[pin].running = true
PWMpins[pin].triggers = 0
PWMpins[pin].delay = PWMpins[pin].frequency*PWMpins[pin].drive
PWMpins[pin].state = 0

gpio.config({
  gpio=pin,
  dir=gpio.OUT,
  opendrain=0,
  pull=gpio.PULL_UP_DOWN
})

PWM.task(pin)
end --PWM.config

function PWM.stop (pin)
PWMpins[pin].running = false
end --PWM.stop

function PWM.time (delay,start,func)
sec, msec = time.get()
--print("time: "..start.."/"..msec)
if start+delay > msec then PWM.delay(delay,func)
else --wait
func()
end --done
end --PWM.time

function PWM.delay (delay,func)
print("delay: "..delay)
sec, msec = time.get()
PWM.time(delay,msec,func)
end --PWM.delay 

PWM.config(15,{
frequency = 10,
drive = 0.5
})
