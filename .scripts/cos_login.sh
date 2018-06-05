#! /usr/bin/env bash

if [[ $0 != "$BASH_SOURCE" ]] ; then
    sourced=true
else
    sourced=false
fi

maybe_exit() {
    if [ "$sourced" = false ] ; then
        exit $1
    fi
}

cos_user_default="$USER"
cos_base_url_default="https://dev1.dev.clover.com"

usage() {
    echo "This script will log your user into COS and print the cookie on the last output line"
    echo
    echo "    $ $(basename $0) -u <cos_user> -s <cos_base_url>"
    echo
    echo " Default Values"
    echo "     cos_user: $cos_user_default"
    echo "     cos_base_url: $cos_base_url_default"
    echo
    echo " If sourced, it will put the cookie in \$COOKIE" too
    echo
    echo "    $ source $(basename $0)"
    maybe_exit 1
}

# if script was sourced, read params from variables
if [[ "$sourced" = true ]] ; then
    if [ -z ${cos_base_url+x} ]; then
        echo "cos_base_url is unset"
        echo -n "cos_base_url: "
        read cos_base_url
        cos_base_url=${cos_base_url:-$cos_base_url_default}
    else
        echo "cos_base_url: $cos_base_url"
    fi

    if [ -z ${cos_user+x} ]; then
        echo "cos_user is unset"
        echo -n  "cos_user: "
        read cos_user
        cos_user=${cos_user:-$cos_user_default}
    else
        echo "cos_user: $cos_user"
    fi

# otherwise examine parameters
else
    cos_user="$cos_user_default"
    cos_base_url="$cos_base_url_default"
    while getopts "u:s:h" opt; do
        case ${opt} in
            u )
                cos_user="$OPTARG"
                ;;
            s )
                cos_base_url="$OPTARG"
                ;;
            h)
                usage
                ;;
            : )
                echo "$OPTARG requires an argument" 1>&2
                maybe_exit 1
                ;;
            esac
        done
        shift $((OPTIND -1))

    echo "Server: $cos_base_url"
    echo "User: $cos_user"
    fi

    if [ -z ${cos_pass+x} ]; then
        echo -n "Password: "; read -s cos_pass;
    fi

    resp=$(curl -i -s -S "$cos_base_url"/cos/v1/dashboard/internal/login -X POST \
        -H "Content-Type: application/json" \
        -H 'Accept: application/json, text/javascript, */*; q=0.01' \
        -H 'Connection: keep-alive' -d '{"username":"'$cos_user'","password":"'$cos_pass'"}')
    COOKIE="$(echo "$resp" | grep set-cookie | awk '{$1=""; print $0}')" ;\

    if echo "$resp" | grep OK ; then
        echo "Got a cookie!"
        echo " \$COOKIE="
        echo "$COOKIE"
    else
        echo "Something went wrong, got:"
        echo "$resp" | sed 's/^/    /'
        maybe_exit 5
    fi
