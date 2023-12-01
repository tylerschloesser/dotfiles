
# Dev Setup

## SSH Key

```
ssh-keygen -t rsa -b 4096 -C "tylerschloesser@gmail.com"
```

```
cat ~/.ssh/id_rsa.pub|pbcopy
```

Add to github: https://github.com/settings/keys

Add to mac keychain:

```
ssh-add --apple-use-keychain ~/.ssh/id_rsa
```

## Mac Stuff

0. install brew: https://brew.sh/
 * TODO need to reorder stuff. Need to add to path AFTER zsh
0. install iterm: https://iterm2.com/
 * Install profile json
0. Map caps lock to control

```
brew install git tmux vim zsh coreutils
```

## powerline

0. install [powerline](https://powerline.readthedocs.io/en/latest/) ([github](https://github.com/powerline/powerline))
0. install [hack nerd font mono](https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts)

Find install directory and update tmux.conf

```
pip3 show powerline-status
```

## vim

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

coc-java requires JDK 11

example of coc-settings.json

```
{
  "java.jdt.ls.vmargs": "-javaagent:/Users/tschloes/java-stuff/lombok-1-18-18.jar",
  "java.format.settings.url": "file:///Users/tschloes/java-stuff/fixed-google-format.xml",
  "java.completion.importOrder": []
}
```

## zsh

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

## tmux

```
ln -s `readlink -f .tmux.conf` ~/.tmux.conf
```

or on mac

```
ln -s `greadlink -f .tmux.conf` ~/.tmux.conf
```


if tmux flickers, remove uptime from powerline config

## node

0. use [nvm](https://github.com/nvm-sh/nvm)
0. otherwise check [nodesource](https://github.com/nodesource/distributions/blob/master/README.md)
0. install lts
```
nvm install --lts
```

## chrome

0. install [react developer tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en)

# Mac Software

* [Flux](https://justgetflux.com/)
* [RunCat](https://apps.apple.com/us/app/runcat/id1429033973?mt=12)
* [Magnet](https://apps.apple.com/us/app/magnet/id441258766?mt=12)
* [AltTab](https://alt-tab-macos.netlify.app/)

CloudDocs

```
cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/
```
