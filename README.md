Vim Conf
=======

The configure repo of vim and vimrc is based the plugin bundle adn git .

It is cross-platform , include Windows and *nix , you can deploy it quickly .

It is mainly for C,C++,Java and web language . 

---
###Depend
In *nix and Windows     
    
    depend: 
        astyle 
        cscope 
        ctags 
        doxygen
        libiconv

###Install and Update

**Download**

    git clone http://github.com/turing1988/vimconf.git

**Deploy**

In *nix  , First run it, Enter in the directory vimcomf/ , run 
 
    ./vimupdate.sh 
    
In Windows , First run it , open the `CMD.EXE` , run

    ./vimdupate.bat

After it , your configure of vim will be backuped in $HOME.vim.bak and $HOME.vimrc.bak .

After vim cmd `BundleUpdate` runs over , Input `:qa!` to exit vim

Then new conf of vim is comming !


**Update**

In *nix  , Enter in the directory vimcomf/ , run 
 
    ./vimupdate.sh 
    
In Windows , open the `CMD.EXE` , run

    ./vimdupate.bat

--- 
#### Keybind

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
   
   Ctrl-F9: Complie with gcc

   F11:fullscreen



####Plugins included

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

   'vimcn/vimwiki.vim.cnx'

   'vimcn/tagbar.cnx'

   'vimcn/taglist.vim.cnx'

   'jkeylu/vimdoc_cn'

###More

  *  [My Vimwiki](http://mturing.com/wiki/wikihtml/Vim%E9%85%8D%E7%BD%AE%E5%A4%87%E6%B3%A8.html)

  *  [My Blog](http://mturing.com)
