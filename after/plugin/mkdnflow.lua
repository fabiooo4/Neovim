require('mkdnflow').setup({
    perspective = {
        priority = 'root',
        root_tell = 'index.md'
    },
    mappings = {
                MkdnCreateLinkFromClipboard = {{'n', 'v'}, '<leader>P'},
    }
})
