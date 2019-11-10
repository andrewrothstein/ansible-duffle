#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/cnabio/duffle/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local suffix=${4:-}
    local platform="$os-$arch"
    local url=$MIRROR/$ver/duffle-$platform$suffix
    local lfile=$DIR/duffle-$ver-$platform$suffix

    if [ ! -e $lfile ];
    then
        wget -q -O $lfile $url
    fi

    printf "      # %s\n" $url
    printf "      %s: sha256:%s\n" $platform `sha256sum $lfile | awk '{print $1}'`
}

dlver () {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver darwin amd64
    dl $ver linux amd64
    dl $ver windows amd64 .exe
}

dlver ${1:-0.3.5-beta.1}
