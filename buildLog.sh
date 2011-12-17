#!/bin/bash
export NDK_ROOT=$(dirname $(which ndk-build))
export NDK_TARGET=arm
export NDK_PLATFORM=9
export TARGET_HOST="arm-linux-androideabi"
export INSTALL_PREFIX="$HOME/androix/usr"
export CC=droid-gcc
export LD=droid-ld
export RANLIB=droid-ranlib
export CFLAGS="-I$INSTALL_PREFIX/include"
export LDFLAGS="-L$INSTALL_PREFIX/lib"
export PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" 

if [[ "x$(which droid-gcc || echo nope)" == "xnope" ]]; then
 git clone https://github.com/ClashTheBunny/droid-wrapper.git
 cd droid-wrapper
 sudo make install
 cd ..
fi

BUILD_ROOT=$(pwd)

ls $INSTALL_PREFIX/lib/libncurses.a 2>/dev/null 1>/dev/null || (
 [[ -f ncurses-5.9.tar.gz ]] || wget http://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
 [[ -d ncurses-5.9 ]] || tar xvzf ncurses-5.9.tar.gz
 [[ -d ncurses ]] && rm -rf ncurses
 mkdir ncurses
 cd ncurses
 ../ncurses-5.9/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX --without-cxx-binding
 sed -i -e "s/#define HAVE_LOCALE_H 1/#define HAVE_LOCALE_H 0/g" include/ncurses_cfg.h 
 make -k install || exit
 cd $BUILD_ROOT
)

repo init -u https://github.com/ClashTheBunny/androix.git
repo sync

cat .repo/manifest.xml | grep -v "androix-xserver" | grep path | grep -v "\!--"  | sed -e 's/.*path="//g' -e 's/" remote.*//g' | uniq | while read dir
do
	cd $dir
	./autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
	make install || exit
	cd $BUILD_ROOT
done

cd xserver
./autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX -disable-xorg --disable-glx --disable-xvfb --disable-xinerama --disable-xnest --disable-mitshm --enable-android --with-xkb-path="/data/data/net.homeip.ofn.androix/usr/share/X11/xkb" --with-xkb-output="/data/data/net.homeip.ofn.androix/usr/share/X11/xkb/compiled" --with-default-font-path="/data/data/net.homeip.ofn.androix/usr/share/fonts/X11" --with-xkb-bin-directory="/data/data/net.homeip.ofn.androix/usr/bin" --disable-config-udev
make
cd hw/android
$NDK_ROOT/ndk-build
