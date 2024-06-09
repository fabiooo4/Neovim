return {
  "timtro/glslView-nvim",
  config = function()
    require('glslView').setup {
      viewer_path = 'glslViewer',
      args = { '-l' },
    }

    -- Change the filetype of glsl files to glsl to apply the correct syntax highlighting
    vim.filetype.add({
      extension = {
        frag = "glsl",
        vert = "glsl",
        comp = "glsl",
        geom = "glsl",
        tesc = "glsl",
        tese = "glsl",
      }
    })

    -- Set tabstop to 4 for glsl files
    vim.api.nvim_create_augroup('setIndent', { clear = true })
    vim.api.nvim_create_autocmd('Filetype', {
      group = 'setIndent',
      pattern = { 'glsl', 'vert', 'frag', 'comp', 'geom', 'tesc', 'tese' },
      command = 'setlocal shiftwidth=4 tabstop=4'
    })
  end
}
