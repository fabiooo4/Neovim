return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	init = function()
		-- VimTeX configuration goes here
		vim.cmd([[
      filetype plugin indent on
      syntax enable

      set conceallevel=1
      let g:tex_conceal='abdmg'

      if has('win32') || (has('unix') && exists('$WSLENV'))
          if executable('sioyek.exe')
              let g:vimtex_view_method = 'sioyek'
              let g:vimtex_view_sioyek_exe = 'sioyek.exe'
              let g:vimtex_callback_progpath = 'wsl nvim'
          elseif executable('mupdf.exe')
              let g:vimtex_view_general_viewer = 'mupdf.exe'
          elseif executable('SumatraPDF.exe')
              let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
          endif
      else
          let g:vimtex_view_method = 'sioyek'
          let g:vimtex_view_sioyek_exe = '/var/lib/flatpak/app/com.github.ahrm.sioyek/x86_64/stable/c4cccd0d3e5b15bff643edda3d5cffff0b3b0cad2bbfacea3b863ab48be9e43a/files/sioyek/sioyek'
      endif

      nmap <leader>tc :VimtexTocToggle<CR>

      " Inkscape integration by Gilles Castell:
      " https://github.com/gillescastel/

      " Enable mappings only for LaTeX files
      autocmd FileType tex inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
      autocmd FileType tex nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
    ]])
	end,
}
