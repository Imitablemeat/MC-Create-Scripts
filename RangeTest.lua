local mo = peripheral.find("modem")
 
 mo.open(100)
 
local loop = 5
local timeout = 5

while loop ~= 0 do
    sleep(2)
    mo.transmit(100, 100, "ping")
    print("Ping " .. textutils.formatTime(os.time()))
	timeout = 5
	os.startTimer(3)
	if timeout ~= 0 then
		local eventData = {os.pullEvent()}
		local event = eventData[1]
	else
		loop = 0
		
    	if event == "modem_message" then
			print(tostring(eventData[5]))
			loop = loop - 1
			
		else 
			timout = timeout -1
			print("No Response " .. textutils.formatTime(os.time()))
			
		end
	end
end

