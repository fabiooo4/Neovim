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
    let g:vimtex_view_sioyek_exe = '/var/lib/flatpak/app/com.github.ahrm.sioyek/x86_64/stable/06d165f31c8c9b1fc527719bb3692115e21b0117c53bc99afc00f20b89fc6882/files/sioyek/sioyek'
endif

nmap <leader>tc :VimtexTocToggle<CR>
