# get available server group list
get_group_file_list(){
    for group_file in ${ROOT_DIR}/data/*; do
        name=$(basename $group_file)
        printf '%s\n' "$name"
    done
}

# print group help tips
help_group(){

    read -rd '' tips <<EOF
tips: 

available group list:
$(get_group_file_list | awk -F_ '{ print NR ".\t" $3 }')
EOF

    print_color "$tips" "HELP"
    
    echo
}

# print server help tips
help_server(){
    group_name=$1
    group_file=$(get_group_file "${group_name}")
    read -rd '' tips <<EOF
tips: 

available server list:
$(cat -n ${group_file} | sed 's/^[ \t]*//g' | awk -v program_name=${program_name} -v group_name="${group_name}" 'BEGIN { print "Tag    Name    Ip    Port    Password"; print ""} { print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5; print "" } END { print "useage: " program_name " " group_name " server_tag"; print "" }')
EOF

    print_color "${tips}" "HELP";

    echo;
}