Vim Conf
=======

My configure of vim and vimrc , I use it to program in C,C++,Java and web language

In Linux:
    
    depend: astyle cscope ctags doxygen indent git

In Windows:
    
    depend: cscope.exe ctags.exe doxygen indent git.exe


####Install and Download


####Download

    git clone http://github.com/turing1988/vimconf.git

####Install

------------

In Linux:

First run it , Enter in the directory vimcomf/, run 
 
    ./vimupdate.sh 

Your conf of vim will be backup in $HOME.vim.bak and $HOME.vimrc.bak .

When vim cmd `BundleUpdate` is over . input `:qa!` to exit vim

Then new conf of vim !

-----------
In Windows

First run it , open the `CMD.EXE` 

    ./vimdupate.bat

Your conf of vim will be backup in $HOME.vim.bak and $HOME.vimrc.bak .

When vim cmd `BundleUpdate` is over . input `:qa!` to exit vim

Then new conf of vim !


####Update

In Linux :

Enter in the $HOME/.vim , run
 
     ./vimupdate.sh


####1). plugins

   'gmarik/vundle'

   'tomtom/checksyntax_vim'

   'scrooloose/nerdtree'

   'blak3mill3r/c.vim'

   'turing1988/ColorSamplerPack'

   'ervandew/supertab'

   'plasticboy/vim-markdown'

   'mattn/emmet-vim'

   'DrawIt'

   'DoxyGen-Syntax'

   'LargeFile'

   'lookupfile'

   'xptemplate'

   'QuickTemplate'

   'cecutil'

   'genutils'

   'calendar.vim--Matsumoto'

   'code_complete'

   'Color-Scheme-Explorer'

   'Dictionary'

   'Mark'

   'Tagbar'

   'vimwiki'

   'winmanager'

   'PHP-dictionary'

   'OmniCppComplete'

   'a.vim'

   'autoload_cscope.vim'

   'bufexplorer.zip'

   'doxygen-support.vim'

   'echofunc.vim'

   'FencView.vim'

   'fontsize.vim'

   'matchit.zip'

   'surround.vim'

   'TransferChinese.vim'

   'taglist.vim'

   'java.vim'

   'javascript.vim'

   'javacomplete'

#### 2).keybinds

   ,:leader key

   F1:help

   F2:generate tags and cscope

   F3:winmanager toggle

   F4:Taglist or Tagbar

   F5:lookupfile

   F6:Fencview

   F7:style

   F8:checksynatx

   F10:project

   F11:fullscreen


##More

   [My Vimwiki](http://mturing.com/wiki/wikihtml/Vim%E9%85%8D%E7%BD%AE%E5%A4%87%E6%B3%A8.html)

   [My Blog](http://mturing.com)
