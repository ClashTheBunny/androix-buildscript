#!/bin/bash

export NDK_ROOT=/opt/android-ndk-r7/
export NDK_TARGET=arm
export NDK_PLATFORM=9
export TARGET_HOST="arm-linux-androideabi"
export INSTALL_PREFIX="/home/rmason/androix/usr/"
export PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" 
export CC=droid-gcc
export LD=droid-ld

#NDK="/opt/android-ndk-r7"
#PLATFORM="14"
#GCCVERSION="4.4.3"
#ALIB="$NDK_ROOT/platforms/android-$PLATFORM/arch-arm"
#PREBUILT="$NDK_ROOT/toolchains/$TARGET-$GCCVERSION/prebuilt/linux-x86"
#TOOLCHAIN="$NDK_ROOT/toolchains/$TARGET-$GCCVERSION"
#LDSCRIPTS="$PREBUILT/$TARGET/lib/ldscripts/"

#ARMELF_LDSCRIPTS="$PREBUILT/$TARGET/lib/ldscripts/armelf_linux_eabi.x"
#INCLUDE_PATH="-I$NDK_ROOT/platforms/android-$PLATFORM/arch-arm/usr/include"

if [[ "x$(which droid-gcc || echo nope)" == "xnope" ]]; then
 git clone https://github.com/ClashTheBunny/droid-wrapper.git
 cd droid-wrapper
 sudo make install
 cd ..
fi

[[ -f ncurses-5.9.tar.gz ]] || wget http://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
[[ -d ncurses-5.9 ]] || tar xvzf ncurses-5.9.tar.gz
[[ -d ncurses ]] && rm -rf ncurses
mkdir ncurses
cd ncurses
../ncurses-5.9/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX --without-cxx-binding
sed -i -e "s/#define HAVE_LOCALE_H 1/#define HAVE_LOCALE_H 0/g" include/ncurses_cfg.h 
#sed -i -e "s/iostream.h/iostream/g" ../ncurses-5.9/c++/etip.h.in ./ncurses/c++/etip.h
make -k install || exit
cd ..
[[ -f util-macros-1.14.0.tar.bz2 ]] || wget http://www.x.org/releases/individual/util/util-macros-1.14.0.tar.bz2
tar xvjf util-macros-1.14.0.tar.bz2
mkdir util-macros
cd util-macros
../util-macros-1.14.0/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir xproto
cd xproto

../xproto-7.0.20/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir xtrans
cd xtrans
../xtrans-1.2.6/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f xcb-proto-1.6.tar.bz2 ]] || wget http://xcb.freedesktop.org/dist/xcb-proto-1.6.tar.bz2
tar xvjf xcb-proto-1.6.tar.bz2
mkdir xcb-proto
cd xcb-proto
../xcb-proto-1.6/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir pthread-stubs
cd pthread-stubs
../libpthread-stubs-0.3/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir xau
cd xau
../libXau-1.0.6/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir xcb
cd xcb
../libxcb-1.7/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir xextproto
cd xextproto
../xextproto-7.2.0/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir kbproto
cd kbproto
../kbproto-1.0.5/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir inputproto
cd inputproto
../inputproto-1.9.99.902/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
tar xvzf tmzt-androix-lib-libX11-390b7e5.tar.gz
mkdir libX11
cd libX11
../tmzt-androix-lib-libX11-390b7e5/autogen.sh --host arm-eabi --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir xkbfile
cd xkbfile
../libxkbfile-1.0.7/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir xkbcomp
cd xkbcomp
../xkbcomp-1.2.0/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir xtrans
cd xtrans
../xtrans-1.2.6/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
tar xvzf tmzt-androix-xkeyboard-config-3b039ae.tar.gz
mkdir xkeyboard-config
cd xkeyboard-config
../tmzt-androix-xkeyboard-config-3b039ae/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f libdrm-2.4.25.tar.bz2 ]] || wget http://dri.freedesktop.org/libdrm/libdrm-2.4.25.tar.bz2
tar xvjf libdrm-2.4.25.tar.bz2
mkdir libdrm
cd libdrm
../libdrm-2.4.25/configure --host $TARGET_HOST --prefix=/ndk/androix/us
make install || exit
cd ..
[[ -f fixesproto-5.0.tar.bz2 ]] || wget http://cgit.freedesktop.org/xorg/proto/fixesproto/snapshot/fixesproto-5.0.tar.bz2
tar xvjf fixesproto-5.0.tar.bz2
mkdir fixesproto
cd fixesproto
../fixesproto-5.0/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f damagepro-1.2.1.tar.bz2 ]] || wget http://cgit.freedesktop.org/xorg/proto/damageproto/snapshot/damagepro-1.2.1.tar.bz2
tar xvjf damageproto-1.2.1.tar.bz2
mkdir damageproto
cd damageproto
../damageproto-1.2.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f xcmiscpro-1.2.1.tar.bz2 ]] || wget http://cgit.freedesktop.org/xorg/proto/xcmiscproto/snapshot/xcmiscpro-1.2.1.tar.bz2
tar xvjf xcmiscproto-1.2.1.tar.bz2
mkdir xcmiscproto
cd xcmiscproto
../xcmiscproto-1.2.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f bigreqsproto-1.1.1.tar.bz2 ]] || wget http://cgit.freedesktop.org/xorg/proto/bigreqsproto/snapshot/bigreqsproto-1.1.1.tar.bz2
tar xvjf bigreqsproto-1.1.1.tar.bz2
mkdir bigreqsproto
cd bigreqsproto
../bigreqsproto-1.1.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f compositeproto-0.4.2.tar.bz2 ]] || wget http://cgit.freedesktop.org/xorg/proto/compositeproto/snapshot/compositeproto-0.4.2.tar.bz2
tar xvjf compositeproto-0.4.2.tar.bz2
mkdir compositeproto
cd compositeproto
../compositeproto-0.4.2/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f recordproto-1.14.1.tar.bz2 ]] || wget http://cgit.freedesktop.org/xorg/proto/recordproto/snapshot/recordproto-1.14.1.tar.bz2
tar xvjf recordproto-1.14.1.tar.bz2
mkdir recordproto
cd recordproto
../recordproto-1.14.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f scrnsaverprooto-1.2.1.tar.bz2 ]] || wget http://cgit.freedesktop.org/xorg/proto/scrnsaverproto/snapshot/scrnsaverprooto-1.2.1.tar.bz2
tar xvjf scrnsaverproto-1.2.1.tar.bz2
mkdir scrnsaverproto
cd scrnsaverproto
../scrnsaverproto-1.2.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f resourceproto-1.1.1.tar.bz2 ]] || wget http://cgit.freedesktop.org/xorg/proto/resourceproto/snapshot/resourceproto-1.1.1.tar.bz2
tar xvjf resourceproto-1.1.1.tar.bz2
mkdir resourceproto
cd resourceproto
../resourceproto-1.1.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f freetype-2.4.4.tar.bz2 ]] || wget http://download.savannah.gnu.org/releases/freetype/freetype-2.4.4.tar.bz2
tar xvjf freetype-2.4.4.tar.bz2
mkdir freetype
cd freetype
../freetype-2.4.4/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f libfontenc-1.1.0.tar.bz2 ]] || wget http://www.paldo.org/paldo/sources/fontenc/libfontenc-1.1.0.tar.bz2
tar xvjf libfontenc-1.1.0.tar.bz2
mkdir fontenc
cd fontenc
../libfontenc-1.1.0/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f libXfont-1.4.3.tar.bz2 ]] || wget http://www.x.org/releases/X11R7.6/src/lib/libXfont-1.4.3.tar.bz2
tar xvjf libXfont-1.4.3.tar.bz2
mkdir xfont
cd xfont
../libXfont-1.4.3/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
tar xvzf tmzt-androix-lib-libXfont-7ea57af.tar.gz
mkdir xfont
cd xfont
../libXfont-1.4.3/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f libXdmcp-1.1.0.tar.bz2 ]] || wget http://www.x.org/releases/X11R7.6/src/lib/libXdmcp-1.1.0.tar.bz2
tar xvjf libXdmcp-1.1.0.tar.bz2
mkdir libxdmcp
cd libxdmcp
../libXdmcp-1.1.0/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
[[ -f pixman-0.22.0.tar.bz2 ]] || wget http://cgit.freedesktop.org/pixman/snapshot/pixman-0.22.0.tar.bz2
tar xvjf pixman-0.22.0.tar.bz2
mkdir pixman
cd pixman
../pixman-0.22.0/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install || exit
cd ..
mkdir androix
cd androix
../androix-xserver/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX --prefix=$INSTALL_PREFIX -disable-xorg --disable-glx --disable-xvfb --disable-xinerama --disable-xnest --disable-mitshm --enable-android --with-xkb-path="/data/net.homeip.ofn.androix/usr/share/X11/xkb" --with-xkb-output="/data/net.homeip.ofn.androix/usr/share/X11/xkb/compiled" --with-default-font-path="/data/net.homeip.ofn.androix/usr/share/fonts/X11" --with-xkb-bin-directory="/data/net.homeip.ofn.androix/usr/bin" --disable-config-udev
make
cd ..
cd tmzt-androix-xserver-051a638/hw/android
$NDK_ROOT/ndk-build
