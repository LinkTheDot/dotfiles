# Copy this file to users.local.nix and fill in your details
# users.local.nix is git-ignored and won't be committed
# This single configuration is used by all machine profiles
{
  username = "looank"; # MUST be your actual username (run 'whoami' to check)
  fullName = "looank";
  userEmail = "looank@proton.me";
  gpgKey = ""; # optional GPG key ID

  # System configuration
  hostName = "personal_computer";
  computerName = "personal_computer"; # macOS only, ignored on Linux
}

