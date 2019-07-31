
remove_param() {
    echo "$*" | sed 's#[-a-zA-Z0-9]* ##'
}

set_query_and_output_type() {
    if [[ "$1" =~ -.* ]]
    then
        case "$1" in
            "-jr")
               export QUERY_OUTPUT="rows"
               export QUERY=$(remove_param "$*")
                ;;
            "-jc")
               export QUERY_OUTPUT="columns"
               export QUERY=$(remove_param "$*")
                ;;
            *)
               export QUERY_OUTPUT="table"
               export QUERY="$*"
                ;;
        esac
    else
        export QUERY_OUTPUT="table"
        export QUERY="$*"
    fi
}

mysql_query_param() {
    export MYSQL_PWD="$2"
    mysql "-u$1" "-h$3" "-P$4" -e "use $5; $6;"
}

mysql_query_param_pipe_out() {
    export MYSQL_PWD="$2"
    mysql "-u$1" "-h$3" "-P$4" -e "use $5; $6;" -N
}

mysql_query_pipe_in_out() {
    read sql
    export MYSQL_PWD="$2"
    mysql -u"$1" -h"$3" "-P$4" -e "use $5; $sql;" -N
}

mysql_query_pipe_in() {
    read sql
    export MYSQL_PWD="$2"

    # convince mysql that stdin isn't a pipe so that we get the table drawings
    script --return -qc "mysql -u\"$1\" -h\"$3\" \"-P$4\" -e \"use $5; $sql;\"" /dev/null
}

mysql_query() {
    user="$1"
    pass="$2"
    host="$3"
    db="$4"
    port="${5:-3306}"

    if [ -t 0 ]
    then
        if [ -t 1 ]
        then
            mysql_query_param "$user" "$pass" "$host" "$port" "$db" "$QUERY"
        else
            mysql_query_param_pipe_out "$user" "$pass" "$host" "$port" "$db" "$QUERY"
        fi
    else
        if [ -t 1 ]
        then
            mysql_query_pipe_in "$user" "$pass" "$host" "$port" "$db"
        else
            mysql_query_pipe_in_out "$user" "$pass" "$host" "$port" "$db"
        fi
    fi

    unset QUERY
    unset QUERY_OUTPUT
}

q() {
    echo $*
}

# add one of these per db-of-intereset to ~/.zshrc2
#    meta0() {
#    set_query_output_type $*
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
    paste -sd, | tr -d "\n"
    echo ")"
}

# like above, but quoted
#   ("foo", "bar", "baz")
tb2qlst(){
    echo -n "("
    sed "s/.*/\"&\"/" | paste -sd, | tr -d "\n"
    echo ")"
}
