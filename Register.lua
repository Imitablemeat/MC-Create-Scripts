--Run on device with wireless modem attached to connect to dedicated Router device running Router.lua to register device

local mo = peripheral.find("modem")
mo.open(os.getComputerID())
mo.transmit(1000, os.getComputerID(), tostring("#" .. os.getComputerLabel() .. "#register"))
