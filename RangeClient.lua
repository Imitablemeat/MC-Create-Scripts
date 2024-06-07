local mo = peripheral.find("modem")
 
 
mo.open(100)


while true do
	local eventData = {os.pullEvent()}
	local event = eventData[1]
	if event == "modem_message" then
		mo.transmit(eventData[4], 100, tostring("Pong " .. math.floor(eventData[6])))
		print("Pong " .. math.floor(eventData[6]))
	end
end



    

