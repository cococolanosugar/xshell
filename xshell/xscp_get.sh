 #!/usr/bin/env bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

group_name="$1";
server_name="$2";
src=$3
dst=$4

get_group_file(){
    group_name="$1";
    group_file="${ROOT_DIR}/data/server_group_${group_name}"
    printf '%s\n' "${group_file}"
}

#split ssh params
group_file=$(get_group_file ${group_name})
eval "$(cat -n ${group_file} | sed 's/^[ \t]*//g' | grep "^${server_name}" | awk -v username="root" '{ printf("ip=%s;port=%s;username=%s;password=%s;server_name=%s", $3,$4,username,$5,$2) }')"

expect_script_file=$ROOT_DIR/expect/scp_get.expect

expect -f ${expect_script_file} ${username} ${password} ${ip} ${port} ${src} ${dst}