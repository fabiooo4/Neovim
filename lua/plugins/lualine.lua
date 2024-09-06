return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      sections = {
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 4,
          },
        },
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
