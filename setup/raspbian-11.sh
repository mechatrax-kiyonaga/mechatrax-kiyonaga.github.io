#!/usr/bin/env bash

set -eu

REPO=http://mechatrax-kiyonaga.github.io/
DIST=bullseye
DEB=mechatrax-archive-keyring_2016.12.19.3_all.deb
#SHA256=de828a5a50bd53369830d603f18f777e5fcbcd0830b1f714982a0da53ebbc6e6
SHA256=d7aa68b15ae62e6aaf48064ddc8732bfb8dcae10e8a077686a7803f6cb952120
TMPDIR=$(mktemp -d /tmp/io.github.mechatrax.raspbian.${DIST}.setup.XXXXXXX)
KEY=test-archive.gpg
KEYDIR=/usr/share/keyrings
pushd $TMPDIR
echo "$SHA256 $DEB" > sha256.txt
wget http://mechatrax-kiyonaga.github.io/pool/main/m/mechatrax-archive-keyring/$DEB
#sha256sum -c sha256.txt
wget https://mechatrax-kiyonaga.github.io/kiyonaga.gpg.key
gpg --no-default-keyring --keyring ./kiyonaga.gpg.key --import $KEY
cp ./$KEY $KEYDIR
dpkg -i $DEB
popd
rm -rf $TMPDIR

cat << EOF > /etc/apt/sources.list.d/mechatrax.list
deb [signed-by=$KEYDIR/$KEY] $REPO $DIST main contrib non-free
# Uncomment line below then 'apt-get update' to enable 'apt-get source'
#deb-src $REPO $DIST main contrib non-free
EOF

apt update
