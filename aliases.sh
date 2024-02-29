# set up tmux alias to fix coloring
alias tmux="TERM=screen-256color-bce tmux"

# open all files with a given word.
function open_with_word() {
    grep -rni $1 | awk '{print $1}' | sed 's/:[0-9]*://g' | xargs nvim
}

# clean all branches except main, master, and current branch.
function clean_branches() {
    git branch | grep -v -e master -e main -e "* \w" | xargs git branch -d
}

#function clean_branches_with_exclude() {
#
#}

function git_clone() {
    git clone https://jmatth11:$GITHUB_TOKEN@github.com/$1 $HOME/git/$1
}

function docker_rm_containers() {
    sudo docker ps -a -q | xargs sudo docker rm
}

function docker_kill_containers() {
    sudo docker ps -a -q | xargs sudo docker kill
}

# check to see if your branch is out of date with origin
# Returns diff if different, returns nothing if they are up-to-date.
function git_branch_needs_update() {
    if [ $(git show --pretty=format:%H) != $(git show --pretty=format:%H origin) ]; then
        echo "diff"
    fi
}
