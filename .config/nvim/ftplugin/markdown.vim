setlocal spell
set complete+=kspell

set textwidth=0

" md-img-paste.vim keybindings
nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = '/'
