Ruby / Elixir revised for Mint 17
================================
Install solarized for Gnome Terminal
------------------------------------
'''
  sudo apt-get install dconf-cli
  git clone https://github.com/Anthony25/gnome-terminal-colors-solarized
  cd gnome-terminal-colors-solarized
  ./install.sh
'''

Install dotfiles 
----------------
'''
  git clone https://github.com/mutablestate/dotfiles.git
  cd dotfiles
  ./bootstrap.sh
'''

Pull plugins
------------
'''
  cd dotfiles
  git submodule init
  git submodule update
'''
