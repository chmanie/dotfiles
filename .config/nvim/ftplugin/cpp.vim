let g:clang_format#style_options = {
            \ "IndentPPDirectives" : "BeforeHash"}

" Formatting buffer.
nnoremap <Leader>f :<C-u>ClangFormat<CR>
