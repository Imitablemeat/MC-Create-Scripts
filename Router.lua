local modem = peripheral.find("modem")
local rtport = 1000
 
modem.open(rtport) -- traffic routing port
 
 
local function writeIP(label, id) -- writes new label/service and id to table
    local file = io.open("iptable", "a+")
    file:write(tostring(label .. "#" .. id .. "\n"))
    print("Registered " .. label .. id)
    file:close()
end
 
local function fetchIP(label) -- grabs listed id of given label/service and returns id or false if it does not exist
    local file = io.open("iptable","r")
    if not file then
        print("Error opening file.")
        return false
    end
    for line in file:lines() do
        line = line:gsub("\n","")
        if line:match("^" .. label:gsub("%-", "%%-") .. "#%d+$") then
            local id = line:match("#(%d+)$")
            file:close()
            return id
        end
    end
    file:close()
    return false
end
 
while true do
    local event = {os.pullEvent()}
    os.setAlarm(.5)
    if event[1] == "modem_message" then
        local request = tostring(event[5])
        local label, message = request:match("#([%w^#]+)#(.+)")
        local result = fetchIP(label)
        if result == false then
            if message == "register" then
                writeIP(label, event[4])
                modem.transmit(event[4], rtport, "Device/Service registered as " .. event[4])
            else
                modem.transmit(event[4], rtport, "Device/Service " .. label .. " is not registered, please check the iptable on the router!")
            end    
        else
            modem.transmit(tonumber(result), event[4], message)
            print("Successfully routed packet from computer " .. event[4] .. " to computer " .. result .. " with message:\n" .. message)
        end
    end
end
 
