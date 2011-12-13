#!/bin/bash

NDK="/opt/android-ndk-r7"
PLATFORM="14"
GCCVERSION="4.4.3"
TARGET_HOST="arm-linux-androideabi"
ALIB="$NDK/platforms/android-$PLATFORM/arch-arm"
PREBUILT="$NDK/toolchains/$TARGET-$GCCVERSION/prebuilt/linux-x86"
TOOLCHAIN="$NDK/toolchains/$TARGET-$GCCVERSION"
LDSCRIPTS="$PREBUILT/$TARGET/lib/ldscripts/"

ARMELF_LDSCRIPTS="$PREBUILT/$TARGET/lib/ldscripts/armelf_linux_eabi.x"
INCLUDE_PATH="-I$NDK/platforms/android-$PLATFORM/arch-arm/usr/include"

INSTALL_PREFIX="/home/rmason/androix/usr/"

[[ -f ncurses-5.9.tar.gz ]] || wget http://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz
[[ -d ncurses-5.9 ]] && rm -rf ncurses-5.9
tar xvzf ncurses-5.9.tar.gz
cd ncurses-5.9
CC=agcc.pl ../ncurses-5.9/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make -k install
cd ..
wget http://www.x.org/releases/individual/util/util-macros-1.14.0.tar.bz2
tar xvjf util-macros-1.14.0.tar.bz2
mkdir util_macros
cd util_macros
../util-macros-1.14.0/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir xproto
cd xproto

CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../xproto-7.0.20/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir xtrans
cd xtrans
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../xtrans-1.2.6/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://xcb.freedesktop.org/dist/xcb-proto-1.6.tar.bz2
tar xvjf xcb-proto-1.6.tar.bz2
mkdir xcb-proto
cd xcb-proto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../xcb-proto-1.6/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir pthread-stubs
cd pthread-stubs
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../libpthread-stubs-0.3/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir xau
cd xau
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../libXau-1.0.6/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir xcb
cd xcb
CC=agcc.pl CFLAGS="-I$INSTALL_PREFIX/include" LDFLAGS="-L/ndk/sysroot/usr/lib/ -L/ndk/sysroot/usr/lib/static -L$INSTALL_PREFIX/lib" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig:$INSTALL_PREFIX/share/pkgconfig" ../libxcb-1.7/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir xextproto
cd xextproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../xextproto-7.2.0/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir kbproto
cd kbproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../kbproto-1.0.5/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir inputproto
cd inputproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../inputproto-1.9.99.902/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
tar xvzf tmzt-androix-lib-libX11-390b7e5.tar.gz
mkdir libX11
cd libX11
CC=agcc.pl CFLAGS="-g -I$INSTALL_PREFIX/include -DISC -DUSE_XMBTOWC -DX_LOCALE -DWORD64" LDFLAGS="-L/ndk/sysroot/usr/lib/ -L/ndk/sysroot/usr/lib/static -L$INSTALL_PREFIX/lib" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig:/ndk/androix/usr/share/pkgconfig" ../tmzt-androix-lib-libX11-390b7e5/autogen.sh --host arm-eabi --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir xkbfile
cd xkbfile
CC=agcc.pl CFLAGS="-I$INSTALL_PREFIX/include -fno-short-enums" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig:$INSTALL_PREFIX/share/pkgconfig" ../libxkbfile-1.0.7/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir xkbcomp
cd xkbcomp
CC=agcc.pl CFLAGS="-I$INSTALL_PREFIX/include -fno-short-enums" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig:$INSTALL_PREFIX/share/pkgconfig" ../xkbcomp-1.2.0/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../xtrans-1.2.6/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
tar xvzf tmzt-androix-xkeyboard-config-3b039ae.tar.gz
mkdir xkeyboard-config
cd xkeyboard-config
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../tmzt-androix-xkeyboard-config-3b039ae/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://dri.freedesktop.org/libdrm/libdrm-2.4.25.tar.bz2
tar xvjf libdrm-2.4.25.tar.bz2
mkdir libdrm
cd libdrm
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../libdrm-2.4.25/configure --host $TARGET_HOST --prefix=/ndk/androix/us
make install
cd ..
wget http://cgit.freedesktop.org/xorg/proto/fixesproto/snapshot/fixesproto-5.0.tar.bz2
tar xvjf fixesproto-5.0.tar.bz2
mkdir fixesproto
cd fixesproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../fixesproto-5.0/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://cgit.freedesktop.org/xorg/proto/damageproto/snapshot/damagepro-1.2.1.tar.bz2
tar xvjf damageproto-1.2.1.tar.bz2
mkdir damageproto
cd damageproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../damageproto-1.2.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://cgit.freedesktop.org/xorg/proto/xcmiscproto/snapshot/xcmiscpro-1.2.1.tar.bz2
tar xvjf xcmiscproto-1.2.1.tar.bz2
mkdir xcmiscproto
cd xcmiscproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../xcmiscproto-1.2.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://cgit.freedesktop.org/xorg/proto/bigreqsproto/snapshot/bigreqsproto-1.1.1.tar.bz2
tar xvjf bigreqsproto-1.1.1.tar.bz2
mkdir bigreqsproto
cd bigreqsproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../bigreqsproto-1.1.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://cgit.freedesktop.org/xorg/proto/compositeproto/snapshot/compositeproto-0.4.2.tar.bz2
tar xvjf compositeproto-0.4.2.tar.bz2
mkdir compositeproto
cd compositeproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../compositeproto-0.4.2/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://cgit.freedesktop.org/xorg/proto/recordproto/snapshot/recordproto-1.14.1.tar.bz2
tar xvjf recordproto-1.14.1.tar.bz2
mkdir recordproto
cd recordproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../recordproto-1.14.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://cgit.freedesktop.org/xorg/proto/scrnsaverproto/snapshot/scrnsaverprooto-1.2.1.tar.bz2
tar xvjf scrnsaverproto-1.2.1.tar.bz2
mkdir scrnsaverproto
cd scrnsaverproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../scrnsaverproto-1.2.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://cgit.freedesktop.org/xorg/proto/resourceproto/snapshot/resourceproto-1.1.1.tar.bz2
tar xvjf resourceproto-1.1.1.tar.bz2
mkdir resourceproto
cd resourceproto
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../resourceproto-1.1.1/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.4.4.tar.bz2
tar xvjf freetype-2.4.4.tar.bz2
mkdir freetype
cd freetype
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../freetype-2.4.4/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://www.paldo.org/paldo/sources/fontenc/libfontenc-1.1.0.tar.bz2
tar xvjf libfontenc-1.1.0.tar.bz2
mkdir fontenc
cd fontenc
CC="$ARM_GCC" CFLAGS="-W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../libfontenc-1.1.0/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://www.x.org/releases/X11R7.6/src/lib/libXfont-1.4.3.tar.bz2
tar xvjf libXfont-1.4.3.tar.bz2
mkdir xfont
cd xfont
CC="$ARM_GCC" CFLAGS="-DNO_LOCALE -W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC-DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG"LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../libXfont-1.4.3/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
tar xvzf tmzt-androix-lib-libXfont-7ea57af.tar.gz
mkdir xfont
cd xfont
CC="$ARM_GCC" CFLAGS="-DNO_LOCALE -W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC-DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../libXfont-1.4.3/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://www.x.org/releases/X11R7.6/src/lib/libXdmcp-1.1.0.tar.bz2
tar xvjf libXdmcp-1.1.0.tar.bz2
mkdir libxdmcp
cd libxdmcp
CC="$ARM_GCC" CFLAGS="-DNO_LOCALE -W -Wall -O0 -g3   -Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-override-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC-DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../libXdmcp-1.1.0/configure --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
wget http://cgit.freedesktop.org/pixman/snapshot/pixman-0.22.0.tar.bz2
tar xvjf pixman-0.22.0.tar.bz2
mkdir pixman
cd pixman
CC="$ARM_GCC" CFLAGS="-DPIXMAN_NO_TLS -W -Wall -O0 -g3-Wstrict-prototypes -pipe -std=gnu99 -ffunction-sections -fno-short-enums -march=armv5te -mtune=xscale -msoft-float -fomit-frame-pointer  -Wno-pointer-sign -Wno-oe-init -I/ndk/androix/include -I$INSTALL_PREFIX/include -nostdlib -fPIC -DANDROID -I$INSTALL_PREFIX/include -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-Wl,-T,$ARMELF_LDSCRIPTS -Wl,-rpath-link=$INSTALL_PREFIX/lib -L$INSTALL_PREFIX/lib -nostdlib -lc -lm -ldl -nostdlib -Wl,-dynamic-linker,/system/bin/linker -Wl,-z-nocopyreloc" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig" ../pixman-0.22.0/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX
make install
cd ..
mkdir androix
cd androix
CC="agcc.pl" CFLAGS="-I/ndk/androix/include -I$INSTALL_PREFIX/include -DANDROID -Dbionic -Dlinux -D__arm__ -DDEBUG" LDFLAGS="-L$INSTALL_PREFIX/lib" PKG_CONFIG_PATH="$INSTALL_PREFIX/lib/pkgconfig:$INSTALL_PREFIX/share/pkgconfig" ../androix-xserver/autogen.sh --host $TARGET_HOST --prefix=$INSTALL_PREFIX --prefix=$INSTALL_PREFIX -disable-xorg --disable-glx --disable-xvfb --disable-xinerama --disable-xnest --disable-mitshm --enable-android --with-xkb-path="/data/data/net.homeip.ofn.androix/usr/share/X11/xkb" --with-xkb-output="/data/data/net.homeip.ofn.androix/usr/share/X11/xkb/compiled" --with-default-font-path="/data/data/net.homeip.ofn.androix/usr/share/fonts/X11" --with-xkb-bin-directory="/data/data/net.homeip.ofn.androix/usr/bin" --disable-config-udev
make
cd ..
cd tmzt-androix-xserver-051a638/hw/android
/home/webbb/NDK/android-ndk-r5b/ndk-build
