" Be Improved!
set nocompatible
filetype off

" Plug Configuration
" Plug 'morhetz/gruvbox'
call plug#begin("~/.local/share/nvim/plugged")
Plug 'purescript-contrib/purescript-vim'
Plug 'idris-hackers/idris-vim'
Plug 'sbdchd/neoformat'
Plug 'Yggdroot/indentLine'
Plug 'mhartington/oceanic-next'
Plug 'cocopon/iceberg.vim'
Plug 'jordwalke/vim-reasonml'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'jdsimcoe/hyper.vim'
Plug 'rakr/vim-one'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'vim-syntastic/syntastic'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'

" LanguageServer client for NeoVim.
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'neovimhaskell/haskell-vim'
Plug 'tpope/vim-commentary'
call plug#end()

let g:NERDTreeGitStatusWithFlags = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeColorMapCustom = {
    \ "Staged"    : "#0ee375",  
    \ "Modified"  : "#d9bf91",  
    \ "Renamed"   : "#51C9FC",  
    \ "Untracked" : "#FCE77C",  
    \ "Unmerged"  : "#FC51E6",  
    \ "Dirty"     : "#FFBD61",  
    \ "Clean"     : "#87939A",   
    \ "Ignored"   : "#808080"   
    \ }  

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" My Favorites
set number
set ruler
set splitright
set showmatch
set hlsearch
set incsearch
set guifont=Fira\ Code:h12
set termguicolors
syntax on
set pastetoggle=<F2>
set nobackup
set noswapfile

" Useful Maps
let mapleader=','
let maplocalleader='\'
nnoremap ; :
map <leader>z <C-w><C-w>
map <leader>h :wincmd h<CR>
nmap <silent> <leader>/ :nohlsearch<CR>
nmap <leader>s :setlocal spell! spell?<CR>
nmap <leader>wa :wqa<CR>
nmap <leader>ww :w<CR>
nmap <leader>qa :qa<CR>
nmap <leader>qq :bd<CR>

nnoremap <Leader>t :botright vertical terminal<CR>
if has('nvim')
  tnoremap<Esc> <C-\><C-n>
endif

" Tab Settings
set shiftround
set expandtab
set tabstop=2
set shiftwidth=2

" Code Block Movement
vnoremap < <gv
vnoremap > >gv

" Colorscheme
set background=dark
" colorscheme gruvbox
" colorscheme OceanicNext
" colorscheme nightfly
" colorscheme hyper
colorscheme one
syntax on
filetype plugin indent on

" NERDTree
" autocmd vimenter * NERDTree | wincmd p
nmap <leader>nt :NERDTreeToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeDirArrows = 1
let NERDChristmasTree = 1
let NERDTreeWinPos = "right"

" coc.nvim
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if executable('typescript-language-server')
  " ie. via `npm install -g typescript-language-server`
  if exists('$DEBUG_LSP_LOGFILE')
    let s:debug_args=[
          \   '--log-level=4',
          \   '--tsserver-log-file',
          \   $DEBUG_LSP_LOGFILE,
          \   '--tsserver-log-verbosity=verbose'
          \ ]
  else
    let s:debug_args=[]
  endif


  let s:ts_lsp=extend([exepath('typescript-language-server'), '--stdio'], s:debug_args)
elseif executable('javascript-typescript-stdio')
  " ie. via `npm install -g javascript-typescript-langserver`
  if exists('$DEBUG_LSP_LOGFILE')
    let s:debug_args=['--trace', '--logfile', $DEBUG_LSP_LOGFILE]
  else
    let s:debug_args=[]
  endif

  let s:ts_lsp=extend([exepath('javascript-typescript-stdio')], s:debug_args)
else
  let s:ts_lsp=[]
endif


"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


set background=dark " for the dark version
" set background=light " for the light version
colorscheme one

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use K to show documentation in preview window
nnoremap <silent> <leader>cd :call <SID>show_documentation()<CR>

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> <leader>cp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>cn <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for format selected region
nmap <silent> <leader>cf :call CocAction('format')<cr>

" Remap for do codeAction of current line
nmap <leader>ca <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>cq <Plug>(coc-fix-current)

" Restart coc
nmap <leader>cr :CocRestart<cr>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Using CocList
nmap <leader>ff :CocList list<cr>
nmap <leader>fb :CocList buffers<cr>
nmap <leader>fg :CocList grep<cr>
nmap <leader>fw :CocList words<cr>

" haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" idris-vim
let g:idris_indent_if = 3
let g:idris_indent_case = 5
let g:idris_indent_let = 4
let g:idris_indent_where = 6
let g:idris_indent_do = 3
let g:syntastic_idris_checkers=['idris']

" language-server
let g:LanguageClient_useFloatingHover=1
let g:LanguageClient_hoverPreview='Always'
let g:LanguageClient_diagnosticsDisplay={
      \   1: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
      \   2: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
      \   3: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
      \   4: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
      \ }
let g:LanguageClient_serverCommands = {
  \ 'typescript': ['javascript-typescript-stdio']
  \ }

" If you want to highlight conceal color with your colorscheme, disable by
" let g:indentLine_setColors = 0
" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]
" Change indent character
let g:indentLine_char = '│'
let g:indentLine_color_gui = '#A4E57E'
" let g:indentLine_bgcolor_term = '#FF5F00'

let g:airline_theme='one'
" call one#highlight('vimLineComment', 'cccccc', '#000000', 'none')

" vim-commentary
map <leader>gc <Plug>Commentary
