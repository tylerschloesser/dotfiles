# .vimrc

## installation
0. setup ssh key
1. clone repo
    ```
    git clone git@github.com:tylerschloesser/dotfiles.git && cd dotfiles
    ```
2. run install script
    ```
    ./install-vimrc.sh
    ```
3. install [Vundle](https://github.com/VundleVim/Vundle.vim)
    ```
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ```
4. install Vundle plugins
    ```
    vim +BundleInstall +qall
    ```
5. install [YouCompleteMe](https://github.com/Valloric/YouCompleteMe#installation)


# .zshrc

## installation

1. install [prezto](https://github.com/sorin-ionescu/prezto)
2. run install script
    ```
    ./install-zshrc.sh
    ```
