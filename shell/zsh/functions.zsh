docker_root() {
    if [[ $# != 1 ]]; then
        echo 'ERROR: Exactly one argument (path) needed' >&2
        return 1
    fi

    local magic_path="$1"
    [[ "$1" == "." ]] && magic_path=$(pwd)

    docker run --rm -v "$magic_path:/magic" -it ubuntu
}

# takes paths of directories to remove as arguments
# (arguments with * are accepted)
fast_dir_remove() {
    if [[ $# -eq 0 ]]; then
        echo "No directories specified" >&2
        return 1
    fi

    local temp_trash="temp_trash_$(date +%s%N)/"
    mkdir "$temp_trash"

    for dir in "$@"; do
        rsync -a --delete "$temp_trash" "$dir"
        rm -rf "$dir"
    done

    rm -rf "$temp_trash"
}

alias fdr=fast_dir_remove

show_contents() {
    local root="${1:-.}"
    root=$(cd "$content_root" 2>/dev/null && pwd) || {
        echo "Path not found: $content_root" >&2
        return 1
    }

    local file_list
    if git -C "$root" rev-parse --git-dir >/dev/null 2>&1; then
        file_list=$(git -C "$root" ls-files --cached --others --exclude-standard | sed "s|^|$root/|")
    else
        file_list=$(find "$root" -type f 2>/dev/null)
    fi

    echo "$file_list" | while IFS= read -r file; do
        grep -qI . "$file" 2>/dev/null || continue # text files only
        printf '\n======== %s ========\n' "$file"
        cat "$file"
    done
}

alias show=show_contents
