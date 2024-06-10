local modem = peripheral.find("modem")
modem.open(os.getComputerID())
modem.transmit(1000, os.getComputerID(), "#WaterMill#status")
 
local event, side, channel, replyChannel, messaage, distance
repeat
    event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    until channel == os.computerID()
    
    print("Receiving...\n" .. tostring(message))
