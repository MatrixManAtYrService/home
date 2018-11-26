mysql_query() {
    if [ -t 1 ]
    then
        mysql --column-names -u$1 -p$2 -h$3 -A -e "use $4; $5;" 2> >(grep -v password 1>&2)
    else
        mysql --column-names -u$1 -p$2 -h$3 -A -e "use $4; $5;" 2> >(grep -v password 1>&2) | tail -n +1
    fi
}

# add one of these per db-of-intereset to ~/.zshrc2
#    mydb() {
#        mysql_query user 'pass' host db "$*;"
#    }
#

# get a list of dictionaries, one per row
tbr2j() {
    cat - \
        | sqawk -output json 'select * from a' header=1 \
        | jq 'map(del(.anf, .anr)
                | to_entries
                | map(select(.key | test("^a\\d+$") | not))
                | from_entries)'
}

# get a single object with a list of values for each column
tbc2j() {
    read -r -d '' as_list << 'EOF'
import json, sys
obj = {}
for line in sys.stdin:
  key = line.split("\t")[0]
  values = [x.strip() for x in line.split("\t")[1:]]
  obj[key] = values
sys.stdout.write(json.dumps(obj))
EOF
    cat - \
        | datamash -W transpose \
        | python -c "$as_list"  \
        | jq .
}

# format
#   colname
#   foo
#   bar
#   baz
# to
#   (foo, bar, baz)
# for use in WHERE clauses
tb2lst(){
    echo -n "("
    tail -n +2 - | paste -sd, | tr -d "\n"
    echo ")"
}

# like above, but quoted
#   ("foo", "bar", "baz")
tb2qlst(){
    echo -n "("
    tail -n +2 - |sed "s/.*/\"&\"/" | paste -sd, | tr -d "\n"
    echo ")"
}

