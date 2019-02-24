#!/usr/bin/env bash

NOWDIR=$(cd "$(dirname "$0")"; pwd)

apt remove cmdtest
apt-get install -y software-properties-common curl wget sudo rsync
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
add-apt-repository ppa:chris-lea/redis-server -y
add-apt-repository ppa:jonathonf/vim -y
add-apt-repository ppa:deadsnakes/ppa -y
apt-get update
apt-get upgrade -y
apt-get install  --allow-unauthenticated -y supervisor zsh openssh-server yarn tmux nodejs tree htop cron silversearcher-ag tree ctags vim autojump mlocate redis-server ruby locales libpq-dev rpl python3.7 python3.7-dev python-pip supervisor

gem install gist
locale-gen zh_CN.UTF-8
update-locale LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8

cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 2
update-alternatives --set python /usr/bin/python2.7


cd ~/
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh_host()
{
ssh-keyscan -t rsa,dsa $1 >> ~/.ssh/known_hosts
}

ssh_host code.aliyun.com
ssh_host github.com
ssh_host gitee.com

sort -u -o  ~/.ssh/known_hosts ~/.ssh/known_hosts

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

nvm install 8.9.0
nvm install node --latest-npm --reinstall-packages-from=node

yarn global add coffeescript parcel-bundler coffeelint prettier
rsync -av $NOWDIR/os/ /;

git clone https://github.com/gmarik/Vundle.vim.git /usr/share/vim/vimfiles/bundle/Vundle.vim --depth=1;
vim +PluginInstall +qall;
updatedb

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
chsh -s /usr/bin/zsh root
