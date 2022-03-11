# SSH Key

```
ssh-keygen -t rsa -b 4096 -C "tylerschloesser@gmail.com"
```

```
cat ~/.ssh/id_rsa.pub|pbcopy
```

Add to github: https://github.com/settings/keys

# Mac Stuff

0. install brew: https://brew.sh/
1. install iterm: https://iterm2.com/

```
brew install git tmux vim zsh coreutils
```

# powerline

0. install [powerline](https://powerline.readthedocs.io/en/latest/) ([github](https://github.com/powerline/powerline))
0. install [powerline fonts](https://github.com/powerline/fonts)

# vim

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

# zsh

0. Install prezto https://github.com/sorin-ionescu/prezto

0. Link zshrc-common

```
ln -s `readlink -f zshrc-common` ~/.zshrc-common
```

or on mac

```
ln -s `greadlink -f zshrc-common` ~/.zshrc-common
```

0. Add this to .zshrc

DON'T ADD TO .zprofile. It doesn't work for some reason.

```sh
source "${ZDOTDIR:-$HOME}/.zshrc-common"
```

# tmux

```
ln -s `readlink -f .tmux.conf` ~/.tmux.conf
```

or on mac

```
ln -s `greadlink -f .tmux.conf` ~/.tmux.conf
```


if tmux flickers, remove uptime from powerline config

# node

0. use [nvm](https://github.com/nvm-sh/nvm)
0. otherwise check [nodesource](https://github.com/nodesource/distributions/blob/master/README.md)
0. install lts
```
nvm install --lts
```

# chrome

0. install [react developer tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en)
