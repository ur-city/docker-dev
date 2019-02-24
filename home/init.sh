#!/usr/bin/env bash
NOWDIR=$(cd "$(dirname "$0")"; pwd)
ROOT=`echo $NOWDIR | sed "s|^$HOME|.|"`

cd $NOWDIR

cp_home() {
rm ~/.$1
cp $NOWDIR/$1 ~/.$1
}

ln_home() {
rm -rf ~/.$1
ln -s $ROOT/$1 ~/.$1
}

ln_home bash_aliases
cp_home bashrc
cp_home zshrc
ln_home bash_profile
cp_home gitconfig
ln -s $ROOT/coffeelint.json ~/coffeelint.json

source ~/.bashrc
