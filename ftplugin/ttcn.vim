" Vim filetype plugin file
" Language:     TTCN-3
" Maintainer:   Stefan Karlsson <stefan.74@comhem.se>
" Maintainer:   Gustaf Johansson <gustaf dot j at gmail dot com>
" Last Change:  15 September 2012

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

if exists("b:undo_ftplugin")
    let b:undo_ftplugin = b:undo_ftplugin . " | setlocal foldmethod< foldlevel< include< suffixesadd< formatoptions<"
else
    let b:undo_ftplugin = "setlocal foldmethod< foldlevel< include< suffixesadd< formatoptions<"
endif

if exists("g:ttcn_fold")
    setlocal foldmethod=syntax
    setlocal foldlevel=99
endif

" Path to the dictionary (this path might need adjustment)
" Set manually with: setlocal dict=~\path\to\ttcn.dict
let &dict=expand("<sfile>:p:h") . "\..\dicts\ttcn.dict"

" Enables gf, [I, [i, etc commands for ttcn files
setlocal include=^\\s*import\\s\\+from
setlocal suffixesadd=.ttcn

" Disable auto breaking of non-comments
setlocal formatoptions-=t

" Enable auto breaking of comments and enable formatting of comments with
" the gq command
setlocal formatoptions+=croq1n2

