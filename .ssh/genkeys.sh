#! /usr/bin/env bash
# configure ssh keys

# populate config file only if not exists
if [[ ! -f $HOME/.ssh/config ]] ; then
    echo Creating .ssh/config
/bin/cat <<EOM >$HOME/.ssh/config
# personal
Host MatrixMan-github
    HostName github.com
    User git
    IdentityFile /home/matt/.ssh/personal_rsa
    IdentitiesOnly yes

# work
Host mattrixman-github
    HostName github.com
    User git
    IdentityFile /home/matt/.ssh/work_rsa
    IdentitiesOnly yes
EOM
else
    echo .ssh/config already exists
fi

# gen personal MatrixManAtYrService
gen()
{
    FILE="$HOME/.ssh/${1}_rsa"
    if [[ ! -f $FILE ]] ; then
        echo $1
        ssh-keygen -b 4096 -f $FILE -C $2
        eval `ssh-agent -s`
        ssh-add $FILE
    else
        echo $1 key already exists
    fi
}

# up personal github MatrixManAtYrService
up()
{
    FILE="$HOME/.ssh/${1}_rsa.pub"
    BREADCRUMB="$HOME/.ssh/.${1}_is_on_${2}"
    if [[ ! -f $BREADCRUMB ]] ; then
        echo Uploading $1 ssh key to $2 as $3
        ssh-keyreg -p $HOME/.ssh/${1}_rsa.pub -u $3 github
        touch $BREADCRUMB
    else
        echo $1 key already uploaded
    fi
}

gen personal MatrixManAtYrService

up personal github MatrixManAtYrService

echo Now you can do things like:
echo     git remote add origin git@MatrixMan-github:MatrixManAtYrService/projName.git

gen work mattrixman

up work github mattrixman

echo Now you can do things like:
echo     git remote add origin git@mattrixman-github:mattrixman/projName.git
