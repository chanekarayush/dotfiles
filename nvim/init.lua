require("chane.core")
require("chane.lazy")
-- require('nvim-treesitter.install').compilers = {'zig'}

-- Function to center and print the table
local function centerPrintTable(table)
    local screenWidth = vim.api.nvim_get_option('columns')
    local screenHeight = vim.api.nvim_get_option('lines')
    local ypad = math.floor(screenHeight/2)
    --print(string.rep("", ypad))
    for _, line in ipairs(table) do
        local xpad = math.floor(screenWidth / 3)
        print(string.rep(" ", xpad) .. line)
    end
    print(string.rep("\n", ypad))
end

-- Example table
header_title_screeen = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
}

-- Call the function to print the centered header
centerPrintTable(header_title_screeen)

print("Welcome to NeoVim!")
