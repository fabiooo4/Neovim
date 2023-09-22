require('mkdnflow').setup({
    mappings = {
        MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<leader>P' },
    },
    new_file_template = {
        use_template = true,
        template = [[
###### {{ academicYear }}° Anno
###### {{ date }}
# {{ title }}
]],
        placeholders = {
            before = {
                date = function()
                    return os.date("%d/%m/%Y") -- Wednesday, March 1, 2023
                end;
                academicYear = function()
                    if os.time() < os.time({year=2024, month=9, day=30}) then
                        return 1
                    elseif os.time() < os.time({year=2025, month=9, day=29}) then
                        return 2
                    else
                        return 3
                    end
                end
            },
            after = {
                filename = function()
                    return vim.api.nvim_buf_get_name(0)
                end
            }
        }
    }
})
