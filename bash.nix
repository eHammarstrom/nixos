{ config, pkgs, ... }:

{
  programs.bash.shellAliases = {
    ls      = "ls --color=auto";
    ema     = "emacsclient -c";
    emat    = "emacsclient -t";
    gs      = "git status";
    gp      = "git push";
    gct     = "git commit";
    gco     = "git checkout";
    gad     = "git add";
    gdf     = "git diff";
    scrsnip = "scrot -s ~/screenshots/%b%d::%H%M%S.png";
    scr     = "scrot ~/screenshots/%b%d::%H%M%S.png";
    npp     = "nix-instantiate --eval --expr \"<nixpkgs>\"";
  };
}
