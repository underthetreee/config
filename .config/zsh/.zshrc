setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

autoload -U compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

setopt prompt_subst 
export PROMPT='%n %~ $(parse_git_branch) $ '

bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

alias ls='ls -lha --color=auto'
alias code='vscodium'

alias arch-update='sudo pacman -Syu && sudo aura -Au'
alias arch-install='sudo pacman -S'
alias arch-install-aur='sudo aura -A'
alias arch-remove='sudo pacman -Rs'
alias arch-clean='sudo paccache -rk1 && sudo paccache -ruk0 && sudo pacman -Rsn $(pacman -Qdtq)'
alias arch-list='LC_ALL=C pacman -Qei | awk '\''/^Name/{name=$3} /^Installed Size/{print $4$5, name}'\'' | sort -h'
