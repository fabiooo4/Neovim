filetype plugin indent on
syntax enable

set conceallevel=1
let g:tex_conceal='abdmg'

let g:vimtex_view_method = 'sioyek'
let g:vimtex_view_sioyek_exe = 'sioyek.exe'
let g:vimtex_callback_progpath = 'wsl nvim'

nmap <leader>tc :VimtexTocToggle<CR>
