# Install havm

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
