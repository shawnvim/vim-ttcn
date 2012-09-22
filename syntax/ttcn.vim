" Vim syntax file
"
" Language:     TTCN-3
" Maintainer:   Stefan Karlsson <stefan.74@comhem.se>
" Maintainer:   Gustaf Johansson <gustaf dot j at gmail dot com>
" Last Change:  22 July 2010
"
" History:
" Updated the file with the changes in ETSI standard ES 201 873-1
" V4.1.1. Since Stefan has not updated the file since 2005-08-10 you can
" contact me with any bugs or other problems you find.
"
" Original by Stefan was based on the ETSI standard ES201873-1 v2.2.1. Please
" let me know of any bugs or other problems you run across.


if exists("b:current_syntax")
  finish
endif

if exists("g:ttcn_minlines")
  exec "syn sync minlines=" . g:ttcn_minlines
else
  syn sync fromstart
endif

" Automatically define folds. You enable this feature with :let g:ttcn_fold=1.
if exists("g:ttcn_fold") && g:ttcn_fold == 1
  syn region ttcnFold start="{" end="}" transparent fold
endif

" Highlight declared language elements following generic naming conventions,
" not standardized but noted on http://www.ttcn-3.org/NamingConventions.htm.
" Enable this feature with :let g:ttcn_hl_naming_convention=1.
if exists("g:ttcn_hl_naming_convention") && g:ttcn_hl_naming_convention == 1
  syn match ttcnAltStp "\<as\?_\w\+\>"
  syn match ttcnConst  "\<c\U\?_\w\+\>"
  syn match ttcnEnum   "\<e\U\?_\w\+\>"
  syn match ttcnFunc   "\<f\U\?_\w\+\>"
  syn match ttcnParam  "\<p\U\?_\w\+\>"
  syn match ttcnTempl  "\<m\U\?_\w\+\>"
  syn match ttcnVar    "\<v\U\?_\w\+\>"
  syn match ttcnTimer  "\<[tT]\U\?_\w\+\>"
endif

" ETSI ES 201 873-10 V3.4.1
" Part 10: TTCN-3 Documentation Comment Specification
syn match ttcnDocComment "@\<\(author\|config\|desc\|exception\|member\|param\|purpose\|remark\|return\|see\|since\|status\|url\|verdict\|version\)\>" contained

" Built-in types
syn keyword ttcnType    address anytype boolean char default float integer
syn keyword ttcnType    objid verdicttype timer set record union
syn keyword ttcnType    enumerated component port of
syn match   ttcnType    "\<\(char\|bit\|hex\|octet\)string\>"
syn match   ttcnError   "\<universal\>"
syn match   ttcnType    "\<universal\s\+charstring\>"

" Type definitions
syn keyword ttcnTypDef  type message procedure mixed

" Storage classes
syn keyword ttcnStore   var const external

" Module, import and group stuff
syn keyword ttcnModule  module modulepar group
syn match   ttcnError   "\<import\>"
syn match   ttcnModule  "\<import\s\+from\>"

" C++ Pre processor directives, used when we have a ttcnpp file
syn match   ttcnInclude "\^\s\*#\s\*include\>"
syn match   ttcnDefine  "\^\s\*#\s\*\(define\|undef\)\>"
syn region  ttcnPreCond start="^\s*#\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" contains=ttcnCmnt,ttcnString
syn match   ttcnPreCond "\^\s\*#\s\*\(else\|endif\)\>"

" Preprocessing macros
syn keyword ttcnMacro   __MODULE__ __FILE__ __LINE__ __SCOPE__

" Attributes
syn keyword ttcnAttrib  with display encode extension variant optional

" Operators
syn keyword ttcnOper    mod rem not and or xor not4b and4b or4b xor4b
syn keyword ttcnOper    complement pattern match valueof subset superset permutation
syn match   ttcnOper    "[-+*/?]"
syn match   ttcnOper    "[<>]"
syn match   ttcnError   "="
syn match   ttcnOper    "[=!><]="
syn match   ttcnOper    "\(<[<@]\)\|\([>@]>\)"
syn match   ttcnOper    "&"
syn match   ttcnError   "&&\+"hs=s+1
syn match   ttcnOper    "\.\."
syn match   ttcnError   "\.\.\.\+"hs=s+2

" Visibility
syn keyword ttcnScope   public friend private

" Statements
syn match   ttcnStat    "->"
syn match   ttcnStat    ":="
syn keyword ttcnSpecial control extends
syn match   ttcnError   "\<verdict.\(set\|get\)"
syn keyword ttcnStat    function testcase signature noblock exception
syn keyword ttcnStat    altstep template
syn match   ttcnError   "\<runs\>"
syn match   ttcnError   "\<on\>"
syn match   ttcnSpecial "\<runs\s\+on\>"

" Basic statements
syn keyword ttcnCond    if else select
syn keyword ttcnRepeat  for while do goto
syn keyword ttcnLabel   case label
syn keyword ttcnStat    return break continue log stop

" Alt statements & operations
syn keyword ttcnCond    alt interleave
syn keyword ttcnStat    repeat activate deactivate

" Config operations
" stop
syn keyword ttcnStat    create connect disconnect map unmap start
syn keyword ttcnOper    mtc system self running kill alive done killed

" Communication operations
" stop start
syn keyword ttcnStat    send call reply receive getcall getreply
syn keyword ttcnExcept  raise catch
syn keyword ttcnOper    trigger check clear halt

" Timer operations
" stop start running
syn keyword ttcnOper    read timeout

" Verdict operations
syn keyword ttcnStat    setverdict getverdict

" External actions
syn keyword ttcnOper    action

" Test case operations
syn keyword ttcnOper    execute

" Predefined functions
syn keyword ttcnFunc    int2char int2unichar int2bit int2hex int2oct
syn keyword ttcnFunc    int2str int2float float2int char2int char2oct
syn keyword ttcnFunc    unichar2int bit2int bit2hex bit2oct bit2str
syn keyword ttcnFunc    hex2int hex2bit hex2oct hex2str
syn keyword ttcnFunc    oct2int oct2bit oct2hex oct2str oct2char
syn keyword ttcnFunc    str2int str2oct str2float enum2int
syn keyword ttcnFunc    lengthof sizeof ispresent ischosen
syn keyword ttcnFunc    isvalue regexp substr replace encvalue
syn keyword ttcnFunc    decvalue rnd isbound log2str

" Various keywords
syn keyword ttcnKeyw    in out inout any all sender to value modifies
syn keyword ttcnKeyw    nowait param length recursive except
syn keyword ttcnKeyw    ifpresent language override present
syn keyword ttcnKeyw    from

" Literals
syn match   ttcnError   "\_^0\d\+"he=s+1
syn match   ttcnError   "\(\s\|\t\)0\d\+"hs=s+1,he=s+2
syn match   ttcnNumber  "\<\(0\|\([1-9]\d*\)\)\>"
syn match   ttcnNumber  "\<\(0\|\([1-9]\d*\)\)\.\d\+\>"
syn match   ttcnNumber  "\<\(0\|\([1-9]\d*\)\)\(\.\d\+\)\?E-\?[1-9]\d*\>"
syn match   ttcnNumber  "[^a-zA-Z0-9_]\@<=[+-]\d"hs=e-1,he=e-1,me=e-1
syn match   ttcnNumber  "\<infinity\>"
syn match   ttcnNumber  "-infinity\>"
syn keyword ttcnBool    true false
syn keyword ttcnConst   omit null pass fail inconc none error
syn region  ttcnString  start=/"/ end=/"/ skip=/\\"/ oneline
syn match   ttcnString  /'[01]*'B/
syn match   ttcnString  /'\x*'H/
syn match   ttcnString  /'\(\x\x\)*'O/
syn match   ttcnError   /'\x\(\x\x\)*'O/

" Comments
if version < 700
  syn match   ttcnCmnt    "//.*" contains=ttcnTodo,ttcnDocComment
  syn region  ttcnCmnt    start="/\*" end="\*/" contains=ttcnTodo,ttcnDocComment
else
  syn match   ttcnCmnt    "//.*" contains=ttcnTodo,ttcnDocComment,@Spell
  syn region  ttcnCmnt    start="/\*" end="\*/" contains=ttcnTodo,ttcnDocComment,@Spell
endif

syn case ignore
syn keyword ttcnTodo    xxx todo fixme contained
syn case match


" Link our groups to Vim's predefined groups
if version >= 508 || !exists("g:did_ttcn_syn_inits")

  if version < 508
    let g:did_ttcn_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink ttcnAttrib     PreProc
  HiLink ttcnBool       Boolean
  HiLink ttcnConst      Constant
  HiLink ttcnCmnt       Comment
  HiLink ttcnCond       Conditional
  HiLink ttcnSpecial    Special
  HiLink ttcnScope      StorageClass
  HiLink ttcnDecl       Statement
  HiLink ttcnError      Error
  HiLink ttcnExcept     Exception
  HiLink ttcnFunc       Function
  HiLink ttcnKeyw       Keyword
  HiLink ttcnLabel      Label
  HiLink ttcnModule     Include
  HiLink ttcnPreProc    PreProc
  HiLink ttcnInclude    Include
  HiLink ttcnDefine     Define
  HiLink ttcnPreCond    PreCondit
  HiLink ttcnNumber     Number
  HiLink ttcnOper       Operator
  HiLink ttcnRepeat     Repeat
  HiLink ttcnStat       Statement
  HiLink ttcnStore      StorageClass
  HiLink ttcnString     String
  HiLink ttcnTodo       Todo
  HiLink ttcnType       Type
  HiLink ttcnTypDef     TypeDef
  HiLink ttcnMacro      Macro
  HiLink ttcnDocComment SpecialComment

  if exists("g:ttcn_hl_naming_convention") && g:ttcn_hl_naming_convention == 1
    HiLink ttcnAltStp     Function
    HiLink ttcnConst      Constant
    HiLink ttcnEnum       Structure
    HiLink ttcnFunc       Function
    HiLink ttcnParam      Identifier
    HiLink ttcnTempl      Function
    HiLink ttcnVar        Identifier
    HiLink ttcnTimer      Special
  endif

  delcommand HiLink

endif


let b:current_syntax = "ttcn"

