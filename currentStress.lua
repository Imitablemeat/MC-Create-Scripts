local modem = peripheral.wrap("left") or error("Modem not found!")
local DA = peripheral.find("digital_adapter")
modem.open(9)
 
print("Awaiting request ...\n")
 
while true do
    --os.startTimer(.5)
    local event = {os.pullEvent()}
    --print(tostring(event[1]))
    if event[1] == "modem_message" then
        print(tostring(event[5]))
        local stress = DA.getKineticStress("west")
        local capacity = DA.getKineticCapacity("west")
        local utilization = math.floor(stress/capacity*100)
        local totalWheels = capacity/512
        local stats = tostring("Total Capacity: " .. capacity .. "\nTotal Stress: " .. stress .. "\nUtilization: %" .. utilization .. "\nTotal Wheels: " .. totalWheels)
        local response = tostring("#" .. event[4] .. "#" .. stats)
        modem.transmit(1000, os.getComputerID(), response)
        print("sent stats to " .. event[4])
    end
    
end 
