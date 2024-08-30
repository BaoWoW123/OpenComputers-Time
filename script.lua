local internet = require("internet")

local url = "http://worldtimeapi.org/api/timezone/America/Los_Angeles"

function getDate()
    local fetchData = internet.request(url)
    local str = ""

    -- Concatenate the response lines into a single string
    for line in fetchData do
        str = str .. line
    end

    -- Extract the ISO 8601 DateTime string using the correct pattern
    local isoStr = str:match('"datetime":"(.-)"')

    if isoStr then
        -- Extract year, month, day, hour, minute, second from the datetime string
        local year = tonumber(string.sub(isoStr, 1, 4))
        local month = tonumber(string.sub(isoStr, 6, 7))
        local day = tonumber(string.sub(isoStr, 9, 10))
        local hour = tonumber(string.sub(isoStr, 12, 13))
        local min = tonumber(string.sub(isoStr, 15, 16))
        local sec = tonumber(string.sub(isoStr, 18, 19))

        -- Create a Lua table with the extracted data
        local date_table = {
            year = year,
            month = month,
            day = day,
            hour = hour,
            min = min,
            sec = sec
        }

        -- Convert the date table into a Unix timestamp
        local timestamp = os.time(date_table)

        -- Format the timestamp into the desired string format
        local formatted_date = os.date("%B %d, %Y %I:%M:%S %p", timestamp)
        return formatted_date
    else
        print("Error: Could not extract ISO DateTime String")
    end
end


local component = require("component")
local gpu = component.gpu

-- Set a lower resolution for larger text (80x25)
gpu.setResolution(80, 25)

while true do
    -- Clear the screen
    local date = getDate()
    gpu.fill(1, 1, 80, 25, " ")

    -- Set cursor position and print the date in the middle of the screen
    local x = math.floor((80 - #date) / 2)
    local y = math.floor(25 / 2)

    gpu.set(x, y - 1, "Current Date and Time:")
    gpu.set(x, y + 1, date)

    -- Sleep for 1 second before updating
    os.sleep(1)
end


