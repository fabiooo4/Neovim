return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",            -- Image support in preview window
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "current",
        mappings = {
          ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
        },
      },
    })

    -- keymaps
    vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle right<CR>", {})
  end,
}
