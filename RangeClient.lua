local mo = peripheral.find("modem")
 
 
mo.open(100)

local event, channel, replyChannel, message, distance = os.pullEvent("modem_message")
mo.transmit(replyChannel, 100, tostring(distance))
print("Pong" .. distance)

    

