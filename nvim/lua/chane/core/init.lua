-- require 
require("chane.core.remap")
require("chane.core.options")
-- config profile chane
--print("Loaded config profile chane")
-- Function to create a dynamic bar loader animation
local function barLoader()
    local terminalWidth = vim.api.nvim_get_option('columns')
    local barLength = math.floor(terminalWidth * 0.95)  -- Set bar length to 60% of terminal width
    local delay = 0.001                                  -- Delay in seconds (adjust as needed)

    for i = 1, barLength do
        local progress = string.rep("=", i)            -- Filled part of the bar
        local empty = string.rep(" ", barLength - i)   -- Empty part of the bar

        io.write("\r[" .. progress .. empty .. "] " .. math.floor((i / barLength) * 100) .. "%")  -- Display bar and percentage
        io.flush()                                     -- Update the display
        vim.wait(delay * 1000)                         -- Wait for the delay in milliseconds
    end
    print("\nLoading complete!")
end

barLoader()





