FROM ubuntu:18.10

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update;\
apt-get install -y git;\
apt remove cmdtest;\
apt-get install -y software-properties-common curl wget sudo rsync;

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -;\
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list;\
add-apt-repository ppa:chris-lea/redis-server -y;\
add-apt-repository ppa:jonathonf/vim -y;\
add-apt-repository ppa:deadsnakes/ppa -y;

RUN apt-get update;\
apt-get upgrade -y;\
apt-get install --allow-unauthenticated -y supervisor zsh openssh-server yarn tmux nodejs tree htop cron silversearcher-ag tree ctags vim autojump mlocate redis-server ruby locales libpq-dev rpl python3.7 python3.7-dev python-pip;\
;\
pip2 install supervisor;\
mkdir -p /run/sshd;\
gem install gist;\
locale-gen zh_CN.UTF-8;\
update-locale LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8;\
cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime;

RUN git clone https://github.com/gmarik/Vundle.vim.git /usr/share/vim/vimfiles/bundle/Vundle.vim --depth=1;\
vim +PluginInstall +qall;\
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1;\
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 2;\
update-alternatives --set python /usr/bin/python2.7;\
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash;\
nvm install 8.9.0;\
nvm install node --latest-npm --reinstall-packages-from=node;\
yarn global add coffeescript parcel-bundler coffeelint prettier;\

RUN cd /tmp;\
    git clone https://github.com/ur-city/docker-dev.git docker --depth=1;\
    bash /tmp/docker/install.sh;\
    rm -rf /tmp/docker

USER root
CMD ["/etc/rc.local"]
