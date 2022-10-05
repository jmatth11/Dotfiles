function prompt_working_dir() {
    echo -e "\e[1;32m$(pwd | sed 's/\/\(.\)[a-zA-Z0-9\.\-_]*/\/\1/g')\e[m"
}

function prompt_machine_display_text() {
    echo -e "\e[0;34m\u\e[m\e[1;33m@\e[0;35m\h\e[m"
}

function prompt_git_current_branch() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == "true" ]]; then
        cur_git_branch=$(git branch --show-current)
        echo -e "-\e[0;37;40m($cur_git_branch)\e[m"
    fi
}

function prompt_face_display() {
    if [[ $? == 0 ]]; then
        echo -e "\e[0;36m(^-^)\e[m"
    else
        echo -e "\e[0;31m(-.-;)\e[m"
    fi
}

function prompt_ps1_text() {
    echo -e "/[ \$(prompt_face_display) ]-[\$(prompt_machine_display_text)]-[\$(prompt_working_dir)]\$(prompt_git_current_branch)\n\\-> "
}

unset PS1
PS1=$(prompt_ps1_text)

