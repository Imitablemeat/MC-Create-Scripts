local mo = peripheral.find("modem")
 
 
mo.open(100)

local event, side, channel, replyChannel, distance, message = os.pullEvent("modem_message")
local 
mo.transmit(replyChannel, 100, toString("Pong" .. math.floor(distance)))
print("Pong" .. distance)

    

