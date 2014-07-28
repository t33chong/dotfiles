if [ -f ~/.bashrc ]; then
       source ~/.bashrc
       fi

archey -c

if [ -e /Users/tristan/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/tristan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
