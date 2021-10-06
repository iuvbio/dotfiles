syntax on

set guicursor=
" set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir=~/.vimdata/undo
set undofile
if has('reltime')
    set incsearch
endif
set termguicolors
set scrolloff=8
set noshowmode
set modeline

set showcmd		" display incomplete commands
set wildmenu	" display completion matches in a status line

" Show @@@ in the last line if it is truncated.
set display=truncate

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'vuciv/vim-bujo'
" apparently only works with NeoVim
" Plug '/home/mpaulson/personal/vim-apm'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'ledger/vim-ledger'
Plug 'mechatroner/rainbow_csv'
"Plug 'jpalardy/vim-slime'
"Plug 'vim-syntastic/syntastic'
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itspriddle/vim-shellcheck'
Plug 'kassio/neoterm'
Plug 'tpope/vim-surround'
"Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'nathangrigg/vim-beancount'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'Yggdroot/indentLine', { 'for': ['python', 'bash', 'sh', 'fish'] }

" colourschemes
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'ajmwagar/vim-deus'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'rakr/vim-one'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'danilo-augusto/vim-afterglow'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/edge'

call plug#end()

" set leader key
let mapleader = " "

" fix term colors
if exists('+termguicolors')
    "set t_Co=256
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

source $HOME/.config/nvim/themes/sonokai.vim

" airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabine#left_sep = ' '
let g:airline#extensions#tabine#left_alt_sep = '|'
let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|markdown|markdown.pandoc|pandoc|org|rst|tex|text'

" neoterm settings - might make slime redundant
let g:neoterm_default_mod = 'bot vert'
let g:neoterm_direct_open_repl = 0
"let g:neoterm_repl_python = ['test -d venv && conda deactivate && source venv/bin/activate', 'clear', 'ipython']
let g:neoterm_repl_python = ['set venv (find . -name activate.fish) && test -f "$venv[1]" && source "$venv[1]"', 'clear', 'ipython']
let g:neoterm_repl_enable_ipython_paste_magic = 1
let g:neoterm_shell = 'fish'

" rg settings
if executable('rg')
    let g:rg_derive_root='true'
    set grepprg=rg\ --vimgrep\ --smart-case\ --follow\ -g\ '!venv'
endif

" advanced ripgrep
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
command! -bang -nargs=* Brg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".<q-args>, 1, <bang>0)

" netrw settings
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

" fzf settings
if executable('rg')
    let $FZF_DEFAULT_COMMAND="rg --files -g '!venv'"
endif
let $FZF_DEFAULT_OPTS="-m"
" let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
" let $FZF_DEFAULT_OPTS='--reverse'
" let g:fzf_branch_actions = {
"       \ 'track': {
"       \   'prompt': 'Track> ',
"       \   'execute': 'echo system("{git} checkout --track {branch}")',
"       \   'multiple': v:false,
"       \   'keymap': 'ctrl-t',
"       \   'required': ['branch'],
"       \   'confirm': v:false,
"       \ },
"       \}

" NERDTree stuff
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" vim-markdown settings
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 1
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_edit_url_in = 'tab'
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_folding_disabled = 0
let g:markdown_fenced_languages = ['python', 'ruby', 'go', 'bash']
let g:vim_markdown_folding_level = 6
let g:vim_markdown_folding_style_pythonic = 1

" pandoc markdown settings
let g:pandoc_syntax_codeblocks_use = 1
let g:pandoc_syntax_codeblocks_embeds_langs = ["python", "ruby", "bash=sh"]

" gitgutter settings
"let g:gitgutter_enabled = 0

nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>ga :Git fetch --all<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
" add mapping to disable gitgutter (sloooow)...
nnoremap <leader>gg :GitGutterBufferToggle<CR>

" mappings for the terminal
tnoremap <Esc> <C-\><C-n>
"tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

" window movement - changing those mappings to match terminal
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

" others
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
nnoremap <C-g> :Goyo<CR>
" nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap X "_d

" capitalize each word in a line - doesn't work like this
"nnoremap <A-c> :norm s/\v<(.)(\w*)/\u\1\L\2/g<CR>

" neoterm mappings
noremap <silent> tt :Ttoggle<CR>
noremap <silent> tc :Tclose!<CR>
nmap <C-c><C-c> <Plug>(neoterm-repl-send-line)
vmap <C-c><C-c> <Plug>(neoterm-repl-send)

" vim TODO
nmap <Leader>tu <Plug>BujoChecknormal
nmap <Leader>th <Plug>BujoAddnormal
" let g:bujo#todo_file_path = $HOME . "/.cache/bujo"

" map Ctrl-C to Esc in insert mode
inoremap <C-c> <esc>

" Insert timestamp at the end of the line in this format: 20200527T113245
nnoremap <C-t><C-s> m'A<C-R>=strftime('%Y%m%dT%H%M%S')<CR>

" map CapsLock to Esc in vim only
au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" delete buffer but keep window
nmap ,d :b#<bar>bd#<CR>

" to insert newlines without going into insert mode
map <Enter> o<ESC>
map <S-Enter> O<ESC>

" some mappings for coc-nvim
let g:python3_host_prog = '~/.virtualenvs/neovim/bin/python'

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" settings specific to filetype
if has("autocmd")
  " some settings to make vim a better markwodn editor
  " Treat all .md files as markdown
  autocmd BufNewFile,BufRead *.md set filetype=markdown

  " Spellcheck in British English
  autocmd FileType markdown setlocal spell spelllang=en_gb
  " Automatically open Goyo
  "autocmd FileType markdown Goyo
  " Hide plaintext formatting and use color instead
  autocmd FileType markdown set conceallevel=2
  " Disable cursor line and column highlight
  autocmd FileType markdown,pandoc,text setlocal wrap
  autocmd FileType markdown,pandoc,text setlocal linebreak
  " could also set textwidth=79 here and might in the future
endif
