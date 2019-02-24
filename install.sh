#!/usr/bin/env bash

NOWDIR=$(cd "$(dirname "$0")"; pwd)

apt remove cmdtest
apt-get install -y software-properties-common

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
add-apt-repository ppa:chris-lea/redis-server -y
add-apt-repository ppa:jonathonf/vim -y
add-apt-repository ppa:deadsnakes/ppa -y
apt-get update
apt-get upgrade -y
apt-get install  --allow-unauthenticated -y supervisor zsh openssh-server yarn tmux nodejs tree htop cron silversearcher-ag tree ctags vim autojump mlocate redis-server ruby locales libpq-dev rpl python3.7 python3.7-dev

gem install gist
locale-gen zh_CN.UTF-8
update-locale LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8


chsh -s /usr/bin/zsh $USER
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

cd ~/

ssh_host()
{
ssh-keyscan -t rsa,dsa $1 >> ~/.ssh/known_hosts
}

ssh_host code.aliyun.com
ssh_host github.com
ssh_host gitee.com

sort -u -o  ~/.ssh/known_hosts ~/.ssh/known_hosts

nvm install 8.9.0
nvm install node --latest-npm --reinstall-packages-from=node

yarn global add coffeescript parcel-bundler coffeelint prettier
sudo rsync -av $NOWDIR/os/ /;

sudo git clone https://github.com/gmarik/Vundle.vim.git /usr/share/vim/vimfiles/bundle/Vundle.vim --depth=1;
sudo vim +PluginInstall +qall;
sudo updatedb

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
./home/init.sh
