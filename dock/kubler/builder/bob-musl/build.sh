#
# Kubler phase 1 config, pick installed packages and/or customize the build
#

#
# This hook can be used to configure the build container itself, install packages, run any command, etc
#
configure_bob() {
    fix_portage_profile_symlink
    # install basics used by helper functions
    emerge app-portage/flaggie app-portage/eix app-portage/gentoolkit
    configure_eix
    # migrate from files to directories at /etc/portage/package.*
    for i in /etc/portage/package.{accept_keywords,unmask,mask,use}; do
        [[ -f "${i}" ]] && { cat "${i}"; mv "${i}" "${i}".old; }
        mkdir -p "${i}"
        [[ -f "${i}".old ]] &&  mv "${i}".old "${i}"/default
    done
    touch /etc/portage/package.accept_keywords/flaggie
    echo 'LANG="en_US.UTF-8"' > /etc/env.d/02locale
    env-update
    source /etc/profile
    # install default packages
    # when using overlay1 docker storage the created hard link will trigger an error during openssh uninstall
    [[ -f /usr/"${_LIB}"/misc/ssh-keysign ]] && rm /usr/"${_LIB}"/misc/ssh-keysign
    emerge -C net-misc/openssh
    update_use 'dev-libs/openssl' -bindist
    update_use 'dev-vcs/git' '-perl'
    update_use 'app-crypt/pinentry' '+ncurses'
    update_keywords 'app-portage/layman' '+~amd64'
    update_keywords 'dev-python/ssl-fetch' '+~amd64'
    emerge dev-vcs/git app-portage/layman sys-devel/distcc app-misc/jq
    install_git_postsync_hooks
    configure_layman
    add_layman_overlay musl
    # install go
    cd ~
    wget https://raw.githubusercontent.com/docker-library/golang/master/1.9/alpine3.6/no-pic.patch
    wget https://raw.githubusercontent.com/docker-library/golang/master/1.9/alpine3.6/make-sure-R0-is-zero-before-main-on-ppc64le.patch
    wget https://storage.googleapis.com/golang/go1.4-bootstrap-20161024.tar.gz
    tar xzvf go1.4-bootstrap-20161024.tar.gz
    mv go go1.4
    cd go1.4/src/
    env CGO_ENABLED=0 ./make.bash
    export GOPATH=/go
    cd /usr/lib
    git clone https://go.googlesource.com/go
    cd go/src
    git checkout go1.9.1
    patch -p2 -i ~/no-pic.patch
    patch -p2 -i ~/make-sure-R0-is-zero-before-main-on-ppc64le.patch
    # some tests seem to be hardlinked against glibc and fail
    set +e
    ./all.bash
    set -e
    cd ../
    ln -sr bin/go /usr/bin/
    ln -sr bin/gofmt /usr/bin/
    # required by acserver build
    go install cmd/fix
    go install cmd/cover
    go install cmd/vet
    # taken from alpine build
    mkdir -p /go/src/golang.org/x/
    cd /go/src/golang.org/x/
    git clone https://go.googlesource.com/tools
    for tool in "cover" "godoc" "stringer"; do
        go install \
        golang.org/x/tools/cmd/$tool || return 1
    done
    # install aci/oci requirements
    install_oci_deps
}
