return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      sections = {
        lualine_x = {
          {
            "datetime",
            style = "%H:%M",
          },
        },
        lualine_y = { "filetype" },
        lualine_z = { "progress", "location" },
      },

      options = {
        theme = "auto",
      },

      extensions = {
        "neo-tree",
      },
    })
  end,
}
