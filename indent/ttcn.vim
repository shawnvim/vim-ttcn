" Vim indent file
"
" Language:     TTCN-3
" Maintainer:   Stefan Karlsson <stefan.74@comhem.se>
" Last Change:  22 July 2004

if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

" Basic strategy for calculating the indent:
" 
" 1. Use cindent as far as possible
" 2. Correct the indent for those parts where cindent fails


setlocal indentexpr=Get_ttcn_indent(v:lnum)

setlocal indentkeys=0{,0},0(,0),!^F,o,O,e
setlocal cinwords=

setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://

setlocal cino=(1s,)256,*512
"setlocal cino=(-20

if exists("*Get_ttcn_indent")
    finish
endif


" Returns the number of the closest previous line that contains code (i.e. it
" skips blank lines and pure comment lines)
function Get_previous_code_line(lnum)
    let i = a:lnum - 1
    while i > 0
        let i = prevnonblank(i)
        if getline(i) =~ '\*/\s*$'
            while getline(i) !~ '/\*' && i > 1
                let i = i - 1
            endwhile
            if getline(i) =~ '^\s*/\*'
                let i = i - 1
            else
                break
            endif
        elseif getline(i) =~ '^\s*//'
            let i = i - 1
        else
            break
        endif
    endwhile
    return i
endfunction

" Returns true if the given line contains code
function Is_code_line(lnum)
    return Get_previous_code_line(a:lnum + 1) == a:lnum
endfunction

" Returns the value of a given component of the 'cindent' option
function Parse_cindent(ch)
    let pat = a:ch . '[0-9]\+s\?' 
    let str = matchstr(&cinoptions, pat)
    if str == ""
        let n = &sw
    else
        let n = matchstr(str, '[0-9]\+')
        if str =~# 's'
            let n = n * &sw
        endif
    endif
    return n
endfunction

" cindent has problems with these constructs
let s:prob1 = '[^) \t]\s*:=\s*$'
let s:prob2 = '^\s*\i\+\s*:='
let s:prob3 = ',\s*$'

" Start of code block
let s:sblock = '^\s*\(\(module\|group\|type\|function\|testcase\|control\|alt\(step\)\?\|while\|do\|for\|if\|else\|interleave\)\>'
            \. '\|\(var\|const\)\s\+\i\+\s\+\i\+\s*:='
            \. '\|template\s\+\i\+\s\+\i\+\s*\(:=\|(\)'
            \. '\|\i\+\s*:=\s*{\)'

    function Get_ttcn_indent(lnum)
        let m1 = Get_previous_code_line(a:lnum)
        let m2 = Get_previous_code_line(m1)

        let prevl1 = getline(m1)
        let prevl2 = getline(m2)

        let thisl = getline(a:lnum)

        if prevl1 =~# s:prob1 && thisl !~ '^\s*{'
            echo "ind 1"
            let ind = indent(m1) + Parse_cindent('+')
        elseif prevl1 =~ s:prob2
            echo "ind 2"
            if prevl1 =~ '{[^}]*$'
                echo "ind 2-1"
                let ind = indent(m1) + &sw
            else
                if thisl =~ '^\s*}'
                    echo "ind 2-2"
                    let ind = indent(m1) - &sw
                elseif thisl =~ '^\s*);'
                    echo "ind 2-3"
                    let ind = cindent(a:lnum)
                elseif thisl =~ '^\s*)'
                    echo "ind 2-4"
                    let ind = indent(m1) - &sw
                else
                    echo "ind 2-5"
                    let ind = indent(m1)
                endif
            endif
        elseif prevl1 =~ ':=\s*{.*}'
            echo "ind 3"
            let ind = cindent(a:lnum)
        elseif prevl1 =~ ':=\s*{'
            echo "ind 3-1"
            let ind = indent(m1) + &sw
        elseif thisl =~# s:prob2 || thisl =~# '^\s*if('

            let i = m1

            while i > 0 && getline(i) !~# s:sblock
                let i = Get_previous_code_line(i)
            endwhile

            if getline(i) =~# '\<alt\(step\)\?\>\|\<interleave\>'
                let ind = indent(i) + 2*&sw
                echo "ind 4-1"
            elseif prevl1 =~ '^\s*)' || prevl1 =~ '^\s*}'
                let ind = indent(m1)
                echo "ind 4-2"
            elseif prevl1 =~ '^\s*(' || prevl1 =~ '^\s*{'
                let ind = indent(m1) + &sw
                echo "ind 4-3"
            else
                let ind = indent(m1)
                echo "ind 4-3"
            endif
        elseif prevl1 =~ s:prob3 || prevl2 =~ s:prob3 && !Is_code_line(a:lnum)
            echo "ind 5"
            let ind = indent(m1)
"         elseif prevl1 =~ '^\s*);'
"           echo "ind 6-1"
"             let ind = indent(m1) - &sw
        elseif prevl1 =~ '^\s*(\s*$'
            echo "ind 6-2"
            let ind = indent(m1) + &sw
"         elseif prevl1 =~ '^\s*)\s*$' && thisl !~ '^\s*}'
"            echo "ind 7"
"             let ind = indent(m1) - &sw
"         elseif (thisl =~# '^\s*runs on' || thisl =~# '^\s*return') && prevl1 =~ '^\s*)\s*$'
"            echo "ind 8"
"             let ind = indent(m1) - &sw
        elseif thisl =~# '^\s*runs on' || thisl =~# '^\s*return'
           echo "ind 9"
            let ind = indent(m1)
        elseif thisl =~# '^\s*('
            echo "ind 10"
            let ind = indent(m1)
        else
            echo "ind 11"
            let ind = cindent(a:lnum)
        endif

        return ind
    endfunction


