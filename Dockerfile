FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update;\
apt-get install -y git;\
apt remove cmdtest;\
apt-get install -y software-properties-common curl wget sudo rsync;

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -;\
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list;\
add-apt-repository ppa:chris-lea/redis-server -y;\
add-apt-repository ppa:jonathonf/vim -y;\
add-apt-repository ppa:deadsnakes/ppa -y;\
apt-get update;\
apt-get upgrade -y;\
apt-get install --allow-unauthenticated -y supervisor zsh openssh-server yarn tmux nodejs tree htop cron silversearcher-ag tree ctags vim autojump mlocate redis-server ruby locales libpq-dev rpl python3.7 python3.7-dev python-pip tzdata postgresql-client lsof;\
pip2 install supervisor;\
mkdir -p /run/sshd;\
gem install gist;\
locale-gen zh_CN.UTF-8;\
update-locale LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8;\
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;\
dpkg-reconfigure -f noninteractive tzdata;\
git clone https://github.com/gmarik/Vundle.vim.git /usr/share/vim/vimfiles/bundle/Vundle.vim --depth=1;\
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh;\
update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1;\
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 2;\
update-alternatives --set python /usr/bin/python2.7;

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash;\
export NVM_DIR="$HOME/.nvm";\
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh";\
nvm install 8.9.0;\
nvm install stable;\
yarn global add coffeescript parcel-bundler coffeelint prettier js2coffee npm-check-updates;

RUN curl https://bootstrap.pypa.io/get-pip.py | python3;\
pip3 install virtualenv ipython

RUN cd /tmp;\
git clone https://github.com/ur-city/docker-dev.git docker --depth=1;\
bash /tmp/docker/install.sh;\
rm -rf /tmp/docker;\
vim +PluginInstall +qall;

USER root
CMD ["/etc/rc.local"]
