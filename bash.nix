{ config, pkgs, ... }:

{
  programs.bash.shellAliases = {
    ema = "emacsclient -c";
    gs = "git status";
    gct = "git commit";
    gad = "git add";
    scrsnip = "scrot -s ~/screenshots/%b%d::%H%M%S.png";
    scr = "scrot ~/screenshots/%b%d::%H%M%S.png";
    npp = "nix-instantiate --eval --expr \"<nixpkgs>\"";
  };
}
