" Vim syntax file
" Language:         Generic log file
" Maintainer:       MTDL9 <https://github.com/MTDL9>
" Latest Revision:  2020-08-23

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" Performance note: For large log files (>3000 lines), consider adding this
" to your ~/.vimrc to prevent syntax highlighting timeout:
"   autocmd FileType log setlocal redrawtime=10000


" Operators
"---------------------------------------------------------------------------
syn match logOperator display '[;,\?\.\<=\>\~\/\@\!$\%&\+\-\|\^(){}\*#]'
syn match logBrackets display '[\[\]]'
syn match logEmptyLines display '-\{3,}'
syn match logEmptyLines display '\*\{3,}'
syn match logEmptyLines display '=\{3,}'

" Numbers (integers and floats)
"---------------------------------------------------------------------------
syn match logNumber '\<-\?\d\+\>'
syn match logNumber '\<-\?\d\+\.\d\+\>'

" Hexadecimal numbers
"---------------------------------------------------------------------------
syn match logHexNumber display '0[xX][0-9a-fA-F]\+'

" Boolean keywords
"---------------------------------------------------------------------------
syn keyword logBoolean true false yes no on off enabled disabled active inactive

" Log level keywords
"---------------------------------------------------------------------------
syn keyword logLevelError ERROR FATAL FAILURE FAILED FAIL CRITICAL SEVERE SEVERE FATAL EXCEPTION
syn keyword logLevelWarn WARN WARNING WRN
syn keyword logLevelInfo INFO INFORMATION
syn keyword logLevelDebug DEBUG DBG
syn keyword logLevelTrace TRACE TRACING FINEST FINER

" System log levels
"---------------------------------------------------------------------------
syn keyword logLevelEmerg EMERG
syn keyword logLevelAlert ALERT
syn keyword logLevelCrit CRIT
syn keyword logLevelErr ERR
syn keyword logLevelWarn WARN
syn keyword logLevelNotice NOTICE
syn keyword logLevelInfo INFO
syn keyword logLevelDebug DEBUG

" ===========================================================================
" IP ADDRESS PATTERNS (IPv4 + IPv6)
" Defined after logNumber, logOperator so these groups win on
" overlapping positions (Vim last-definition-wins rule for syn match).
" ===========================================================================

" IPv4 plain addresses
"---------------------------------------------------------------------------
syn match logIpv4 '\<\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\>'

" Pure IPv6 - Full 8-segment addresses (optionally followed by CIDR prefix /0-128)
"---------------------------------------------------------------------------
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='

" Pure IPv6 - Compressed (all :: positions), longest first (CIDR prefix /0-128 supported)
"---------------------------------------------------------------------------

" 6 non-:: groups + ::
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='

" 5 non-:: groups + ::
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='

" 4 non-:: groups + ::
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='

" 3 non-:: groups + ::
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.\[0-9\]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='

" :: at start with 7, 6, 5, 4, 3, 2, 1 groups after
syn match logIPV6 '\(^\|\s\|\[\)\@<=::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|\[\)\@<=::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|\[\)\@<=::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|\[\)\@<=::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|\[\)\@<=::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|\[\)\@<=::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|\[\)\@<=::[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|\[\)\@<=::\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='

" 2 non-:: groups + ::
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='

" 1 non-:: group + ::
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='

" a::b and a::b:c forms
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}:[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}::[0-9a-fA-F]\{1,4}\(\.[0-9]\)\@!\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='
syn match logIPV6 '\(^\|\s\|[^:0-9a-fA-F]\)\@<=[0-9a-fA-F]\{1,4}::\(\/\d\{1,3}\)\?\([^:/0-9a-fA-F]\|$\)\@='


" URLs and file paths
"---------------------------------------------------------------------------
syn match logUrl '\(https\?://\|ftps\?://\|file://\)[^ \t]*'
syn match logFilePath display '\(\~\|/\)[^ \t]*'

" Dates (must be after logNumber to match date patterns first)
"---------------------------------------------------------------------------
" Matches 2018-03-12 or 12/03/2018 or 12/Mar/2018
syn match logDate '\d\{2,4}[-\/]\(\d\{2}\|Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)[-\/]\d\{2,4}T\?'
" Matches 8 digit numbers at start of line starting with 20 (e.g., 20260227)
syn match logDate '^20\d\{6}'

" Times (HH:MM:SS)
"---------------------------------------------------------------------------
" Matches 12:09:38 or 00:03:38.129Z or 01:32:12.102938 +0700
syn match logTime '\d\{2}:\d\{2}:\d\{2}\(\.\d\{2,6}\)\?\(\s\?[-+]\d\{2,4}\|Z\)\?\>' nextgroup=logTimeZone,logSysColumns skipwhite

" Time Zone (follows logTime)
syn match logTimeZone '[A-Z]\{2,5}\>\( \d\{4}\)\?' contained
syn match logTimeZone '\d\{4} [A-Z]\{2,5}\>' contained

" MAC addresses (defined after logTime so MAC wins over time on a full 6-group match)
"---------------------------------------------------------------------------
syn match logMacAddress '\<\([0-9a-fA-F]\{2}:\)\{5}[0-9a-fA-F]\{2}\>'

" SysLog (systemd and traditional syslog)
"---------------------------------------------------------------------------
syn match logSyslogLine '^.*\[\d\+\]:' contains=logDate,logTime
syn match logSyslogHostname '.*:' contained nextgroup=logSyslogMessage
syn match logSyslogMessage '\w.*' contained

" Syslog Columns (hostname, program and process number)
"---------------------------------------------------------------------------
" Matches: hostname program[pid]: or hostname program:
syn match logSysColumns '\w\(\w\|\.\|-\)\+ \(\w\|\.\|-\)\+\(\[\d\+\]\)\?:' contains=logOperator,logSysProcess contained
syn match logSysProcess '\(\w\|\.\|-\)\+\(\[\d\+\]\)\?:' contains=logOperator,logNumber,logBrackets contained

" XML Tags (simplified)
"---------------------------------------------------------------------------
syn match logXMLTag '<[^>]*>' contains=NONE

" Strings in quotes
"---------------------------------------------------------------------------
syn region logString start=+'+ end=+'+ skip=+\\'+ contains=NONE
syn region logString start=+"+ end=+"+ skip=+\\"+ contains=NONE

" Error and exception keywords (context highlighting)
"---------------------------------------------------------------------------
syn keyword logException Exception Throwable Caused Caused\ by

" Highlighting definitions
"---------------------------------------------------------------------------
hi def link logLevelError ErrorMsg
hi def link logLevelWarn WarningMsg
hi def link logLevelInfo Normal
hi def link logLevelDebug Function
hi def link logLevelTrace Comment
hi def link logLevelEmerg ErrorMsg
hi def link logLevelAlert ErrorMsg
hi def link logLevelCrit ErrorMsg
hi def link logLevelErr WarningMsg
hi def link logLevelWarn WarningMsg
hi def link logLevelNotice Normal
hi def link logLevelInfo Normal
hi def link logLevelDebug Function
hi def link logIPV6 Identifier
hi def link logIpv4 Identifier
hi def link logMacAddress Identifier
hi def link logUrl Underlined
hi def link logFilePath Underlined
hi def link logOperator Normal
hi def link logBrackets Normal
hi def link logNumber Number
hi def link logHexNumber Number
hi def link logBoolean Boolean
hi def link logTime Function
hi def link logDate Identifier
hi def link logSyslogLine Normal
hi def link logSysColumns Conditional
hi def link logSysProcess Include
hi def link logSyslogHostname Identifier
hi def link logSyslogMessage Normal
hi def link logXMLTag Function
hi def link logString String
hi def link logException ErrorMsg
hi def link logEmptyLines Normal


" Syntax synchronization
"---------------------------------------------------------------------------
" Force sync from file start to prevent mis-highlighting in large files
syn sync minlines=500

let b:current_syntax = 'log'

let &cpoptions = s:cpo_save
unlet s:cpo_save
