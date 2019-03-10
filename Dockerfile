FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update;\
apt-get install -y git;\
apt remove cmdtest;\
apt-get install -y software-properties-common curl wget sudo rsync;\
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -;\
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list;\
add-apt-repository ppa:neovim-ppa/stable -y;\
add-apt-repository ppa:chris-lea/redis-server -y;\
add-apt-repository ppa:jonathonf/vim -y;\
add-apt-repository ppa:deadsnakes/ppa -y;\
apt-get update;\
apt-get upgrade -y;\
apt-get install --allow-unauthenticated -y zsh openssh-server yarn tmux nodejs tree htop cron silversearcher-ag tree ctags neovim autojump mlocate redis-server ruby locales libpq-dev rpl python3.7 python3.7-dev python-pip tzdata postgresql-client lsof;\
gem install gist;\
locale-gen zh_CN.UTF-8;\
update-locale LC_ALL=zh_CN.UTF-8 LANG=zh_CN.UTF-8;\
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;\
dpkg-reconfigure -f noninteractive tzdata;\
mkdir -p /run/sshd;\
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh;\
(crontab -l 2>/dev/null; echo "5 5 * * * zsh -c 'DISABLE_AUTO_UPDATE=true && export ZSH=$HOME/.oh-my-zsh && source $ZSH/oh-my-zsh.sh && upgrade_oh_my_zsh 2>&1' >> /dev/null") | crontab -;


RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1;\
update-alternatives --install /usr/bin/python python /usr/bin/python2.7 2;\
update-alternatives --set python /usr/bin/python2.7;\
curl https://bootstrap.pypa.io/get-pip.py | python3;\
pip2 install supervisor;\
pip3 install virtualenv ipython;

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash;\
export NVM_DIR="$HOME/.nvm";\
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh";\
nvm install 8.9.0;\
nvm install stable;\
yarn global add coffeescript parcel-bundler coffeelint prettier js2coffee npm-check-updates;

RUN update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60;\
update-alternatives --set vi /usr/bin/nvim;\
update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60;\
update-alternatives --set vim /usr/bin/nvim;\
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60;\
update-alternatives --set editor /usr/bin/nvim;

RUN cd /tmp;\
git clone https://github.com/ur-city/docker-dev.git docker --depth=1;\
bash /tmp/docker/install.sh;\
rm -rf /tmp/docker;

# vim配置文件在上面的仓库里面，所以这一行必须放到之后执行
RUN curl -fLo /usr/share/nvim/runtime/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;\
nvim +PlugInstall +qall;

USER root

CMD ["/etc/rc.local"]
