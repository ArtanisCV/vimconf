if has("ole")
	" 自动载入VIM配置文件
  autocmd! bufwritepost _vimrc source %
  autocmd! bufwritepost .vimrc source % 
	set guifont=Consolas:h14:cANSI
  set rtp+=$HOME/.vim/
else
	autocmd! bufwritepost .vimrc source % 
	set guifont=Consolas\ 13
endif
set go=tm
""Vim帮助文档
:source $VIMRUNTIME/ftplugin/man.vim
if v:version < 700
	echoerr 'This _vimrc requires Vim 7 or later.'
	quit
endif
"====================
"函数定义
"================== 
"去除当前所编辑文件的路径信息，只保留文件名
set guitablabel=%{ShortTabLabel()}
func! ShortTabLabel()
	let bufnrlist = tabpagebuflist(v:lnum)
	let label = bufname(bufnrlist[tabpagewinnr(v:lnum) -1])
	let filename = fnamemodify(label, ':t')
	return filename
endfunc

"定义FormartSrc()
"C程序,Perl程序,Python程序Java程序
func! FormartSrc()
	exec "w"
	if &filetype == 'c'
		exec "!astyle --style=ansi -U -p --break-elseifs  --suffix=none %"
		exec "e! %"
	elseif &filetype == 'cpp'
		exec "!astyle -q --style=ansi -U  -P --break-elseifs  --suffix=none %"
		"exec "e! %"
	elseif &filetype == 'perl'
		exec "!astyle --style=ansi --suffix=none %"
		exec "e! %"
	elseif &filetype == 'py'
		exec "!astyle --style=ansi --suffix=none %"
		exec "e! %"
	elseif &filetype == 'java'
		exec "!astyle --style=java --suffix=none %"
		exec "e! %"
	elseif &filetype == 'jsp'
		exec "!astyle --style=ansi --suffix=none %"
		exec "e! %"
	elseif &filetype == 'xml'
		exec "!astyle --style=ansi --suffix=none %"
		exec "e! %"
	elseif &filetype == 'html'
		exec "!astyle --style=ansi --suffix=none %"
		exec "e! %"
	elseif &filetype == 'htm'
		exec "!astyle --style=ansi --suffix=none %"
		exec "e! %"
	endif
	return
endfunc

"括号自动补全
function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function! CloseBracket()
	if match(getline(line('.') + 1), '\s*}') < 0
		return "\<CR>}"
	else
		return "\<Esc>j0f}a"
	endif
endf

function! QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		"Inserting a quoted quotation mark into the string
		return a:char
	elseif line[col - 1] == a:char
		"Escaping out of the string
		return "\<Right>"
	else
		"Starting a string
		return a:char.a:char."\<Esc>i"
	endif
endf

"递归查找tag cscope.out"
function! Do_CsTag()
	let dir = getcwd()
	"ctags"
	if(executable('ctags'))
		if filereadable("../tags")
			if has('ole')
				silent! execute "let NOWDIR=getcwd()|cd ../"
				silent! execute "!gentags.bat"
				silent! execute "cd NOWDIR"
			else
				silent! execute "!NOWDIR=$(pwd);cd ../;ctags -R --recurse=yes --c-types=+p --fields=+lS $(pwd)/;cd $NOWDIR"
				""elseif  &filetype == 'cpp'
				silent! execute "!NOWDIR=$(pwd);cd ../;ctags -R --recurse=yes --c++-kinds=+p --fields=+iaS --extra=+q $(pwd)/;cd $NOWDIR"
			endif
			set tags+=../tags
		else
			if has('ole')
				silent! execute "!gentags.bat"
			else
				silent! execute "!ctags -R --recurse=yes --c-types=+p --fields=+lS $(pwd)/"
				""elseif  &filetype == 'cpp'
				silent! execute "!ctags -R --recurse=yes --c++-kinds=+p --fields=+iaS --extra=+q $(pwd)/"
			endif
			set tags+=./tags,tags
		endif
	endif

	"cscope"
	if (executable('cscope') && has("cscope") )
		if has('ole')
			silent! execute "!taskkill /F /IM cscope.exe"
		else
			silent! execute "cs kill -1"
		endif
		if ( filereadable("../cscope.out") )
			if has('ole')
				silent! execute "let NOWDIR=getcwd()|cd ../"
				silent! execute "!gencscope.bat"
				silent! execute "cd NOWDIR"
			else
				silent! execute "!NOWDIR=$(pwd);cd ../;find $(pwd)/  -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' >$(pwd)/cscope.files;cscope  -Rbq ;cd $NOWDIR"
			endif
			execute "normal :"
			set nocsverb
			exec "cs add ../cscope.out"
			set csverb
		else
			if has('ole')
				silent! execute "!gencscope.bat"
			else
				silent! execute "!find $(pwd)/  -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' >$(pwd)/cscope.files"
				silent! execute "!cscope -Rbq "
			endif
			execute "normal :"
			set nocsverb
			exec "cs add cscope.out"
			set csverb
		endif
	endif

	set cst    "同时查找tags cscope
	set csto=1 "优先查找tags
endf

"tag浏览设置"
func! TagConf()
	if ( &filetype == "c" )
		let g:Tlist_Inc_Winwidth=0            " 禁止自动改变当前Vim窗口的大小
		let g:Tlist_Use_Right_Window=1        " 把方法列表放在屏幕的右侧
		let g:Tlist_File_Fold_Auto_Close=1    " 让当前不被编辑的文件的方法列表自动折叠起来， 这样可以节约一些屏幕空间
		let g:Tlist_Auto_Highlight_Tag = 1    " 是否高亮显示当前标签
		let g:Tlist_Auto_Open = 0             " 自动打开Tlist
		let g:Tlist_Auto_Update = 1           " 自动更新Tlist
		let g:Tlist_Close_On_Select = 0       " 选择标签或文件后是否自动关闭标签列表窗口
		let g:Tlist_Compact_Format = 1        " 压缩方式
		let g:Tlist_Display_Prototype = 0     " 是否在标签列表窗口用标签原型替代标签名
		let g:Tlist_Display_Tag_Scope = 1     " 在标签名后是否显示标签有效范围
		let g:Tlist_Enable_Fold_Column = 0    " 不显示折叠树
		let g:Tlist_Exit_OnlyWindow = 1       " 关闭VIM同时关闭Tlist
		let g:Tlist_Show_One_File = 1
    let g:Tlist_GainFocus_On_ToggleOpen = 1 " 为1则使用TlistToggle打开标签列表窗口后会获焦点至于标签列表窗口；为0则taglist打开后焦点仍保持在代码窗口
		let g:tlist_php_settings = 'php;c:class;i:interfaces;d:constant;f:function'
		exec "TlistToggle"
  else
		exec "TagbarToggle"
		""let g:tagbar_foldlevel = 2          " 设置tagbar的折叠级别
	endif
endfunc
" =====================
" 环境配置
" =====================
set helplang=cn     " 中文帮助
set history=500     " 保留历史记录
set nocompatible    " 设置不兼容VI
"set textwidth=100  " 设置每行100个字符自动换行，加上换行符
set wrap            " 显示文本时自动折行，不影响保存
set linebreak       " 显示文本时英文单词在wrap换行时不被截断 按照breakat的字符折行 lbr
set tabpagemax=15   " 最多15个标签
set showtabline=1   " 0 永不显示标签栏 1 至少两个时显示 2 总是显示标签栏
set noerrorbells    " 关闭遇到错误时的声音提示
set novisualbell    " 不要闪烁
set t_vb=           " close visual bell
filetype plugin indent on " 打开文件类型检测
set ruler           " 显示标尺
set number          " 行号
set numberwidth=4
set rulerformat=%15(%c%V\ %p%%%)
set t_Co=256        " 设置256色
set cmdheight=1     " 设置命令行的高度
set laststatus=2    " 始终显示状态行
set stl=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ [PATH]\ %{getcwd()}%h\ %=\ [line]%l/%L\ [col]%c/%V
set scrolloff=2     " 光标移到buffer的顶部与底部保持行距离
au FileType c,cpp set cc=81 "高亮第81列
set showcmd         " 状态栏显示目前所执行的指令
set cursorline      " 高亮光标所在行
"set cursorcolumn   " 高亮光标所在列
set nohlsearch      " 高亮显示搜索的内容
set incsearch       " 显示查找匹配过程
set magic           " Set magic on, for regular expressions
set showmatch       " Show matching bracets when text indicator is over them
set mat=2           " How many tenths of a second to blink
set tabstop=4       " 制表符(设置所有的tab和缩进为4个空格)
set shiftwidth=4
set softtabstop=4
set expandtab       " 使用空格来替换tab
set smarttab
"set list           " 显示tab和空格
set listchars=tab:\|\ ,nbsp:%,trail:-   " 设置tab和空格样式
set autoindent      " 复制上一行的缩进
set smartindent     " 设置智能缩进
set cin             " 设置C语言形式的缩进
set autoread        " 当文件在外部被修改，自动更新该文件
set mouse=a         " 设定在任何模式下光标都可用
set backspace=indent,eol,start " 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set nobackup        " 无备份和缓存
set nowb
set noswapfile
set complete=.,w,b,k,t,i
set completeopt=longest,menu " 只在下拉菜单中显示匹配项目，并且会自动插入所有匹配项目的相同文本
set wildmenu        " 增强模式下的命令行自动完成功能
set foldnestmax=2   " 折叠深度
""set foldcolumn=2    " 设置折叠窗口的宽度
set foldopen=all    " 光标遇到折叠时。折叠自动打开
set foldclose=all   " 移动光标离开折叠时自动折叠
set foldlevel=100   " 启动时不要自动折叠代码
set foldmethod=marker  " 按语法折叠
set foldmethod=syntax
set bsdir=buffer    " 设定文件浏器目录为当前目录
set autochdir       " 自动切换当前目录为当前文件所在的目录
""set binary					""维持文件末尾原样 不自动添加空行
"autocmd VimLeave * mksession! Session.vim
"set noendofline binary ""避免在文件末尾添加空行

" =====================
" 多语言环境 默认为 UTF-8 编码
" =====================
if has("multi_byte")
	set encoding=utf-8
	let &termencoding=&encoding 
  au BufRead * set fileencodings=utf-8,cp936,gb2312,gbk,gb18030,ucs-2le,chinese,utf-8
  au BufRead * set fileformats=unix,dos
	""vim编码猜测列表
	if has('ole')
		source $VIMRUNTIME/delmenu.vim		" 处理consle输出乱码
		source $VIMRUNTIME/menu.vim
	endif
	""存储编码
	set fileencoding=utf-8
	language messages zh_CN.utf-8
	set formatoptions+=mM           " 正确处理中文字符的折行和拼接
	set nobomb                      " 不使用 Unicode 签名
	if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
		set ambiwidth=double
	endif
else
	echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif


" =====================
" AutoCmd 自动运行
" =====================
if has("autocmd") " 括号自动补全
	inoremap ( ()<Esc>i
	inoremap [ []<Esc>i
	inoremap { {<CR>}<Esc>O
	autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
	inoremap ) <c-r>=ClosePair(')')<CR>
	inoremap ] <c-r>=ClosePair(']')<CR>
	inoremap } <c-r>=CloseBracket()<CR>
	inoremap " <c-r>=QuoteDelim('"')<CR>
	inoremap ' <c-r>=QuoteDelim("'")<CR>
endif

" =====================
" 修改后自动更新tags cscope.out
" =====================
au bufwritepost *.c,*.cpp,*.h,*.java call Do_CsTag()
"set cscopequickfix=s-,c-,d-,i-,t-,e-,g0
"nmap <C-t> :colder<CR>:cc<CR>

" =====================
" 插件配置
" 快捷键
" =====================
"设置','为leader快捷键
let mapleader = ","
let g:mapleader = ","
let g:C_LineEndCommColDefault    = 80
let g:Templates_MapInUseWarn = 0		"cvim的配置

"设置快速保存和退出
nmap <leader>s :w!<cr>			
nmap <leader>w :wq!<cr>		
nmap <leader>q :q!<cr>	

"打开与关闭标签
nmap <leader>tt :tabnew .<cr>
nmap <leader>tc :tabclose<cr>

" 打开日历快捷键
map ca :Calendar<cr>

" ctags cscope setting
" 自动生成cscope与tags
let Tlist_Use_Right_Window=1        " 把方法列表放在屏幕的右侧
map <F2> :call Do_CsTag() <cr>:redraw!<cr>
"cscope配置"
"s  查找C语言符号，函数 宏 枚举     g  查找选中量定义的位置，类似ctags的功能
"c  查找调用本函数的函数            t  查找指定的字符串
"e  查找egrep模式 相当于egrep功能   f  查找并打开文件，类似vim的find功能
"i  查找包含本文的文件              d  查找本函数调用的函数
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sc :cs find c <c-r>=expand("<cword>")<cr><cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>si :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>

"<F3>   调出winmanager的文件浏览器
let g:winManagerWidth=25    "buffer宽度
function! BufExplorer()
    call BufExplorer(...)
endfunction
"let  g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer'
let  g:winManagerWindowLayout = 'FileExplorer|BufExplorer'
map <F3> :WMToggle<cr>

"<F4> 打开tag浏览器 默认为Taglist  面向对象语言是Tagbar  面向过程语言是Taglist
map <F4> :call TagConf()<cr>
"map <a-F4> :call ToggleSketch()<cr>

"<F5>   Lookupfile
let g:LookupFile_TagExpr = '"tags"' " lookup file tag file

"自动检测编码用F6控制(fencview.vim)
let g:fencview_autodetect=1					"关闭自动检测编码用F6控制(fencview.vim)
map <F6> :FencView<cr>

let g:checksyntax_key_single = '<C-F8>'   
let g:checksyntax_key_all = '<F8>'

"<F7>   源代码格式化
if has('unix')
	map <F7> :call FormartSrc()<cr><cr>
endif

""<F10> project配置
let g:groj_flags='scL'							"当选择文件时 显示其路径
nmap <silent><F10> <PLUG>ToggleProject

""Doxygen 
"添加注释快捷键 默认行末注释\cl 默认代码成为注释\c*
"为了生成doxygen文档 统一采用doxygen注释方法
",dfh 生成文件头信息
",dol 生成跨行注释
",dos 生成单行注释
",dof 生成函数注释
",doc 生成结构体注释
let g:Doxy_FormatDate= '%D'
let g:Doxy_FormatTime= '%H:%M'
let g:Doxy_FormatYear= 'year %Y'
imap <leader>dfh <ESC>:DoxyFILEHeader<cr>
imap <leader>dbl <ESC>:DoxyBlockLong<cr>
imap <leader>dbs <ESC>:DoxyBlockShort<cr>
imap <leader>dfc <ESC>:DoxyFunction<cr> 
imap <leader>dcl <ESC>:DoxyClass<cr>

"==================
" VimWiki 配置
"=================
let tlist_vimwiki_settings = 'wiki;h:Headers'       " ~/.ctags使taglist支持wikitag
let g:vimwiki_camel_case = 0                        " 对中文用户来说，我们并不怎么需要驼峰英文成为维基词条
let g:vimwiki_hl_cb_checked = 1                     " 标记为完成的 checklist 项目会有特别的颜色
"let g:vimwiki_menu = ''                            " 我的 vim 是没有菜单的，加一个 vimwiki 菜单项也没有意义
let g:vimwiki_folding = 1                           " 是否开启按语法折叠 会让文件比较慢
let g:vimwiki_CJK_length = 1                        " 是否在计算字串长度时用特别考虑中文字符,对vim73用户该选项已经过时
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1,pre' " 设置在wiki内使用的html标识...
let g:vimwiki_use_mouse = 1                         " 启用鼠标
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_calendar = 1                          " 使用日历,默认开启
let g:vimwiki_auto_checkbox = 0
let g:vimwiki_html_header_numbering = 2 "开启标题的编号 从二级标题开始
let privatewiki = {}								"新建privatewiki配置
let sharewiki = {}									"新建sharewiki配置
let sharewiki.index = 'index'
nmap <leader>va :VimwikiAll2HTML<cr>
let g:vimwiki_list=[privatewiki,sharewiki]					" 注册vimwiki
",vh 快速转化为html .vb快速转化后浏览器浏览 ,va 所有转化为html
nmap <leader>vh :Vimwiki2HTML<cr><cr>								
nmap <leader>vb :Vimwiki2HTMLBrowse<cr><cr>
"map <Leader>wd <Plug>VimwikiDeleteLink             " 删除当前页
"map <Leader>rr <Plug>VimwikiRenameLink             " 更改当前页的名称
"map <leader>wq <Plug>VimwikiToggleListItem					" 对[]中的选中切换
au FileType vimwiki set ff=unix fenc=utf-8 noswapfile nobackup
au FIleType vimwiki set cursorcolumn                " wiki页面使用列高亮 便于列对齐

" =====================
" 主题配色
" =====================
if has('syntax')
	au BufNewFile,BufRead *.doxygen setfiletype doxygen
	" 各不同类型的文件配色不同
	" 保证语法高亮
  if has("ole")
    au BufNewFile,BufRead,BufEnter,WinEnter * colo night "motus herald lucius wombat256 
    au BufNewFile,BufRead,BufEnter,WinEnter *.wiki colo night "motus herald lucius
  else 
    au BufNewFile,BufRead,BufEnter,WinEnter * colo night "motus herald lucius wombat256 
    au BufNewFile,BufRead,BufEnter,WinEnter *.wiki colo night  "motus herald lucius
  endif
  syntax on
endif

"WEB DEV"
"配置tab宽度
au FileType html,python,vim,javascript,tpl setl shiftwidth=2 "cindent缩进的空格数" 
au FileType html,python,vim,javascript,tpl setl tabstop=2    "打印时tab占用的空格数"
au FileType java,php setl shiftwidth=4
au FileType java,php setl tabstop=4

"ZenCodeing"
let g:user_zen_settings = {
      \ 'php' : {
      \ 'extends' : 'html',
      \ 'filters' : 'c',
      \ },
      \ 'xml' : {
      \ 'extends' : 'html',
      \ },
      \ 'haml' : {
      \ 'extends' : 'html',
      \ },
      \}
let g:user_zen_expandabbr_key = '<Tab>'
let g:user_emmet_leader_key ="<C-e>"


""==================
"插件管理"
"==================
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tomtom/checksyntax_vim'
Bundle 'scrooloose/nerdtree'
Bundle 'blak3mill3r/c.vim'
Bundle 'turing1988/ColorSamplerPack'
Bundle 'ervandew/supertab'
Bundle 'plasticboy/vim-markdown'
Bundle 'mattn/emmet-vim'

Bundle 'DrawIt'
Bundle 'DoxyGen-Syntax'
Bundle 'LargeFile'
Bundle 'lookupfile'
Bundle 'xptemplate'
Bundle 'QuickTemplate'
Bundle 'cecutil'
Bundle 'genutils'
Bundle 'calendar.vim--Matsumoto'
Bundle 'code_complete'
Bundle 'Color-Scheme-Explorer'
Bundle 'Dictionary'
Bundle 'Mark'
Bundle 'Tagbar'
Bundle 'vimwiki'
Bundle 'winmanager'
Bundle 'PHP-dictionary'
Bundle 'OmniCppComplete'

Bundle 'a.vim'
Bundle 'autoload_cscope.vim'
Bundle 'bufexplorer.zip'
Bundle 'doxygen-support.vim'
Bundle 'echofunc.vim'
Bundle 'FencView.vim'
Bundle 'fontsize.vim'
Bundle 'matchit.zip'
Bundle 'surround.vim'
Bundle 'TransferChinese.vim'
Bundle 'taglist.vim'
Bundle 'java.vim'
Bundle 'javascript.vim'
Bundle 'javacomplete'

"vim_cn"
Bundle 'vimcn/vimwiki.vim.cnx'
Bundle 'vimcn/tagbar.cnx'
Bundle 'vimcn/taglist.vim.cnx'
Bundle 'jkeylu/vimdoc_cn'

filetype plugin indent on
"mark.vim
" vim: set et sw=4 ts=4 sts=4 fdm=marker ft=vim ff=unix fenc=utf8:
