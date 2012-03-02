#!/bin/bash

export ANDORIX_GIT="git@github.com:ClashTheBunny/androix-xserver.git"
#export ANDROIX_BRANCH="androix-merge_upstream_010611"
export ANDROIX_BRANCH="androix-0.8-bw"

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
export CFLAGS="-I$INSTALL_PREFIX/include -I$INSTALL_PREFIX/include/arm-linux-gnueabi"
export LDFLAGS="-L$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib/arm-linux-gnueabi/ -L$MY_CHROOT/lib"
export PKG_CONFIG_PATH=$INSTALL_PREFIX/lib/pkgconfig:$INSTALL_PREFIX/share/pkgconfig:$INSTALL_PREFIX/lib/arm-linux-gnueabi/pkgconfig
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

if [[ ! -e "$(ls -t | grep root | grep -i tgz | head -1)" ]]
then
    sudo rootstock --fqdn ubuntu --login ubuntu --password ubuntu \
        --imagesize 3G --seed build-essential,openssh-server \
        --script runInsideChroot.sh

    mkdir -p $MY_CHROOT
    sudo tar -C $MY_CHROOT -zxf $(ls -t | grep root | grep -i tgz | head -1)

    sudo chown $(id -un):$(id -gn) $MY_CHROOT
fi

#    #sudo cp $(which qemu-arm-static) $MY_CHROOT/usr/bin/
#    
#    #sudo mount -t proc proc $MY_CHROOT/proc
#    
#    #sudo cp /etc/resolv.conf $MY_CHROOT/etc/resolv.conf
#    
#    #sudo chroot $MY_CHROOT /bin/bash


[[ ! -d "$MY_CHROOT/xserver" ]] && git clone $ANDROIX_GIT "$MY_CHROOT/xserver"

cd "$MY_CHROOT/xserver"

[[ "$(git remote -v | grep "fetch" | sed -e 's/origin\t\(.*\) (fetch)/\1/g')" == "$ANDROIX_GIT" ]] || ( cd ..; rm -rf xserver; git clone $ANDROIX_GIT xserver; cd xserver )

[[ "$(git name-rev HEAD 2> /dev/null | sed 's#HEAD\ ##')" == "$ANDROIX_BRANCH" ]] || git checkout -b "$ANDROIX_BRANCH" "remotes/origin/$ANDROIX_BRANCH"

./autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX --disable-dmx --disable-xorg --disable-glx --disable-xvfb --disable-xinerama --disable-xnest --disable-mitshm --enable-android --with-xkb-path="/data/data/net.homeip.ofn.androix/usr/share/X11/xkb" --with-xkb-output="/data/data/net.homeip.ofn.androix/usr/share/X11/xkb/compiled" --with-default-font-path="/data/data/net.homeip.ofn.androix/usr/share/fonts/X11" --with-xkb-bin-directory="/data/data/net.homeip.ofn.androix/usr/bin" --disable-config-udev
make
cd hw/android
$NDK_ROOT/ndk-build
