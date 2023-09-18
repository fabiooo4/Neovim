require('sniprun').setup({
    live_mode_toggle='enable',
})

vim.keymap.set('n', '<F5>', ":let b:caret=winsaveview() <CR> | :%SnipRun <CR>| :call winrestview(b:caret) <CR>", {})
