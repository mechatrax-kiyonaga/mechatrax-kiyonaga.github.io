#!/usr/bin/env bash

set -eu

REPO=http://mechatrax-kiyonaga.github.io/mechatrax.github.io/raspbian/
DIST=bullseye
DEB=mechatrax-archive-keyring_2016.12.19.3_all.deb
SHA256=d7aa68b15ae62e6aaf48064ddc8732bfb8dcae10e8a077686a7803f6cb952120
TMPDIR=$(mktemp -d /tmp/io.github.mechatrax.raspbian.${DIST}.setup.XXXXXXX)

pushd $TMPDIR
echo "$SHA256 $DEB" > sha256.txt
wget http://mechatrax-kiyonaga.github.io/mechatrax.github.io/raspbian/pool/main/m/mechatrax-archive-keyring/$DEB
sha256sum -c sha256.txt
dpkg -i $DEB
popd
rm -rf $TMPDIR

cat << EOF > /etc/apt/sources.list.d/mechatrax.list
deb $REPO $DIST main contrib non-free soracom
# Uncomment line below then 'apt-get update' to enable 'apt-get source'
#deb-src $REPO $DIST main contrib non-free
EOF

apt update
