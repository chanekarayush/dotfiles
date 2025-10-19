return{
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      filetypes = { "*" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        css = true,
        css_fn = true,
        tailwind = true, -- if you use tailwindcss
        mode = "background", -- "virtualtext" for blocks
      },
    })
  end,
}

