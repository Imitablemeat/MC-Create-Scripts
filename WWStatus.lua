local modem = perpheral.find("modem")
modem.open(os.computerID())
modem.transmit(15, os.computerID(), "Waterwheel")

local event, side, channel, replyChannel, message, distance
repeat
  event, side, channel, replyChannel, message, distance
until channel == os.computerID()

print("Receiving...\n")
