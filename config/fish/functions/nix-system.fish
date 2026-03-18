function nix-system
  set -l flake_config ""
  set -l rebuild_cmd ""
  set -l hostname_val (hostname -s)

  if is_macos
    set rebuild_cmd "darwin-rebuild"
    # Map hostname to flake configuration
    switch $hostname_val
      case workmac
        set flake_config "workmac"
      case '*'
        echo "Unknown macOS hostname: $hostname_val"
        return 1
    end
  else if is_linux
    set rebuild_cmd "nixos-rebuild"
    switch $hostname_val
      case personal_computer
        set flake_config "personal_computer"
      case '*'
        echo "Unknown Linux hostname: $hostname_val"
        return 1
    end
  else
    echo "Unknown system type: "(uname -s)

    return 1
  end

  echo "Using configuration: $flake_config"
  sudo $rebuild_cmd switch --flake ~/.dotfiles#$flake_config
end
