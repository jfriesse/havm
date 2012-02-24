# Install havm

# Copyright (c) 2012, Jan Friesse <jfriesse@gmail.com>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

usage() {
    echo "$0 install|uninstall [--init]"

    exit 1
}

PREFIX=${PREFIX:-/usr/local}
BINDIR=${BINDIR:-$PREFIX/bin}

case "$1" in
"install")
    set -x

    mkdir -p "$DESTDIR/$BINDIR"
    install havm havm-ifup "$DESTDIR/$BINDIR"

    if [ "$2" == "--init" ];then
	install init/havm "$DESTDIR/etc/init.d"
        install init/sysconfig/havm "$DESTDIR/etc/sysconfig"
        chkconfig --add havm
        chkconfig havm on
    fi
    ;;
"uninstall")
    set -x
    rm -f $DESTDIR/$BINDIR/havm $DESTDIR/$BINDIR/havm-ifup
    if [ "$2" == "--init" ];then
        chkconfig havm off
        chkconfig --del havm
	rm -f $DESTDIR/etc/init.d/havm $DESTDIR/etc/sysconfig/havm
    fi
    ;;
*)
    usage
    ;;
esac
