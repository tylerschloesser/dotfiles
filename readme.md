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
3. install [vim-plug](https://github.com/junegunn/vim-plug)
    ```
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```
4. install vim-plug plugins
    ```
    vim +PlugInstall +qall
    ```
5. install [YouCompleteMe](https://github.com/Valloric/YouCompleteMe#installation)


# .zshrc

## installation

1. install [prezto](https://github.com/sorin-ionescu/prezto)
2. run install script
    ```
    ./install-zshrc.sh
    ```
