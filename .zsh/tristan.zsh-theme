get_pwd() {
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done
  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi
  echo $prompt_short_dir
}

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

git_repo_color() {
  local cb=$(git_current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)"
  fi
}

MODE_INDICATOR="%{$fg[yellow]%}"

PROMPT='%B%{$fg[cyan]%}$(git_repo_color)$(get_pwd)% %{$fg[cyan]%} $(vi_mode_prompt_info)$%b %{$reset_color%}'
RPROMPT=""
