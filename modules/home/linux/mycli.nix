{ config, userConfig, ... }:

{
  home.file = {
    ".myclirc".source = config.lib.file.mkOutOfStoreSymlink "${userConfig.dotfilesPath}/config/mycli/.myclirc";
    ".mycli-history".source = config.lib.file.mkOutOfStoreSymlink "${userConfig.dotfilesPath}/config/mycli/.mycli-history";
    ".mycli-log".source = config.lib.file.mkOutOfStoreSymlink "${userConfig.dotfilesPath}/config/mycli/.mycli-log";
  };
}
