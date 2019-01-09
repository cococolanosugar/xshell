
print_color (){
    # Use colors, but only if connected to a terminal, and that terminal
    # supports them.
    if [ -x "$(command -v tput)" ]; then
      ncolors=$(tput colors)
    fi
    if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
        RED="$(tput setaf 1)"
        GREEN="$(tput setaf 2)"
        YELLOW="$(tput setaf 3)"
        BLUE="$(tput setaf 4)"
        BOLD="$(tput bold)"
        NORMAL="$(tput sgr0)"
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        NORMAL=""
    fi

    tips="$1"
    color="$2"

    case "${color}" in
        "RED")
            printf "%s" "${RED}"
            echo -e "tips:\\n\\t${tips}"
            printf "%s" "${NORMAL}"
        ;;
        "GREEN")
            printf "%s" "${GREEN}"
            echo -e "tips:\\n\\t${tips}"
            printf "%s" "${NORMAL}"
        ;;
        "YELLOW")
            printf "%s" "${YELLOW}"
            echo -e "tips:\\n\\t${tips}"
            printf "%s" "${NORMAL}"
        ;;
        "BLUE")
            printf "%s" "${BLUE}"
            echo -e "tips:\\n\\t${tips}"
            printf "%s" "${NORMAL}"
        ;;
        "BOLD")
            printf "%s" "${BOLD}"
            echo -e "tips:\\n\\t${tips}"
            printf "%s" "${NORMAL}"
        ;;
        "HELP")
            printf "%s" "${RED}"
            echo '                      .__            '
            echo '___  _____ __  _____|  |__   ____    '
            echo '\  \/  /  |  \/  ___/  |  \_/ ___\   '
            echo ' >    <|  |  /\___ \|   Y  \  \___   '
            echo '/__/\_ \____//____  >___|  /\___  >  '
            echo '      \/          \/     \/     \/   '
            printf "%s" "${NORMAL}"

            echo

            printf "%s" "${GREEN}"
            echo -e "${tips}"
            printf "%s" "${NORMAL}"
        ;;
        *)
            echo -e "${tips}"
        ;;
    esac
}

basename() {
    # Usage: basename "path"
    : "${1%/}"
    printf '%s\n' "${_##*/}"
}

trim_string() {
    # Usage: trim_string "   example   string    "
    : "${1#"${1%%[![:space:]]*}"}"
    : "${_%"${_##*[![:space:]]}"}"
    printf '%s\n' "$_"
}

# function for setting terminal titles
set_terminal_title() {
  printf "\033]0;%s\007" "$1"
}