#!/bin/bash


export DROID_WRAPPER_DEBUG=true
export NDK_ROOT=$(dirname $(which ndk-build))
export NDK_TARGET=arm
export NDK_PLATFORM=8
export TARGET_HOST="arm-linux-androideabi"
export INSTALL_PREFIX="$HOME/androix/usr"
export MY_CHROOT=${INSTALL_PREFIX/\/usr/}
export CC=droid-gcc
export LD=droid-ld
export RANLIB=droid-ranlib
export CFLAGS="-I$INSTALL_PREFIX/include"
export LDFLAGS="-L$INSTALL_PREFIX/lib"
export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig:$INSTALL_PREFIX/share/pkgconfig
#export ACLOCAL="aclocal -I $INSTALL_PREFIX/share/aclocal"
export LD_LIBRARY_PATH=$INSTALL_PREFIX/lib

BUILD_ROOT=$(pwd)
BUILD_LOG=$BUILD_ROOT/build.log_$(date "+%Y-%m-%d-%H-%M")

if [[ "x$(which droid-gcc || echo nope)" == "xnope" ]]; then
     git clone https://github.com/ClashTheBunny/droid-wrapper.git
     cd droid-wrapper
     sudo make install
     cd ..
fi

#sudo rootstock --fqdn ubuntu --login ubuntu --password ubuntu --imagesize 3G --seed build-essential,openssh-server # --script compileAndroix.sh

mkdir -p $MY_CHROOT
sudo tar -C $MY_CHROOT -zxf $(ls -t | grep root | grep -i tgz | head -1)
sudo cp $(which qemu-arm-static) $MY_CHROOT/usr/bin/

sudo mount -t proc proc $MY_CHROOT/proc

sudo cp /etc/resolv.conf $MY_CHROOT/etc/resolv.conf

sudo chroot $MY_CHROOT /bin/bash
