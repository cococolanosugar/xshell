#!/usr/bin/env bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $ROOT_DIR/config/environ.sh
source $ROOT_DIR/lib/help.sh
source $ROOT_DIR/lib/utils.sh

get_group_file(){
    group_name="$1";
    group_file="${ROOT_DIR}/data/server_group_${group_name}"
    printf '%s\n' "${group_file}"
}

# check group config file
check_group(){
    group_name="$1";
    # group_file="${ROOT_DIR}/data/server_group_${group_name}"
    group_file=$(get_group_file "${group_name}")
    if [ ! -f ${group_file} ]; then
        help_group
        tips="Noop: group file not exits!";
        print_color "${tips}" "YELLOW";
        exit;
    fi
}

# check server
check_server(){
    group_name="$1";
    server_name="$2";
    group_file=$(get_group_file "${group_name}")

    cnt=$(cat -n ${group_file} | sed 's/^[ \t]*//g' | grep -c "^${server_name}")

    if [ "${cnt}" -gt 1 ]; then
        help_server $group_name
        tips="multiple servers detected, please make it more clear.";
        print_color "${tips}" "YELLOW";
        exit
    fi

    if [ "${cnt}" -eq 0 ] || [ -z ${server_name} ]; then
        help_server $group_name
        tips="none server detected, please check your server names.";
        print_color "${tips}" "YELLOW";
        exit
    fi
}

# check input args
check_input(){
    # expect a group and a server name
    group_name="$1";

    check_group "${group_name}"

    server_name="$2";

    check_server "${group_name}" "${server_name}"
}

main(){
    # reaname args
    group_name="$1";

    server_name="$2";

    #check input
    check_input "${group_name}" "${server_name}"

    #split ssh params
    group_file=$(get_group_file ${group_name})
    eval "$(cat -n ${group_file} | sed 's/^[ \t]*//g' | grep "^${server_name}" | awk -v username="root" '{ printf("ip=%s;port=%s;username=%s;password=%s;server_name=%s", $3,$4,username,$5,$2) }')"

    #expect logic
    expect_script_file=$ROOT_DIR/expect/ssh.expect

    #cat -n ${expect_script_file} # Uncomment for debug
    expect -f ${expect_script_file} ${username} ${password} ${ip} ${port} ${server_name} # run expect script
}

# check script args
arg_cnt=$#
if [ "${arg_cnt}" -lt 1 ]; then
    help_group
    exit
else
    main "$1" "$2"
fi