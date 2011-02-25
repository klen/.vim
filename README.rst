Vim configuration
==================

This is my vim configuration. Have many python features.

.. contents::


Requirements
=============
- GIT_
- `Exuberant ctags`_ ::

    sudo apt-get install exuberant-ctags


Instalation
============

#. Clone this repository in your home dir: ::

    git clone git@github.com:klen/my.vim.git ~/.vim

#. Goto cloned directory and init submodules: ::

    cd ~/.vim && git submodule init && git submodule update

#. Create ``~/.vimrc`` file with content: ::

    source ~/.vim/rc.vim

#. Use your vim!


Note
=====
For more information see sources.


.. _Exuberant ctags: http://ctags.sourceforge.net/ 
.. _GIT: http://git-scm.com/
