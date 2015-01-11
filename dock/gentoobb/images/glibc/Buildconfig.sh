#
# build config
#
PACKAGES="sys-libs/glibc"
TIMEZONE="${BOB_TIMEZONE:-UTC}"
GLIBC_LOCALES=("en_US ISO-8859-1" "en_US.UTF-8 UTF-8")

#
# this method runs in the bb builder container just before starting the build of the rootfs
#
configure_rootfs_build()
{
    # fake portage install
    emerge -p sys-apps/portage | grep sys-apps/portage | grep -Eow "\[.*\] (.*) to" | awk '{print $(NF-1)}' >> /etc/portage/profile/package.provided
    # set locales
    mkdir -p $EMERGE_ROOT/etc
    for LOCALE in "${GLIBC_LOCALES[@]}"; do
        echo "$LOCALE" >> /etc/locale.gen
    done
    cp /etc/locale.gen $EMERGE_ROOT/etc/
    # set timezone
    echo $TIMEZONE > /etc/timezone
    cp /etc/timezone $EMERGE_ROOT/etc/
    cp /usr/share/zoneinfo/$TIMEZONE $EMERGE_ROOT/etc/localtime
}

#
# this method runs in the bb builder container just before tar'ing the rootfs
#
finish_rootfs_build()
{
    # purge glibc locales/charmaps
    for LOCALE in "${GLIBC_LOCALES[@]}"; do
        locale=($LOCALE)
        locales_filter+=('!' '-name' "${locale[0]}")
        charmaps_filter+=('!' '-name' "${locale[1]}.gz")
    done
    find $EMERGE_ROOT/usr/share/i18n/locales -type f "${locales_filter[@]}" -exec rm -f {} \;
    find $EMERGE_ROOT/usr/share/i18n/charmaps -type f "${charmaps_filter[@]}" -exec rm -f {} \;
    # backup iconv encodings so other images can pull them in again via ICONV_FROM=glibc
    tar -cpf $ROOTFS_BACKUP/glibc-ICONV.tar $EMERGE_ROOT/usr/lib64/gconv/
    # purge iconv
    rm -f $EMERGE_ROOT/usr/lib64/gconv/*
    # add entry to purged section in PACKAGES.md
    write_checkbox_line "Glibc Iconv Encodings" "checked" "${DOC_FOOTER_PURGED}"
}