" Vim compiler file
" Compiler:	Unit testing tool for Python
" Maintainer:	Max Ischenko <mfi@ukr.net>
" Last Change: 2004 Mar 27

let current_compiler = "nosetests"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=nosetests
CompilerSet efm=\ \ File\ \"%f\"\\,\ line\ %l\\,\ %m

