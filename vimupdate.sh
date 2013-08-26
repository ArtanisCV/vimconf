#!/bin/bash

cat <<eof
In Linux:
    
    depend: astyle cscope ctags doxygen indent

In Windows:
    
    depend: cscope.exe ctags.exe doxygen indent
eof

CURDIR=$PWD
CURVIMRC=$PWD/vimrc
VIMDIR=$HOME/.vim
VIMDIRBAK=$HOME/.vim.bak
VIMRC=$HOME/.vimrc
VIMRCBAK=$HOME/.vimrc.bak
echo $CURDIR

if ! [ -a $VIMDIR/bundle/vundle ]
then
    if [ -e $VIMDIR ] || [ -e $VIMRC ]
    then
        echo "backup the $VIMDIR to $VIMDIRBAK,$VIMRC to $VIMRCBAK"
        rm -rf $VIMDIRBAK $VIMRCBAK
        mv -f  $VIMDIR $VIMDIRBAK
        mv -f  $VIMRC $VIMRCBAK
    fi
    cp -rf $CURDIR $VIMDIR
    cp -rf $CURVIMRC $VIMRC
    cd $VIMDIR
    
    echo -e 'Start to clone bundle '
    git clone  https://github.com/gmarik/vundle.git $VIMDIR/bundle/vundle
    
    echo -e  "Please wait for five minutes! Then the vim would have been installed !"
    
    sleep 5
   
    vim -c 'BundleUpdate'
    
    git status
    
    ###procress patch
    if [ -e $VIMDIR/bundle/doxygen-support.vim/plugin/doxygen-support.vim ]
    then
        cp -rf patch/doxygen-support.vim $VIMDIR/bundle/doxygen-support.vim/plugin/doxygen-support.vim
    fi
    if [ -e $VIMDIR/bundle/QuickTemplate/plugin/Template.vim ]
    then
        cp -rf patch/Template.vim $VIMDIR/bundle/QuickTemplate/plugin/Template.vim
    fi
    if [ -e $VIMDIR/bundle/winmanager/plugin/winmanager.vim ]
    then
        cp -rf patch/winmanager.vim $VIMDIR/bundle/winmanager/plugin/winmanager.vim 
    fi
    echo -e 'Check installed, and change color to wombat256!'
    
    vim -c "%s/night/wombat256/g|w!"
    
    echo -e  "Deploy finished , You can run this script to update!"

    cd $CURDIR
else
    echo -e 'Start updating!'
    
    cd $VIMDIR
    git pull
    
    echo -e "Please wait for five minutes! Then the vim would finish updating!"
    
    vim -c 'BundleUpdate'
    
    echo -e "Update finished"
    
    git status

    cd $CURDIR
fi
exit
