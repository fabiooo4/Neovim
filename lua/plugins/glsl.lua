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
  end
}
