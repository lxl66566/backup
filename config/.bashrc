HISTSIZE=
HISTFILESIZE=
HISTCONTROL=erasedups
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export EDITOR=vim
export all_proxy='http://127.0.0.1:10450'
export http_proxy='http://127.0.0.1:10450'
export https_proxy='http://127.0.0.1:10450'
export MSYS=enable_pcon
export SCCACHE_CACHE_SIZE="50G"

alias gp='git pull'
alias gc='git clone'
alias l='eza --all --long --color-scale --binary --header --time-style=long-iso'
alias e=$EDITOR
alias grep='grep --color=auto'
alias rv='revertversion'

function revertversion() {
	if [ $# -ne 1 ]; then
		echo "Usage: revertversion <version>"
		return 1
	fi
	echo "Reverting version $@"
	git push origin :refs/tags/$@
	git tag -d $@
	git tag $@
	git push --tags
}

function repeat() {
	if [ "$#" -eq 0 ]; then
		echo "usage: $0 <command> [args...]"
		exit 1
	fi
	MAX_ATTEMPTS=10000
	for ((i = 1; i <= MAX_ATTEMPTS; i++)); do
		echo "---"
		echo "第 $i 次尝试: 正在执行 '$@'"
		"$@"
		exit_code=$?
		if [ ${exit_code} -ne 0 ]; then
			echo "---"
			echo "命令在第 $i 次尝试时失败，退出码为 ${exit_code}。脚本已停止。"
			exit ${exit_code}
		fi
	done
	echo "命令成功执行了 ${MAX_ATTEMPTS} 次而未失败。"
}

function gfixup() {
	commit_hash="${1:-HEAD}"
	git commit -a --fixup "$commit_hash"

	if [ "$commit_hash" = "HEAD" ]; then
		rebase_target="HEAD~2"
	else
		rebase_target="${commit_hash}~1"
	fi
	GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash "$rebase_target"
}

eval "$(starship init bash)"
eval "$(fnm env --use-on-cd --shell bash)"
eval "$(zoxide init bash)"
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
