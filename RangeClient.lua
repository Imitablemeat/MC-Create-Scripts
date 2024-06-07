local mo = peripheral.find("modem")
 
 
mo.open(100)
 
local loop = 5
while loop != 0 do
    sleep(2)
    mo.transmit(100, 100, "ping")
    print("Ping" .. textutils.formatTime(os.time()))
    local event, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    print("Pong" .. distance)
    loop -= 1
    
end
