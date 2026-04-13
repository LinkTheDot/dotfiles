alias attach "tmux attach-session -c ~/Projects -t"
alias k 'kubectl'
alias ls lsd
alias proj 'cd ~/Projects'
alias vim nvim

alias strt='~/projects; tmux'
alias notepad='~/projects/notepad; vim notepad'

alias :qa='exit'

alias cr='cargo run'
alias cb='cargo build'
alias ct='cargo test --all'
alias cre='cargo run --example'
alias ctp='cargo test -- --nocapture'
alias cclip='cargo clippy'
alias ctclip='cargo clippy --tests --all'

alias ttsql='mycli -h $HOMELAB_ADDRESS -P 30000 -uroot -ppassword -D twitch_tracker_db'
alias ksql='mysql -h $HOMELAB_ADDRESS -P 30000 -uroot -ppassword -D twitch_tracker_db'

alias pclaude="CLAUDE_CONFIG_DIR=~/.claude-personal claude"
alias wclaude="CLAUDE_CONFIG_DIR=~/.claude-work claude"

