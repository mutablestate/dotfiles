## Spacemacs Ruby / Elixir config for OSX

```
  brew install emacs --with-cocoa
  echo export PATH="$HOME/emacs:$PATH" >> ~/.bash_profile
  git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
  mv dotfiles/.spacemacs-osx Users/{name}/.spacemacs
```
Add `.rubocop.yml` to `Users/{name}`


## Vim Ruby / Elixir config revised for Mint 17

### Install solarized for Gnome Terminal

Add new GNOME terminal profile 'solarized'
```
  sudo apt-get install dconf-cli
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized
  cd gnome-terminal-colors-solarized
  ./install.sh
```

### Install dotfiles

```
  git clone https://github.com/mutablestate/dotfiles.git
  cd dotfiles
  ./bootstrap.sh
```

### Pull plugins

```
  cd dotfiles
  git submodule init
  git submodule update
```

### Add powerline fonts

```
git clone https://github.com/Lokaltog/powerline-fonts.git
cd powerline-fonts
sudo mv LiberationMono /usr/share/fonts/truetype
sudo fc-cache -fv
```
Edit 'solarized' GNOME Terminal profile and select Liberation Mono for Powerline
