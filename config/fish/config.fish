export LSCOLORS=ExFxCxDxBxegedabagacad
export CLICOLOR="YES"
export DOTFILES=$HOME/.dotfiles
export EDITOR="nvim"
export STARSHIP_LOG=error
export XDG_CONFIG_HOME=$HOME/.config
export RUBY_YJIT_ENABLE=1
export LOCAL_POSTGRES_DB_PASSWORD="Ocarinaofshit10!"

for f in $HOME/.config/fish/aliases/*fish
  source $f
end

if test -e ~/.localrc.fish
  source ~/.localrc.fish
end

if status is-interactive && command -v starship >/dev/null 2>&1
  # stop visual bell from doing anything
  printf "\e[?1042l"

  starship init fish | source
  direnv hook fish | source

  # fish 4.x changed cancel-commandline to not move to a new line; restore old behavior
  bind \cc 'commandline -f end-of-line; printf "^C\n"; commandline --replace ""; commandline -f execute'
end

# if string match -q "*not*" (service docker status)
#     sudo /usr/sbin/service docker start
# end

# Mine
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DATABASE_PASSWORD="Ocarinaofshit10!"
export PGPASSWORD="Ocarinaofshit10!"
export WORKDIR="/mnt/c/Users/Cirno/OneDrive/Desktop/1a-for-working-on-shit"

set -gx HOMELAB_ADDRESS (ssh -G homelab | awk '$1 == "hostname" { print $2 }')
# Disable annoying keyring popup
set -x PKG_CONFIG_PATH $HOME/.nix-profile/lib/pkgconfig $PKG_CONFIG_PATH
set -x PYTHON_KEYRING_BACKEND keyring.backends.null.Keyring

# ^Mine^
