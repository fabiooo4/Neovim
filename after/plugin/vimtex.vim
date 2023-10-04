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
endif
