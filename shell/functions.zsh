docker_root () {
	if [[ $# != 1 ]] ; then
		echo 'ERROR: Exactly one argument (path) needed'
		return 1
	fi
	MAGIC_PATH="$1"
	if [[ "$1" == "." ]]; then
		MAGIC_PATH=$(pwd)
	fi
	docker run --rm -v $MAGIC_PATH:/magic -it ubuntu
}

# takes paths of directories to remove as arguments
# (arguments with * are accepted)
fast_dir_remove () {
    TEMP_TRASH=temp_trash_$(date +%s%N)/

    mkdir $TEMP_TRASH
    for DIR in "$@"
    do
        rsync -a --delete $TEMP_TRASH $DIR
        rm -rf $DIR
    done
    rm -rf $TEMP_TRASH
}

wipe_nvim () {
  dirsToDelete=("$HOME/.cache/nvim" "$HOME/.local/share/nvim" "$HOME/.local/state/nvim"
                "/usr/local/lib/nvim" "/usr/local/share/nvim" "/usr/share/nvim")

  sudo rm -rf "${dirsToDelete[@]}"
}