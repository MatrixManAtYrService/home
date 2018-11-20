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

billing_user_default="$USER"
billing_base_url_default="http://localhost:8950"

usage() {
    echo "This script will log your user into COS and print the cookie on the last output line"
    echo
    echo "    $ $(basename $0) -u <billing_user> -s <billing_base_url>"
    echo
    echo " Default Values"
    echo "     billing_user: $billing_user_default"
    echo "     billing_base_url: $billing_base_url_default"
    echo
    echo " If sourced, it will put the cookie in \$COOKIE" too
    echo
    echo "    $ source $(basename $0)"
    maybe_exit 1
}

# if script was sourced, read params from variables
if [[ "$sourced" = true ]] ; then
    if [ -z ${billing_base_url+x} ]; then
        echo "billing_base_url is unset"
        echo "example value: " $billing_base_url_default
        echo -n "billing_base_url: "
        read billing_base_url
        billing_base_url=${billing_base_url:-$billing_base_url_default}
    else
        echo "billing_base_url: $billing_base_url"
    fi

    if [ -z ${billing_user+x} ]; then
        echo "billing_user is unset"
        echo -n  "billing_user: "
        read billing_user
        billing_user=${billing_user:-$billing_user_default}
    else
        echo "billing_user: $billing_user"
    fi

# otherwise examine parameters
else
    billing_user="$billing_user_default"
    billing_base_url="$billing_base_url_default"
    while getopts "u:s:h" opt; do
        case ${opt} in
            u )
                billing_user="$OPTARG"
                ;;
            s )
                billing_base_url="$OPTARG"
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

    echo "Server: $billing_base_url"
    echo "User: $billing_user"
    fi

    if [ -z ${billing_pass+x} ]; then
        echo -n "Password: "; read -s billing_pass;
    fi

    resp=$(curl -i -s -S "$billing_base_url"/billing/batch/v1/login -X POST \
        -H "Content-Type: application/json" \
        -H 'Accept: application/json, text/javascript, */*; q=0.01' \
        -H 'Connection: keep-alive' -d '{"username":"'$billing_user'","password":"'$billing_pass'"}')
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
