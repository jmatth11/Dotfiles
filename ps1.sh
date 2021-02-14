function working_dir() {
    echo -e "\e[1;32m$(pwd | sed 's/\/\(.\)[a-zA-Z0-9\.\-_]*/\/\1/g')\e[m"
}

function face_display() {
    if [[ $? == 0 ]]; then
        echo -e "\e[0;36m(^-^)\e[m"
    else
        echo -e "\e[0;31m(-.-;)\e[m"
    fi
}

export PS1="/[ \$(face_display) ]-[\e[0;34m\u\e[m\e[1;33m@\e[0;35m\h\e[m]-[\$(working_dir)]\n\\-> "
