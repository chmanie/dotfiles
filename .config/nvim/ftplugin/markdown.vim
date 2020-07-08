setlocal spell
set complete+=kspell

let b:ale_linters = ['alex', 'proselint']

" md-img-paste.vim keybindings
nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = '/'
