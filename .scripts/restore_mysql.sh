#! /usr/bin/env bash
set -euo pipefail

old=p801march_before
new=p801march_billing
user=root
pass=test

mysqlrun(){
    set -x
    mysql -u${user} -p${pass} -sNe "$1;"
}


echo "create database: $new"
mysqlrun "create database $new"

echo "rename table: $new"
mysqlrun "use $old; show tables" | while read table; do
    echo "rename table: $old.$table -> $new.$table"
    mysqlrun "rename table $old.$table to $new.$table;"
done

for db_user in $(mysqlrun "show processlist" | grep $old | awk '{print $2}' | sort | uniq); do
    echo "mimic grants for $db_user in $old, now in $new"
    IFS='\n'
    for grant in $(mysqlrun "use $old; show grants for $db_user" | grep "\`$old\`") ; do
        echo "${grant/$old/$new}"
        mysqlrun "${grant/$old/$new}"
    done
done

echo "drop database: $old"
mysqlrun "drop database $old"
