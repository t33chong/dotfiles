if [ -f ~/.bashrc ]; then
       source ~/.bashrc
       fi

if [ -e /Users/tristan/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/tristan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

$(boot2docker shellinit 2>/dev/null)
archey -c

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# Load nodenv automatically by appending
# the following to ~/.zshrc:

eval "$(nodenv init -)"

export SBT_CREDENTIALS=$HOME/.sbt/credentials
