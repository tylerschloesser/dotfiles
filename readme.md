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

# powerline

0. install [powerline](https://powerline.readthedocs.io/en/latest/) ([github](https://github.com/powerline/powerline))
0. install [powerline fonts](https://github.com/powerline/fonts)


# zsh

## installation

0. Install prezto https://github.com/sorin-ionescu/prezto

0. Link zshrc-common

```
ln -s `readlink -f zshrc-common` ~/.zshrc-common
```

0. Add this to .zshrc

```sh
source "${ZDOTDIR:-$HOME}/.zshrc-common"
```

# tmux

ln -s `readlink -f .tmux.conf` ~/.tmux.conf
