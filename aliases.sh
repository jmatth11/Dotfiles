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
  if [ -z $GITHUB_TOKEN ]; then
    git clone git@github.com:$1.git $HOME/git/$1
  else
    git clone https://jmatth11:$GITHUB_TOKEN@github.com/$1 $HOME/git/$1
  fi
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

function reset_github_token() {
    save_dir=$(pwd)
    working_dir=$1
    if [ -z $working_dir ]; then
        working_dir="$HOME/git"
    fi
    cd $working_dir

    # grab all user folders
    users=$(ls -d -- */)
    for d in $users;
    do
        cd $d
        # grab all project folders
        projects=$(ls -d -- */ 2> /dev/null)
        for proj in $projects;
        do
            cd $proj
            url=$(git remote get-url origin 2> /dev/null)
            # if command failed we are not in a git repo
            if [ $? -eq 0 ]; then
                # define capture groups
                capture="(.*):\\w*(@.*)"
                # check if url matches capture
                if [[ $url =~ $capture ]]
                then
                    # reset origin's url with current github token
                    git remote set-url origin "${BASH_REMATCH[1]}:$GITHUB_TOKEN${BASH_REMATCH[2]}"
                fi
            fi
            cd ..
        done
        cd ..
    done
    cd $save_dir
}
