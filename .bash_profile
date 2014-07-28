if [ -f ~/.bashrc ]; then
       source ~/.bashrc
       fi

eval $(ssh-agent)

function cleanup {
  echo "Killing SSH-Agent"
  kill -9 $SSH_AGENT_PID
}

trap cleanup EXIT

if [ -e /Users/tristan/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/tristan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

archey -c
