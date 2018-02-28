#! /usr/bin/env bash
set -euo pipefail

old=p801march_before
new=p801march_billing
user=root
pass=test

mysql -u${user} -p${pass} -sNe "create database $new;"

mysql -u${user} -p${pass} $old -sNe 'show tables' | while read table; do
    echo mysql -u${user} -p${pass} -sNe "rename table $old.$table to $new.$table;"
done

