set_query_output_type() {
    if [[ "$1" =~ -.* ]]
    then
        case "$1" in
            "-jr")
               export QUERY_OUTPUT="rows"
                ;;
            "-jc")
               export QUERY_OUTPUT="columns"
                ;;
            *)
               export QUERY_OUTPUT="table"
                ;;
        esac
        shift 1
    else
        export QUERY_OUTPUT="table"
    fi
}

mysql_query_param() {
    export MYSQL_PWD="$2"
    mysql "-u$1" "-h$3" -e "use $4; $5;"
}

mysql_query_param_pipe_out() {
    export MYSQL_PWD="$2"
    mysql "-u$1" "-h$3" -e "use $4; $5;" -N
}

mysql_query_pipe_in_out() {
    read sql
    export MYSQL_PWD="$2"
    mysql -u"$1" -h"$3" -e "use $4; $sql;" -N
    echo foo
}

mysql_query_pipe_in() {
    read sql
    export MYSQL_PWD="$2"

    # convince mysql that stdin isn't a pipe so that we get the table drawings
    script --return -qc "mysql -u\"$1\" -h\"$3\" -e \"use $4; $sql;\"" /dev/null 
}

mysql_query() {
    user="$1"
    pass="$2"
    host="$3"
    db="$4"
    query="$5"

    echo $QUERY_OUTPUT

    if [ -t 0 ]
    then
        if [ -t 1 ]
        then
            mysql_query_param "$user" "$pass" "$host" "$db" "$query"
        else
            mysql_query_param_pipe_out "$user" "$pass" "$host" "$db" "$query"
        fi
    else
        if [ -t 1 ]
        then
            mysql_query_pipe_in "$user" "$pass" "$host" "$db"
        else
            mysql_query_pipe_in_out "$user" "$pass" "$host" "$db"
        fi
    fi
}

q() {
    echo $*
}

# add one of these per db-of-intereset to ~/.zshrc2
#    meta0() {
#    mysql_query root test 10.249.253.118 meta0 "$*"
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

