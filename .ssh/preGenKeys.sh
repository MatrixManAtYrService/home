#! /usr/bin/env bash

# installs ssh-keyreg
# run this as root, then run .genKeys.sh

sudo sh -c "curl https://raw.githubusercontent.com/b4b4r07/ssh-keyreg/master/bin/ssh-keyreg -o /usr/local/bin/ssh-keyreg && chmod +x /usr/local/bin/ssh-keyreg"
