" vim: set sw=2 sts=2 ts=2 et ft=vim fdm=marker fdc=3 foldlevel=0:
" ============================================================================
" File: .vimrc
" Description: main customization file of Vim
" Author: Roman Gauchi
" ----------------------------------------------------------------------------
" Largely inspired by:
"   - .vimrc of Junegunn Choi (https://github.com/junegunn/dotfiles)
"   - .vimrc of Amix (https://github.com/amix/vimrc)
"
" Useful links:
"   - vim plugins database (https://vimawesome.com/)
"   - vim command help (https://github.com/mhinz/vim-galore)
" ----------------------------------------------------------------------------
" Folding commands:
"  (z + a) to open/close fold markers
"  (z + r) to open everything
"  (z + m) to close everything
" ============================================================================

" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

" Download vim-plug if not installed by default
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall
endif

silent! if plug#begin('~/.vim/plugged')

let $GIT_SSL_NO_VERIFY = 'true'

" ----------------------------------------------------------------------------
" Basic Plugins Declarations
" ----------------------------------------------------------------------------

""" The Fancy start screen for Vim
Plug 'mhinz/vim-startify'

""" A simple, easy-to-use Vim alignment plugin.
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }

""" Rainbow Parentheses Improved (+ change also operator color contains inside )
Plug 'luochen1990/rainbow'

""" Surround parentheses, brackets, quotes, XML tags, and more.
Plug 'tpope/vim-surround'

""" Peekaboo extends " and @ in normal mode and <CTRL-R> in insert mode so you
""" can see the contents of the registers.
Plug 'junegunn/vim-peekaboo'

""" This plugin is used for displaying thin vertical lines at each indentation
""" level for code indented with spaces.
Plug 'Yggdroot/indentLine'

""" Remaps `.` in a way that plugins can tap into it.
Plug 'tpope/vim-repeat'

""" Helps to end certain structures automatically.
Plug 'tpope/vim-endwise'

""" Comment plugin (`<number>cc` or `<number>gcc`)
Plug 'tpope/vim-commentary'

""" Abbreviation, Substitution & Coercion
Plug 'tpope/vim-abolish', { 'on': 'S' }

""" The plug-in visualizes undo history and makes it easier to browse and switch
""" between different undo branches.
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

""" Switching between a single-line statement and a multi-line one.
Plug 'AndrewRadev/splitjoin.vim'

""" Browsing
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
if v:version >= 703
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
endif

""" Add awesome icons on the nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

""" Git
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'tag': 'legacy' }
endif

"""" Show git status flags in NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'

""" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'ctrlpvim/ctrlp.vim'

" ----------------------------------------------------------------------------
" Languages, syntax & autocompletion
" ----------------------------------------------------------------------------

""" CSV
Plug 'chrisbra/csv.vim'
Plug 'chrisbra/Colorizer'

""" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'

""" Syntax checking hacks for vim (tip: can be launched by airline)
Plug 'scrooloose/syntastic', { 'on': 'SyntasticCheck' }

""" Syntax highlighting, indentation support
let g:polyglot_disabled = ['latex']
Plug 'sheerun/vim-polyglot'

""" LateX
Plug 'lervag/vimtex'

""" Grammar checker for Vim (installation should done with bash shell)
Plug 'rhysd/vim-grammarous'

""" Python
Plug 'davidhalter/jedi-vim'
Plug 'vim-scripts/indentpython.vim'

""" C/C++
Plug 'vim-scripts/OmniCppComplete'
Plug 'shiracamus/vim-syntax-x86-objdump-d'

""" SystemVerilog
Plug 'vhda/verilog_systemverilog.vim'

""" Others languages
Plug 'pangloss/vim-javascript'
Plug 'chrisbra/unicode.vim', { 'for': 'journal' }

""" Preview color in Vim
Plug 'ap/vim-css-color'

""" SuperTab (between auto-completion and snippets-completion)
Plug 'ervandew/supertab'

""" UltiSnips is the ultimate solution for snippets in Vim. It has tons of
""" features and is very fast.
Plug 'SirVer/ultisnips', { 'tag': '3.1' }
Plug 'honza/vim-snippets' " Snippets database

""" Asynchronous code completion framework for vim 8
Plug 'maralla/completor.vim'

""" Easily interact with tmux from vim
" :nmap <leader>m :call VimuxRunCommand("make")<cr>
Plug 'benmills/vimux'

""" Org-mode: interactive dates, folding, ... for task management
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'

" ----------------------------------------------------------------------------
" Colors
" ----------------------------------------------------------------------------

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" choose your own colorsheme: https://vimcolors.com
" create your own colorsheme: https://github.com/lifepillar/vim-colortemplate
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'rainux/vim-desert-warm-256'
Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'arzg/vim-colors-xcode'
Plug 'cormacrelf/vim-colors-github'
" Plug 'chriskempson/base16-vim'
" Plug 'flazz/vim-colorschemes'

" RG: to correct xterm-21color shell:
" https://github.com/chriskempson/base16-shell

" Devicons need to be declare last
Plug 'ryanoasis/vim-devicons'

call plug#end()
endif

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

let mapleader      = ' '        " define the <leader> key mapping
let maplocalleader = ' '        " define the <localleader> key mapping (local to a buffer)

set nocompatible                " do not preserve compatibility in Vi
set encoding=utf-8              " default character encoding
set autoread                    " automatically read a file that has changed on disk
set number                      " display line numbers
set relativenumber              " display relative line numbers
set cursorline                  " show cursor line
set ruler                       " show the cursor position all the time
set nostartofline               " keep cursor in the same column when moving between lines
set autoindent                  " copy indent from current line when starting a new line
set smartindent                 " does the right thing (mostly) in programs
set tabstop=4                   " number of space for a <Tab> in the file
set softtabstop=4               " number of space for a <Tab> while performing editing operations
set shiftwidth=4                " number of space used for each step (auto)indent
set expandtab                   " use spaces instead of tabs
set smarttab                    " move tabulation cursor onto virtual tab grid
set modelines=2                 " check first lines of files for style information
set foldcolumn=0                " no fold column by default, please use vim 'modeline'
set foldlevelstart=99           " no folds closed
set wrap                        " wrap lines by default
set linebreak                   " break lines on words rather than characters
set textwidth=0                 " disable automatic line break for long lines
set lazyredraw                  " no window redrawing during operations like macros, registers, ...
set splitright                  " splitting a window will put the new window right the current one
set laststatus=2                " always display the status line
set scrolloff=1                 " number of screen lines to keep above and below the cursor
set showcmd                     " show (partial) command in the last line of the screen
set noerrorbells                " disable audio bell
set novisualbell                " disable visual bell
set t_vb=                       " no option for visual bell (t_vb=)
set backspace=indent,eol,start  " backspace key deletes indentation, line ends, characters
set timeoutlen=1000             " waiting time for a key sequence
set whichwrap=b,s,>,<,],[       " keys that position the cursor with movement keys
set showmatch                   " show matching brackets
set shortmess=aIToO             " don't show startup message when opening Vim without a file
set hlsearch                    " highlight matches of the previous search pattern
set incsearch                   " highlight search after you type it
set synmaxcol=1000              " maximum column in which to search syntax for items
set hidden                      " buffer becomes hidden when it is abandoned
set ignorecase                  " ignore case during search
set smartcase                   " canceling out ignore for uppercase letter in search
set infercase                   " ignore case during completion
set wildmenu                    " enable a navigable list of suggestions (in commands)
set wildmode=longest,list:full  " list all matches and complete till longest common string
set nolist                      " hide tabs, spaces or trailing blanks characters
set listchars=eol:$,tab:›·,trail:• " configure invisible character
set virtualedit=block           " allow virtual editing in visual block mode
set nojoinspaces                " do not insert two spaces after a '.', '?' and '!'
set diffopt=filler,vertical     " start diff mode in vertical split and show filler lines
set clipboard=unnamed,unnamedplus,autoselect,autoselectplus " clipboard behaviors
set grepformat=%f:%l:%c:%m,%f:%l:%m " format to recognize for the ":grep" command output
set nrformats=bin,hex           " consider number bases (0b, 0B, 0x, 0X)
set cryptmethod=blowfish2       " specify the encryption used to write the buffer in a file
set spelllang=en_us             " default language for spell checker
set spellfile=$HOME/.vim/spell/en.utf-8.add " spell file for additional correct English words
set spellsuggest=best,10        " only display the 10 best suggestions
set pastetoggle=<C-F7>          " key binding for the paste mode
set isfname=@,48-57,/,.,-,_,+,,,#,$,%,~,=,@-@ " characters used for "gf" commands
set path+=**                    " search current directory recursively

" Insert comments automatically in vim
" (https://stackoverflow.com/a/952561)
set formatoptions+=1,r
if has('patch-7.3.541')
  set formatoptions+=j
endif
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif

" Autocompletion when CTRL-P or CTRL-N are used (default: ".,w,b,u,t,i")
" . .... current buffer
" w .... buffers from other windows
" b .... other loaded buffers that are in the buffer list
" u .... unloaded buffers that are in the buffer list
" U .... buffers that are not in the buffer list
" t .... tag completion
" i .... current and included files
" d .... current and included files for defined name or macro
" k .... files given with the 'dictionary' option
" kspell currently active spell checking spell
set complete+=d,kspell

" Popup Menu
" Define behavior for autocompletion (default: "menu,preview")
" - options: menu, menuone, longuest, preview, popup, popuphidden
" - options (vim8): noselect, noinsert
set completeopt=longest,menu,menuone
if v:version >= 800
  set completeopt+=noselect
endif
set pumheight=15 " maximum height of Pmenu
set omnifunc=syntaxcomplete#Complete

" Ctags
set tags=.tags,tags
"set tags+=~/.vim/tags/cpp       " C++
"set tags+=~/.vim/tags/systemc   " SystemC/TLM-2.0
"set tags+=~/.vim/tags/scv       " SCV

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

" Mouse
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
endif
set mouse=a

" Shift-tab on GNU screen
" (http://superuser.com/questions/195794/gnu-screen-shift-tab-issue)
set t_kB=[Z

" Vim changes cursor to pink and keeps it on exit
" https://github.com/vim/vim/issues/3471
set t_Cs=

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
endif

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------

" qq to record, Q to replay (recursive map due to peekaboo)
nmap Q @q

" Navigation... (Control bring you power)
noremap <C-H>       b
noremap <C-J>       10j
noremap <C-K>       10k
noremap <C-L>       w
noremap <C-A>       ^
noremap <C-E>       $
noremap <C-Down>    10j
noremap <C-Up>      10k
noremap <S-Down>    10j
noremap <S-Up>      10k
inoremap <C-Down>   <C-o>10j
inoremap <C-Up>     <C-o>10k
inoremap <S-Down>   <C-o>10j
inoremap <S-Up>     <C-o>10k

" Meta key (option key on MacOS)
noremap <M-Left>    b
noremap <M-Right>   w
noremap <M-Down>    10j
noremap <M-Up>      10k
inoremap <M-Down>   <C-o>10j
inoremap <M-Up>     <C-o>10k

" Swap lines
noremap <A-Up>      ddkP
noremap <A-Down>    ddp

" ----------------------------------------------------------------------------
" Ctrl+ mappings
" ----------------------------------------------------------------------------

" <Ctrl+S> | save current tab
nnoremap <C-S> :update<cr>
inoremap <C-S> <esc>:update<cr>
" <Ctrl+Z> | undo
nnoremap <C-Z> u
inoremap <C-Z> <esc>ua
" <Ctrl+Y> | cancel undo
nnoremap <C-Y> <C-R>
" <Ctrl+W> | close file
nnoremap <C-W> :q<cr>
inoremap <C-W> <esc>:q<cr>
" <Ctrl+Q> | quit vim
nnoremap <C-Q> :qa<cr>
inoremap <C-Q> <esc>:qa<cr>
" <Ctrl+F> | Jump to a tag
nnoremap <C-F> g<C-]>zz
" <Ctrl+D> | Go back
nnoremap <C-D> :pop<cr>
" <Ctrl+Backspace> | Backward word deletion
inoremap <expr> <C-H> <sid>check_blank_line() ? "<C-H>" : "<C-\><C-o>db"
inoremap <expr> <C-BS> <sid>check_blank_line() ? "<C-BS>" : "<C-\><C-o>db"
" TODO: <Ctrl+Delete> | Forward word deletion
" RG: fixdel issues (no mappings)
" set t_kD=[3~
" inoremap <C-Del> <C-\><C-o>dw

" ----------------------------------------------------------------------------
" Fn mappings
" ----------------------------------------------------------------------------

" <Ctrl+F4> | saves buffer
nnoremap <C-F4> :w<cr>
inoremap <C-F4> <C-o>:w<cr>
" Define in autocmd:
" - if c or cpp file:
"       <F5> | launch make -j4
"       <Ctrl+F5> | launch make clean; make -j4
" - if python filetype
"       <F5> | launch python
" <F6> | no highlight search
nnoremap <F6> :nohlsearch<cr>
inoremap <F6> <esc>:nohlsearch<cr>
" <Ctrl+F6> | show/hide space/tabs
nnoremap <C-F6> :set list!<cr>
inoremap <C-F6> <esc>:set list!<cr>
" <F7> | set wrap!
nnoremap <F7> :call ToggleWrap()<cr>
inoremap <F7> <esc>:call ToggleWrap()<cr>
" <Ctrl+F7> | toggle paste mode
" <F8> | open the file under the cursor vertically splitted
nnoremap <F8> :vertical wincmd f<cr>
inoremap <F8> <esc>:vertical wincmd f<cr>
" <Ctrl+F8> | try to open the file under the cursor ...
nnoremap <C-F8> :grep! "\<<cword>\>" . -r<cr>:copen<cr>
inoremap <C-F8> <esc>:grep! "\<<cword>\>" . -r<cr>:copen<cr>
" <F9> | NERDTreeToggle
nnoremap <F9> :NERDTreeToggle<cr>
inoremap <F9> <esc>:NERDTreeToggle<cr>
" <Ctrl+F9> | Tagbar
if v:version >= 703
  nnoremap <C-F9> :TagbarToggle<cr>
  inoremap <C-F9> <esc>:TagbarToggle<cr>
  let g:tagbar_sort = 0
endif
" <F10> | auto-format with Astyle
nnoremap <F10> :silent set cmdheight=2<cr>:silent call Format()<cr>:silent set cmdheight=1<cr>
" <Ctrl+F10> | build tags of your own project
nnoremap <C-F10> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
" <F11> | full screen for most terminal

" ----------------------------------------------------------------------------
"  <leader> shortcuts
" ----------------------------------------------------------------------------

" Background swith
nnoremap <Leader>bb :call ToggleBackground()<cr>

" Markdown headings
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

" <leader>c | Counting occurrences of the pattern
xnoremap <leader>cc :s@\%V@@gn<CR>
nnoremap <leader>cc :%s@@@gn<Left><Left><Left><Left>

" <leader>bs | buf-search
nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

" <leader>n | toggle relative/absolute line number
nnoremap <leader>nn :set relativenumber!<cr>

" <leader>ss | toggle the spell checking
nnoremap <leader>ss :setlocal spell!<cr>

" <leader>ss | launch the grammarous checking
nnoremap <leader>gg :GrammarousCheck<cr>

" vim-fugitive
nmap     <leader>gs :Gstatus<cr>gg<c-n>
nnoremap <leader>gd :Gdiff<cr>

" <leader>z | zoom on the current file (tmux-like)
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" <leader>? | google research
nnoremap <leader>? :call <SID>goog(expand("<cWORD>"))<cr>
xnoremap <leader>? "gy:call <SID>goog(@g)<cr>gv

" <leader>w | open the webpage under the cursor
nnoremap <leader>w :call system('xdg-open '.expand('<cfile>'))<cr>

" completor
noremap <silent> <leader>d :call completor#do('definition')<CR>
noremap <silent> <leader>c :call completor#do('doc')<CR>
noremap <silent> <leader>f :call completor#do('format')<CR>
noremap <silent> <leader>s :call completor#do('hover')<CR>

" ----------------------------------------------------------------------------
"  Others useful shorcuts
" ----------------------------------------------------------------------------

" <tab> / <s-tab> | Circular windows navigation
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" Indenting lines
xnoremap < <gv
xnoremap > >gv
" (insert mode): ctrl+t, ctrl+d - ident current line forward, backward
" (visual mode): >, <           - ident block by sw

" Auto-pairs parenthesis
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Buffers
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>
nnoremap gn :bnext<cr>
nnoremap gb :bprev<cr>
" gn | go to the next buffer
" gb | go to the previous buffer

" Vimdiff
nnoremap dn ]c 
nnoremap db [c
" dn | next difference
" db | previous difference
" do | diff obtain
" dp | diff put

" Spell check
nnoremap zn ]s
nnoremap zp [s
nnoremap zl z=
" zg | good word list
" zw | bad word list

" grammarous
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
  nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
  nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
  nmap <buffer><C-i> <Plug>(grammarous-remove-error)
  nmap <buffer><C-l> <Plug>(grammarous-fixit)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
  nunmap <buffer><C-n>
  nunmap <buffer><C-p>
  nunmap <buffer><C-i>
  nunmap <buffer><C-l>
endfunction

" Quickfix
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" Search for visual selection
vnoremap * y/<C-R>"<CR>

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)
nmap gaa ga_

" vim-commentary
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cc  <Plug>CommentaryLine

" U | undotree
nnoremap U :UndotreeToggle<CR>

" switch between a single line statement and multi-line one
nnoremap gss :SplitjoinSplit<cr>
nnoremap gsj :SplitjoinJoin<cr>

" force saving when in a read-only file (root)
cmap w!! %!sudo tee > /dev/null %

" }}}
" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Format C code with astyle
" ----------------------------------------------------------------------------
function! Format()
  if executable('astyle')
    silent! norm! mz
    if &ft ==? 'c' || &ft ==? 'hpp' || &ft ==? 'cpp' || &ft ==? 'php'
      set formatprg=astyle\ --style=linux\ --attach-namespaces\ --attach-extern-c\ --attach-closing-while\ --indent-switches\ --indent-continuation=2\ --indent-preproc-define\ --indent-col1-comments\ --pad-comma\ --pad-header\ --unpad-paren\ --align-pointer=type\ --align-reference=type\ --break-one-line-headers\ --keep-one-line-statements\ --convert-tabs\ --close-templates\ --preserve-date
      silent! norm! gggqG
    endif
    silent! call CleanExtraSpaces()
    silent! retab
    " silent! norm! gg=G
    silent! norm! `z
    set formatprg=
  endif
  if executable('python') && &ft ==? 'json'
    silent! execute '%!python -m json.tool'
  endif
endfun

" ----------------------------------------------------------------------------
" Delete trailing white space on save, useful for some filetypes ;)
" ----------------------------------------------------------------------------
function! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

augroup clean_extra_space
  au BufWritePre *.txt,*.js,*.py,*.wiki,*.sh :call CleanExtraSpaces()
augroup end

" ----------------------------------------------------------------------------
" Check if the line is blank up to the beginning
" ----------------------------------------------------------------------------
function! s:check_blank_line() abort
    let col = col('.') - 1
    return !col || (getline('.')[:col-1] =~ '^\s*$')
endfunction

" ----------------------------------------------------------------------------
" Zoom
" ----------------------------------------------------------------------------
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
        \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction

" ----------------------------------------------------------------------------
" :Chomp
" ----------------------------------------------------------------------------
command! Chomp %s/\s\+$// | normal! ``

" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! Root call s:root()

" ----------------------------------------------------------------------------
" HL | Find out syntax group
" ----------------------------------------------------------------------------
function! s:hl()
  " echo synIDattr(synID(line('.'), col('.'), 0), 'name')
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
endfunction
command! HL call <SID>hl()

" ----------------------------------------------------------------------------
" :A alternate between C/CPP header & source
" ----------------------------------------------------------------------------
function! s:a(cmd)
  let name = expand('%:r')
  let ext = tolower(expand('%:e'))
  let sources = ['c', 'cc', 'cpp', 'cxx']
  let headers = ['h', 'hh', 'hpp', 'hxx']
  for pair in [[sources, headers], [headers, sources]]
    let [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        let aname = name.'.'.h
        for a in [aname, toupper(aname)]
          if filereadable(a)
            execute a:cmd a
            return
          end
        endfor
      endfor
    endif
  endfor
endfunction
command! A call s:a('e')
command! AV call s:a('botright vertical split')

" ----------------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------------
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
        \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor
  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()

" ----------------------------------------------------------------------------
" AutoSave
" ----------------------------------------------------------------------------
function! s:autosave(enable)
  augroup autosave
    au!
    if a:enable
      au TextChanged,InsertLeave <buffer>
            \  if empty(&buftype) && !empty(bufname(''))
            \|   silent! update
            \| endif
    endif
  augroup end
endfunction
command! -bang AutoSave call s:autosave(<bang>1)

" ----------------------------------------------------------------------------
" TX
" ----------------------------------------------------------------------------
command! -nargs=1 TX
      \ call system('tmux split-window -d -l 16 '.<q-args>)
cnoremap !! TX<space>

" ----------------------------------------------------------------------------
" Tmux
" ----------------------------------------------------------------------------
function! s:tmux_send(content, dest) range
  let dest = empty(a:dest) ? input('To which pane? ') : a:dest
  let tempfile = tempname()
  call writefile(split(a:content, "\n", 1), tempfile, 'b')
  call system(printf('tmux load-buffer -b vim-tmux %s \; paste-buffer -d -b vim-tmux -t %s',
        \ shellescape(tempfile), shellescape(dest)))
  call delete(tempfile)
endfunction

function! s:tmux_map(key, dest)
  execute printf('nnoremap <silent> %s "tyy:call <SID>tmux_send(@t, "%s")<cr>', a:key, a:dest)
  execute printf('xnoremap <silent> %s "ty:call <SID>tmux_send(@t, "%s")<cr>gv', a:key, a:dest)
endfunction

call s:tmux_map('<leader>tt', '')
call s:tmux_map('<leader>th', '.left')
call s:tmux_map('<leader>tj', '.bottom')
call s:tmux_map('<leader>tk', '.top')
call s:tmux_map('<leader>tl', '.right')
call s:tmux_map('<leader>ty', '.top-left')
call s:tmux_map('<leader>to', '.top-right')
call s:tmux_map('<leader>tn', '.bottom-left')
call s:tmux_map('<leader>t.', '.bottom-right')

" ----------------------------------------------------------------------------
" <Leader>? | Google it
" ----------------------------------------------------------------------------
function! s:goog(pat)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
        \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system('xdg-open https://duckduckgo.com/?q='.q)
endfunction

" ----------------------------------------------------------------------------
" <Leader>w | Open URL
" ----------------------------------------------------------------------------
command! -nargs=1 OpenURL :call system('firefox <q-args>')

" ----------------------------------------------------------------------------
" ToggleBackground
" ----------------------------------------------------------------------------
function! ToggleBackground()
    if (&background == "light")
        set background=dark
        colorscheme gruvbox
        execute 'AirlineTheme wombat'
    else
        set background=light
        colorscheme github
        " colorscheme xcodelighthc
        execute 'AirlineTheme papercolor'
    endif
    call rainbow_main#load()
    " auto colorsheme * call rainbow_main#load()
endfunction

" ----------------------------------------------------------------------------
" ToggleWrap
" (https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping)
" ----------------------------------------------------------------------------
function ToggleWrap()
  if &wrap
    setlocal nowrap
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    setlocal wrap
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction

function! s:noremap_normal_cmd(key, preserve_omni, ...)
  let cmd = ''
  let icmd = ''
  for x in a:000
    let cmd .= x
    let icmd .= "<C-\\><C-O>" . x
  endfor
  execute ":nnoremap <silent> " . a:key . " " . cmd
  execute ":vnoremap <silent> " . a:key . " " . cmd
  if a:preserve_omni
    execute ":inoremap <silent> <expr> " . a:key . " pumvisible() ? \"" . a:key . "\" : \"" . icmd . "\""
  else
    execute ":inoremap <silent> " . a:key . " " . icmd
  endif
endfunction

" Cursor moves by screen lines
call s:noremap_normal_cmd("<Up>", 1, "gk")
call s:noremap_normal_cmd("<Down>", 1, "gj")
call s:noremap_normal_cmd("<Home>", 0, "g<Home>")
call s:noremap_normal_cmd("<End>", 0, "g<End>")

" PageUp/PageDown preserve relative cursor position
call s:noremap_normal_cmd("<PageUp>", 0, "<C-U>", "<C-U>")
call s:noremap_normal_cmd("<PageDown>", 0, "<C-D>", "<C-D>")

" }}}
" ============================================================================
" PLUGINS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" vim-easy-align
" ----------------------------------------------------------------------------
" easy_align_delimiters {{{
let g:easy_align_delimiters = {
      \ ';': { 'pattern': ';' },
      \ '>': { 'pattern': '>>\|=>\|>' },
      \ '\': { 'pattern': '\\' },
      \ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
      \ ']': {
      \     'pattern':       '\]\zs',
      \     'left_margin':   0,
      \     'right_margin':  1,
      \     'stick_to_left': 0
      \   },
      \ ')': {
      \     'pattern':       ')\zs',
      \     'left_margin':   0,
      \     'right_margin':  1,
      \     'stick_to_left': 0
      \   },
      \ 'f': {
      \     'pattern': ' \(\S\+(\)\@=',
      \     'left_margin': 0,
      \     'right_margin': 0
      \   },
      \ 'd': {
      \     'pattern': ' \ze\S\+\s*[;=]',
      \     'left_margin': 0,
      \     'right_margin': 0
      \   }
      \ }
" }}}

" ----------------------------------------------------------------------------
" rainbow_parentheses
" ----------------------------------------------------------------------------
let g:rainbow_active = 1
let lightcolors = ['cyan','red','green','magenta','blue','yellow','red','magenta']
let darkcolors  = ['DarkBlue','Magenta','Black','Red','DarkGray','DarkGreen','DarkYellow']
" rainbow_conf  {{{
let g:rainbow_conf = {
      \ 'guifgs':   lightcolors,
      \ 'ctermfgs': lightcolors,
      \ 'operators': '_,_',
      \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
      \ 'separately': {
      \     'nerdtree': 0,
      \     'cmake': 0,
      \     '*': {},
      \     'tex': {
      \         'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
      \     },
      \     'lisp': {
      \         'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
      \     },
      \     'vim': {
      \         'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
      \     },
      \     'html': {
      \         'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
      \     },
      \     'css': 0,
      \ }
      \}
" }}}

" ----------------------------------------------------------------------------
" indentLine
" ----------------------------------------------------------------------------
let g:indentLine_enabled        = 1
let g:indentLine_color_term     = 239       " Vim
let g:indentLine_color_gui      = '#4e4e4e' " GVim
let g:indentLine_concealcursor  = 0         " solve conflict with cursor line

augroup indent_line
  au User indentLine doautocmd indentLine Syntax
augroup end

" ----------------------------------------------------------------------------
" vim-commentary
" ----------------------------------------------------------------------------
augroup commentary
  au FileType cpp setlocal commentstring=//\ %s
  au FileType cfg setlocal commentstring=#\ %s
  au FileType xdefaults setlocal commentstring=!\ %s
augroup end

" ----------------------------------------------------------------------------
" undotree
" ----------------------------------------------------------------------------
let g:undotree_WindowLayout = 2

" ----------------------------------------------------------------------------
" splitjoin
" ----------------------------------------------------------------------------
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping  = ''

" ----------------------------------------------------------------------------
" vim-signify
" ----------------------------------------------------------------------------
let g:signify_vcs_list               = ['git']
let g:signify_skip_filetype          = { 'journal': 1 }
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_change            = '*'
let g:signify_sign_delete_first_line = '‾'

" ----------------------------------------------------------------------------
" matchit.vim
" ----------------------------------------------------------------------------
if v:version >= 800
  packadd! matchit
else
  runtime macros/matchit.vim
endif

" ----------------------------------------------------------------------------
" ack.vim
" ----------------------------------------------------------------------------
if executable('ag')
  let &grepprg = 'ag --nogroup --nocolor --column'
else
  let &grepprg = 'grep -rn $* *'
endif
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

" ----------------------------------------------------------------------------
" MatchParen delay
" ----------------------------------------------------------------------------
let g:matchparen_insert_timeout = 5

" ----------------------------------------------------------------------------
" csv
" ----------------------------------------------------------------------------
let g:csv_autocmd_arrange = 1

" ----------------------------------------------------------------------------
" vim-markdown
" ----------------------------------------------------------------------------
let g:vim_markdown_initial_foldlevel = &foldlevelstart

" ----------------------------------------------------------------------------
" syntastic
" ----------------------------------------------------------------------------
let g:syntastic_always_populate_loc_list= 1
let g:syntastic_auto_loc_list           = 1
let g:syntastic_check_on_open           = 1
let g:syntastic_check_on_wq             = 0
let g:syntastic_javascript_checkers     = ['standard']
let g:syntastic_python_checkers         = ['pylint']
let g:syntastic_c_checkers              = ['gcc']
let g:syntastic_cpp_checkers            = ['gcc']

" don't put icons on the sign column (it hides the vcs status icons of signify)
let g:syntastic_enable_signs            = 1
let g:syntastic_error_symbol            = '✗'
let g:syntastic_warning_symbol          = '⚠'
let g:syntastic_style_error_symbol      = '✗'
let g:syntastic_style_warning_symbol    = '⚠'

" ----------------------------------------------------------------------------
" polyglot (already enable with syntastic)
" ----------------------------------------------------------------------------
"RG: bug with vimtex plugin: let g:polyglot_disabled = ['latex']

" ----------------------------------------------------------------------------
" vimtex
" ----------------------------------------------------------------------------
set conceallevel=1
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
let g:tex_flavor='latex'

" ----------------------------------------------------------------------------
" grammarous
" ----------------------------------------------------------------------------
let g:grammarous#default_comments_only_filetypes = {
      \ '*' : 1, 'help' : 0, 'markdown' : 0,
      \ }

let g:grammarous#disabled_rules = {
      \ '*' : ['ARROWS'], 
      \ }

" ----------------------------------------------------------------------------
" jedi-vim
" ----------------------------------------------------------------------------
let g:jedi#show_call_signatures     = "2"
let g:jedi#popup_on_dot             = 1
let g:pymode_rope                   = 0
" let g:jedi#force_py_version         = "3"

" let g:jedi#goto_command             = "<leader>d"
" let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_stubs_command       = "<leader>s"
" let g:jedi#goto_definitions_command = "gy"
let g:jedi#documentation_command    = "K"
" let g:jedi#usages_command           = "<leader>n"
" let g:jedi#completions_command      = "<C-Space>"
" let g:jedi#rename_command           = "<leader>r"

" ----------------------------------------------------------------------------
" OmniCppComplete
" ----------------------------------------------------------------------------
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_NamespaceSearch     = 1
let OmniCpp_DisplayMode         = 1
let OmniCpp_ShowScopeInAbbr     = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess          = 1
let OmniCpp_DefaultNamespaces   = ["std", "_GLIBCXX_STD"]
let OmniCpp_MayCompleteDot      = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow    = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope    = 1 " autocomplete after ::
let OmniCpp_SelectFirstItem     = 0

" ----------------------------------------------------------------------------
" supertab
" ----------------------------------------------------------------------------
let g:SuperTabDefaultCompletionType         = "context"
let g:SuperTabContextDefaultCompletionType  = "<c-x><c-o>" " correct bottom to top bug
let g:SuperTabCompletionContexts            = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence     = ['&completefunc:<c-x><c-u>', '&omnifunc:<c-x><c-o>']

" to feel completion menu of other IDEs 
" (https://vim.fandom.com/wiki/Improve_completion_popup_menu)
" RG: s:noremap_normal_cmd: inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
" RG: s:noremap_normal_cmd: inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
inoremap <expr> <cr>       pumvisible() ? "\<C-y>" : "\<cr>"
" RG: correct <CR> key behavior
let g:endwise_no_mappings = 1

" ----------------------------------------------------------------------------
" ultisnips
" ----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger                = "<tab>"
let g:UltiSnipsListSnippets                 = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger           = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger          = "<c-k>"

" ----------------------------------------------------------------------------
" completor
" ----------------------------------------------------------------------------
let g:completor_disable_ultisnips           = 0     " hide snippets tips
let g:completor_refresh_always              = 1     " avoid flickering
let g:completor_complete_options            = "menuone,noselect"
let g:completor_completion_delay            = 10    " in ms
let g:completor_min_chars                   = 3     " to start autocompletion
let g:completor_javascript_omni_trigger     = "\\w+$|[\\w\\)\\]\\}\'\"]+\\.\\w*$"
let g:completor_cpp_omni_trigger            = '(\\.|->|#|::)\\s*(\\w*)$'
let g:completor_css_omni_trigger            = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'
let g:completor_html_omni_trigger           = '<?.*$'
let g:completor_php_omni_trigger            = '([$\w]+|use\s*|->[$\w]*|::[$\w]*|implements\s*|extends\s*|class\s+[$\w]+|new\s*)$'
let g:completor_tex_omni_trigger            = '\\\\(:?'
      \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
      \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
      \ . '|hyperref\s*\[[^]]*'
      \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
      \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
      \ .')$'
" let g:completor_clang_binary = '/usr/bin/clang'

" ----------------------------------------------------------------------------
" vim-airline
" ----------------------------------------------------------------------------
if $powerline == 1 || has("gui_running")
  let g:airline_powerline_fonts = 1
else
  let g:airline_powerline_fonts = 0
endif
" let g:airline_theme                                     = 'wombat'
let g:airline#extensions#whitespace#trailing_format     = 'tr[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mi[%s]'
let g:airline#extensions#tabline#enabled                = 1
let g:airline#extensions#tabline#buffer_nr_show         = 1
let g:airline#extensions#tagbar#enabled                 = 0
" syntastic integration needs syntastic be loaded at startup
let g:airline#extensions#syntastic#enabled              = 0

" ----------------------------------------------------------------------------
" Devicons
" ----------------------------------------------------------------------------
let g:webdevicons_enable_nerdtree           = 1
let g:webdevicons_enable_ctrlp              = 1
let g:webdevicons_enable_airline_tabline    = 0
let g:webdevicons_enable_airline_statusline = 1


" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Generic autocomd group
" ----------------------------------------------------------------------------
augroup vimrc
  au!

  au BufWritePost vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
  au BufNewFile,BufRead,InsertEnter,InsertLeave * silent! match NoBreakSpace / /

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " close preview window
  if exists('##CompleteDone')
    au CompleteDone * pclose
  else
    au InsertLeave * if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype())) | pclose | endif
  endif

  " automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME') && matchstr(system('tmux show-window-option automatic-rename'), "on")=="on"
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif

  " redraw after loading file
  au BufNewFile,BufRead * redraw

  " open NERDTree on startup
  "au vimenter * NERDTree
augroup end

" ----------------------------------------------------------------------------
" for hex editing
" ----------------------------------------------------------------------------
" vim -b : edit binary using xxd-format!"
augroup bin_autocmd
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup end

" ----------------------------------------------------------------------------
" for json editing
" ----------------------------------------------------------------------------
augroup json_autocmd
  au!
  au BufRead,BufNewFile *.json set filetype=json
  au FileType json set formatoptions=tcq2l
  au FileType json set autoindent expandtab
  au FileType json set foldmethod=syntax
  au FileType json set textwidth=78 sw=2 sts=2 ts=2
augroup end

" ----------------------------------------------------------------------------
" for SystemVerilog editing
" ----------------------------------------------------------------------------
augroup svlog_autocmd
  au!
  au FileType systemverilog set textwidth=78 sw=2 sts=2 ts=2
augroup end

" ----------------------------------------------------------------------------
" for LLVM human-readable editing
" ----------------------------------------------------------------------------
augroup llvm_autocmd
  au!
  au BufNewFile,BufRead *.ll set ft=llvm
augroup end

" ----------------------------------------------------------------------------
" for tex editing
" ----------------------------------------------------------------------------
augroup tex_autocmd
  au!
  au BufNewFile,BufRead *.tex,*.cls
        \ set nocursorline              |
        \ set completeopt-=i            |
        \ let g:loaded_matchparen =1    |
        \ set ft=tex
  au FileType tex set sw=2 sts=2 ts=2
augroup end

" ----------------------------------------------------------------------------
" Compile & Run shortcuts (Python and C/C++)
" ----------------------------------------------------------------------------
augroup compile_n_run
  au!
  " <F5> | launch make -j4
  au FileType c,cpp,tex,make nnoremap <F5> :w<cr> :!clear; make -j4<cr>
  au FileType c,cpp,tex,make inoremap <F5> <esc>:w<cr> :!clear; make -j4<cr>
  "au FileType python  nnoremap <F5> :w <bar> exec '!python '.shellescape('%')<CR>
  au FileType python  nnoremap <F5> :w <bar> exec '!./'.shellescape('%')<CR>
  au FileType python  inoremap <F5> <esc>:w <bar> exec '!./'.shellescape('%')<CR>
  " <Ctrl+F5> | launch make clean; make -j4
  au FileType c,cpp,tex,make nnoremap <C-F5> :w<cr> :!clear; make clean; make -j4<cr>
  au FileType c,cpp,tex,make inoremap <C-F5> <esc>:w<cr> :!clear; make clean; make -j4<cr>
augroup end

" }}}
" ============================================================================
" PERSONAL ADDITIONS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Change cursor shape
" (http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes)
" ----------------------------------------------------------------------------
if empty($TMUX)
  let &t_SI = "\e[5 q" " SI = INSERT mode
  let &t_SR = "\e[4 q" " SR = REPLACE mode
  let &t_EI = "\e[2 q" " EI = NORMAL mode (ELSE)
else
  let &t_SI = "\ePtmux;\e\e[5 q\e\\"
  let &t_SR = "\ePtmux;\e\e[4 q\e\\"
  let &t_EI = "\ePtmux;\e\e[2 q\e\\"
endif

" }}}
" ============================================================================
" COLORSCHEME LAST {{{
" ============================================================================

" Theme: gruvbox {{{
" Uses 256 color palette
" Set option value to 16 to fallback
let g:gruvbox_termcolors=256
" Change darkmode contrast. Possible values are `soft`, `medium`, `hard`
let g:gruvbox_contrast_dark='hard'
" Change lightmode contrast. Possible values are `soft`, `medium`, `hard`
let g:gruvbox_contrast_light='hard'
" Change cursor background
let g:gruvbox_hls_cursor='light0'
" Change vertical split background color
let g:gruvbox_vert_split='dark1'
" Improve Spell errors
let g:gruvbox_guisp_fallback='bg'
let g:gruvbox_improved_warnings=1
" Inverts indent guides
let g:gruvbox_invert_indent_guides=0
" }}}

" Theme: molokai {{{
" Match the original monokai background color
let g:molokai_original=1
" Bring the 256 color version
let g:rehash256=1
" }}}

" Always dark by default
set background=dark
" Colorscheme select
silent! colorscheme gruvbox
" silent! colorscheme desert-warm-256

if !exists('g:colors_name')
  finish
endif

if g:colors_name == 'desert-warm-256'
  " Define NONE colorscheme
  hi MatchParen NONE cterm=bold ctermfg=15 ctermbg=1
  " Fix color bugs in vim (cause by desert-warm-256)
  hi CursorLine   ctermbg=darkgrey term=bold  cterm=none
  hi CursorLineNr ctermbg=none     term=bold  cterm=none
  hi Search       guifg=#dfffdf guibg=#ff8c00  ctermfg=white ctermbg=208
  hi String       guifg=#ffa0a0                ctermfg=217
  " Pmenu
  hi Pmenu        guifg=white   guibg=#4e4e4e  ctermfg=white ctermbg=239
  hi PmenuSel     guifg=black   guibg=#d7ff87  ctermfg=black ctermbg=192
  hi PmenuSbar    guifg=blue    guibg=darkgray ctermfg=blue  ctermbg=darkgray
  hi PmenuThumb   guifg=#c0c0c0
  " Signify
  hi DiffAdd      gui=bold guifg=#5FFF00 guibg=#4e4e4e cterm=bold ctermfg=82  ctermbg=239
  hi DiffChange   gui=bold guifg=#FFFF5F guibg=#4e4e4e cterm=bold ctermfg=227 ctermbg=239
  hi DiffDelete   gui=bold guifg=#D75F5F guibg=#4e4e4e cterm=bold ctermfg=167 ctermbg=239
endif

" }}}
" ============================================================================
