emulate sh -c 'source /etc/profile'
emulate sh -c 'source ~/.profile'

export HISTFILE=~/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=10000000
export EDITOR=vi

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt extended_glob

# source /usr/share/zplug/init.zsh
source ~/.zplug/repos/zplug/zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "plugins/autojump", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/virtualenv", from:oh-my-zsh
#zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-extras", from:oh-my-zsh
#zplug "plugins/mvn", from:oh-my-zsh
zplug "plugins/rsync", from:oh-my-zsh

zplug "plugins/zsh-syntax-highlighting", from:oh-my-zsh

zplug "themes/bira", from:oh-my-zsh, as:theme

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"

# zplug "zsh-users/zaw", use:zaw.zsh
# zplug "zsh-users/fizsh"

#zplug "ncw/rclone", from:gh-r, as:command, use:"*linux-amd64*"
zplug "k4rthik/git-cal", as:command, use:"git-cal"
# zplug "hackerb9/lsix", as:command, use:"lsix"
zplug "stefanhaustein/TerminalImageViewer", \
	as:command, \
	hook-build:"cd src/main/cpp; make;", \
	use:"src/main/cpp/tiv"

zplug "spidasoftware/format", \
    as:command, \
    use:"bin/format"

zplug "jhawthorn/fzy", \
	as:command, \
	rename-to:fzy, \
	hook-build:"make", \
	use:"fzy"

#zplug "b4b4r07/enhancd", use:init.sh

zplug "junegunn/fzf-bin", \
	from:gh-r, \
	as:command, \
	rename-to:fzf, \
	use:"*linux_amd64*"

zplug "b4b4r07/httpstat", \
	as:command, \
	use:'httpstat.sh', \
	rename-to:'httpstat'

#zplug "ogham/exa", \
#	from:gh-r, \
#	as:command, \
#	rename-to:exa, \
#	use:"*linux*"

zplug "mholt/archiver", \
	from:gh-r, \
	as:command, \
	rename-to:archiver, \
	use:"*linux*amd64*"

#zplug "stedolan/jq", \
#	from:gh-r, \
#	as:command, \
#	rename-to:jq

zplug load

source /etc/grc.zsh

function unrars {
    for i in **/*.rar~*.part*.rar(Lk+100); (
        cd ${i:h};
        rar x ${i:t} && rm ${i:t}
    )
}

function unzips {
    for i in **/*.zip(Lk+100); (
        cd ${i:h};
        7z x ${i:t} && rm ${i:t}
    )
}

function extract-iso {
    for i in **/*.iso(Lk+100); (
        cd ${i:h};
        7z x ${i:t} && rm ${i:t}
    )
}
function extract-7z {
    for i in **/*.7z(Lk+100); (
        cd ${i:h};
        7z x ${i:t} && rm ${i:t}
    )
}

function archtarxz {
    tar -c -f ${1}.tar.xz -a --exclude='*.xz' --exclude='*.bz2' --exclude='*.gz' --exclude='*.zip' --exclude='*.rar' --exclude='*.tar' --exclude='*.tar.*' --remove-files -v ${1}
}

function sprun {
    for app in $@; {
        pushd $app;
        mvn spring-boot:run &
        popd
    };
    jobs
}

alias rclone-move='rclone move --delete-empty-src-dirs -v'

PATH=$HOME/.zplug/bin:$PATH

alias ffp='ffprobe -hide_banner'
alias diz='diff -Z -qr'

function exif_total_duration {
    for dir in $@; {
        printf "$dir\t";
        find $dir -name "*.mp4" -printf "\"%p\" " | xargs exiftool -n -q -p '${Duration;our $sum;$_=ConvertDuration($sum+=$_)}' | tail -n 1
    }
}


source ~/.zsh_cache/kubectl_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/dominik/.sdkman"
[[ -s "/home/dominik/.sdkman/bin/sdkman-init.sh" ]] && source "/home/dominik/.sdkman/bin/sdkman-init.sh"
