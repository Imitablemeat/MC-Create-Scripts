local mo = peripheral.find("modem") -- "modem" is agnostic, will work for wired, wireless, and ender modems

mo.open(100) -- open port 100 I will make it my network routing port
print("Listening on port 100")
 
local loop = 5
local timeout = 5
local close = false

while loop ~= 0 do
    sleep(2)
    mo.transmit(100, 100, "ping")
    print("Ping " .. textutils.formatTime(os.time()))
	timeout = 5
	os.startTimer(3) -- timer required, else pullEvent will stick waiting for next event
	if timeout ~= 0 then
		local eventData = {os.pullEvent()} --event data is event str, side str, channel int, replyChannel int, message str, distance float. Index starts at 1
		local event = eventData[1]
		
    	if event == "modem_message" then
			print(tostring(eventData[5]))
			loop = loop - 1
			
		else 
			timout = timeout - 1
			print("No Response " .. textutils.formatTime(os.time()))

		if timeout == 0 then
				loop = 0
			end
		end
	end
end

-- alert remote client that ping is complete and to close port, will receive confirmation that it's closed and then we can close ours
while close == false do
	mo.transmit(100, 100, "endping") --endping hardcode response to close remote connection
	print("Closing Remote Port....")
	os.startTimer(1)
	if close == false then
		local eventData = {os.pullEvent()}
		if eventData[1] = "modem_message" then
			if eventData[5] == "true" then
				close = true
			end
		end
	end
end
		

mo.close(100) -- close at end so future pings don't involve this device
print("Remote port 100 closed")



