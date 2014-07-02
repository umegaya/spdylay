#!/bin/bash

# thank you for following tips
# http://qiita.com/Jxck_/items/d329aa5c9b50519dcfaf
# https://github.com/toocheap/TechMemos/blob/master/spdylay_memo.md

if [ -e /usr/lib/pkgconfig/zlib.pc ]; then
echo "already has zlib pkgconfig"
else
echo "create new zlib pkgconfig"
sudo ln -s /usr/local/Cellar/zlib/1.2.8/lib/pkgconfig/zlib.pc /usr/lib/pkgconfig
fi

CHECK_VERSION=`grep -E "[1-9]+\.[0-9]+\.[1-9]+" /usr/lib/pkgconfig/openssl.pc`
if [ -z "$CHECK_VERSION" ]; then
echo "create new openssl pkgconfig [$CHECK_VERSION]"
sudo mv /usr/lib/pkgconfig/openssl.pc /usr/lib/pkgconfig/openssl.pc.bk
sudo ln -s /usr/local/Cellar/openssl/1.0.1g/lib/pkgconfig/openssl.pc /usr/lib/pkgconfig
else
echo "already has openssl pkgconfig"
fi

pushd m4
wget http://keithr.org/eric/src/whoisserver-nightly/m4/am_path_xml2.m4
popd

autoreconf -i
automake
autoconf
./configure
make
make install
