### kubler/python2:20171030

Built: Mon Oct 30 15:39:34 CET 2017
Image Size: 108MB

#### Installed
Package | USE Flags
--------|----------
app-arch/bzip2-1.0.6-r8 | `-static -static-libs`
app-eselect/eselect-python-20160516 | ``
app-misc/mime-types-9 | ``
dev-db/sqlite-3.19.3 | `readline -debug -doc -icu -secure-delete -static-libs -tcl {-test} -tools`
dev-lang/python-2.7.12 | `hardened readline sqlite ssl (threads) (wide-unicode) xml (-berkdb) -build -doc -examples -gdbm -ipv6 (-libressl) -ncurses -tk -wininst`
dev-lang/python-exec-2.4.4 | ` `
dev-libs/expat-2.2.1 | `unicode -examples -static-libs`
dev-libs/libffi-3.2.1 | `-debug -pax`
dev-python/appdirs-1.4.3 | ` `
dev-python/certifi-2017.4.17 | ` `
dev-python/packaging-16.8 | `{-test}`
dev-python/pip-9.0.1-r1 | ` `
dev-python/pyparsing-2.2.0 | `-doc -examples`
dev-python/setuptools-34.0.2-r1 | `{-test}`
dev-python/six-1.10.0 | `-doc {-test}`
#### Inherited
Package | USE Flags
--------|----------
**FROM kubler/bash** |
app-admin/eselect-1.4.8 | `-doc -emacs -vim-syntax`
app-portage/portage-utils-0.64 | `nls -static`
app-shells/bash-4.3_p48-r1 | `net nls (readline) -afs -bashlogger -examples -mem-scramble -plugins`
dev-libs/iniparser-3.1-r1 | `-doc -examples -static-libs`
net-misc/curl-7.56.1 | `ssl threads -adns -http2 -idn -ipv6 -kerberos -ldap -metalink -rtmp -samba -ssh -static-libs {-test}`
sys-apps/acl-2.2.52-r1 | `nls -static-libs`
sys-apps/attr-2.4.47-r2 | `nls -static-libs`
sys-apps/coreutils-8.26 | `acl nls (xattr) -caps -gmp -hostname -kill -multicall (-selinux) -static -vanilla`
sys-apps/file-5.32 | `zlib -python -static-libs`
sys-apps/sed-4.2.2 | `acl nls (-selinux) -static`
sys-libs/ncurses-6.0-r1 | `cxx minimal threads unicode -ada -debug -doc -gpm (-profile) -static-libs {-test} -tinfo -trace`
sys-libs/readline-6.3_p8-r3 | `-static-libs -utils`
**FROM kubler/openssl** |
app-misc/ca-certificates-20161130.3.30.2 | `-cacert -insecure`
app-misc/c_rehash-1.7-r1 | ``
dev-libs/openssl-1.0.2l | `asm sslv3 tls-heartbeat zlib -bindist -gmp -kerberos -rfc3779 -sctp -sslv2 -static-libs {-test} -vanilla`
sys-apps/debianutils-4.7 | `-static`
sys-libs/zlib-1.2.11-r1 | `-minizip -static-libs`
**FROM kubler/s6** |
dev-lang/execline-2.3.0.2 | `-static -static-libs`
dev-libs/skalibs-2.6.0.0 | `-doc -ipv6 -static-libs`
sys-apps/s6-2.6.1.0 | `-static -static-libs`
*manual install*: entr-3.9 | http://entrproject.org/
**FROM kubler/glibc** |
sys-apps/gentoo-functions-0.12 | ``
sys-libs/glibc-2.25-r8 | `hardened rpc -audit -caps -debug -gd (-multilib) -nscd (-profile) (-selinux) -suid -systemtap (-vanilla)`
sys-libs/timezone-data-2017a | `nls -leaps`
**FROM kubler/busybox** |
sys-apps/busybox-1.25.1 | `make-symlinks static -debug -ipv6 -livecd -math -mdev -pam -savedconfig (-selinux) -sep-usr -syslog -systemd`
#### Purged
- [x] Headers
- [x] Static Libs
