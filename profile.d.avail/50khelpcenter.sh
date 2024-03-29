#! /bin/false
#
# Use khelpcenter to show man/info help pages if khelpcenter is installed and
# when it is safe/possible to do so (e. g. only in an X11 session).
#
# Version 2022.43

case $- in
	*i*) ;;
	*) return
esac

gman() {
	{
		command -v khelpcenter \
		&& test "`id -u`" != 0 \
 		&& xset q \
 		&& dbus-send --dest=org.freedesktop.DBus \
			--print-reply / org.freedesktop.DBus.ListNames \
 		&& case $* in
			*-*) false
		esac && (khelpcenter "man:`man -w "$@"`" &)
	}  < /dev/null > /dev/null 2>& 1 \
	|| command man "$@"
}

ginfo() {
	{
		command -v khelpcenter \
		&& test "`id -u`" != 0 \
 		&& xset q \
 		&& dbus-send --dest=org.freedesktop.DBus \
			--print-reply / org.freedesktop.DBus.ListNames \
 		&& case $* in
			*-*) false
		esac && (khelpcenter "info:/$*" &)
	}  < /dev/null > /dev/null 2>& 1 \
	|| command info "$@"
}
