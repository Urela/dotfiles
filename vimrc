call plug#begin('~/.vim/plugged')

   Plug 'itchyny/lightline.vim' "A light statusline/tabline 
   Plug 'vimwiki/vimwiki' " My mind
   Plug 'lervag/vimtex'    "latex syntax highlighting
   Plug 'xuhdev/vim-latex-live-preview' "latex live preview

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
call plug#end()

" ######### plugins setting ######### 
 
"Pandoc vim-latex-live
"let g:vimtex_view_method = 'zathura' 
let g:livepreview_previewer = 'zathura' 
let vim_markdown_preview_browser='chromium'

noremap Zz <c-w>_ \| <c-w>\|
noremap Zo <c-w>=

set background=dark

"set number
set relativenumber

" to prevent lag when switch modes
set ttimeoutlen=50

"toggle past mode
set pastetoggle=<F2>

" auto indents
"set autoindent

" change pythons indenting from 4 spaces to 2 spaces
let g:python_recommended_style = 0
filetype plugin indent on
syntax on

"Convert tabs to 2 spaces"
set tabstop=2 shiftwidth=2 expandtab 

" For clever completion with the :find command
set path+=**

" Always use bash syntax for sh filetype
let g:is_bash=1

set t_Co=256
let &t_ut=''
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Important for colorschemes
nmap <F5> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc ```


" ######################################
" ### theme and statusline
" ######################################

" for status
set laststatus=2
set noshowmode
"let g:lightline = {'colorscheme': 'jellybeans',} 
"let g:lightline = {'colorscheme': 'simpleblack',}
"let g:lightline = {'colorscheme': 'deus',} 
"let g:lightline = {'colorscheme': 'seoul256',} 
let g:lightline = {'colorscheme': 'one',}  " for space_vim_dark
"let g:lightline = {'colorscheme': 'onedark',}
"let g:lightline = { 'colorscheme': 'palenight' }

" let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_list = [{'path': '~/niani/', 'syntax': 'markdown', 'ext': '.md'}]
au FileType vimwiki setlocal shiftwidth=2 tabstop=2 expandtab

command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end

function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map cal :call ToggleCalendar()
