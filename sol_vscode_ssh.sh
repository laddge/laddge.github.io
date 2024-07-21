#!/bin/bash

# install homebrew
echo -e "\e[32;1mhomebrewのインストール(PCのパスワードを聞かれたりエンターを押すように要求されるので指示どおりに答えてください)\e[m\nエンターキーで進む >>>"
read
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install vscode
echo -e "\e[32;1mVSCodeのインストール\e[m"
brew install visual-studio-code

# install extensions
code --install-extension ms-ceintl.vscode-language-pack-ja \
  --install-extension ms-vscode-remote.remote-ssh

# ssh settings
echo -e "\e[32;1msshの設定\e[m"
if [ ! -e ~/.ssh/id_ed25519 ]; then
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
fi
echo -ne "\e[32;1msolのユーザー名 (x0000000): \e[m"
read user
echo
echo "
Host sol
    HostName sol.cc.uec.ac.jp
    User ${user}
    Port 22
    IdentityFile ~/.ssh/id_ed25519
    ServerAliveInterval 60
" >> ~/.ssh/config
echo -e "\e[32;1mこの後\"Are you sure you want to continue connecting (yes/no/[fingerprint])?\"と聞かれたら\"yes\"と答えて、パスワードを聞かれたらsolのパスワードを答えてください\e[m\nエンターキーで進む >>>"
read
ssh-copy-id sol
echo -e "\e[32;1m以上で設定は完了です\nVSCodeを開くと左下の端に青いボタンがあるのでそれを押し、上に出てくるメニューから\"ホストに接続\"=>\"sol\"を選ぶとsolのVSCodeのウィンドウを開くことができます\n左のアイコンがいくつか縦に並んでいるうちの一番上\"エクスプローラー\"から\"フォルダーを開く\"で編集するディレクトリを開くことができます\nHTMLを編集する場合は\"Live Preview\"という拡張機能を入れると便利です\e[m"
