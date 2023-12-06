# set up tmux alias to fix coloring
alias tmux="TERM=screen-256color-bce tmux"

# open all files with a given word.
function open_with_word() {
    grep -rni $1 | awk '{print $1}' | sed 's/:[0-9]*://g' | xargs nvim
}

# clean all branches except main, master, and current branch.
function clean_branches() {
    git branch | grep -v master | grep -v main | grep -v "* \w" | xargs git branch -d
}

function git_clone() {
    git clone https://jmatth11:$GITHUB_TOKEN@github.com/$1 $HOME/git/$1
}
