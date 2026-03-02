alias ga 'git add'
alias gb 'git branch'
alias gc 'git commit'
alias gco "git checkout"
alias gd "git diff"
alias gp "git push"
alias gpu 'git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gst "git status"
alias gunapply 'git stash show -p | git apply -R'
alias gup "git pull --rebase"
alias gupp 'git fetch -p && gup'
alias gfu 'git commit --amend --no-edit'
alias gri 'git rebase -i --autosquash (git head-branch)'
alias griu 'git rebase -i --autosquash (git upstream-name)/(git head-branch)'

# V Mine V

alias gd-c='git diff --cached'
alias girb='git rebase -i'

alias strt='~/projects; tmux'
alias notepad='~/projects/notepad; vim notepad'

alias :qa='exit'

alias cr='cargo run'
alias cb='cargo build'
alias ct='cargo test —all'
alias cre='cargo run —example'
alias ctp='cargo test — —no capture'
alias cclip='cargo clip'
alias ctclip='cargo clippy —tests —all'
