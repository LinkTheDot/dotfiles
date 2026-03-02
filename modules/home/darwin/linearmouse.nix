{ config, pkgs, lib, userConfig, ... }:

{
  xdg.configFile = {
    "linearmouse".source = config.lib.file.mkOutOfStoreSymlink "${userConfig.dotfilesPath}/config/linearmouse";
  };
}
