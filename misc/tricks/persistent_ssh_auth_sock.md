# Persistent `$SSH_AUTH_SOCK`
Stable, predictable path for ssh socket

```sh
# .profile, .zprofile, .login - whatever you prefer
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
eval "$(ssh-agent -a "$SSH_AUTH_SOCK")"

keys=(
    ~/.ssh/work_ed25519
    ~/.ssh/personal_ed25519
)

for key in "${keys[@]}"; do
    if [ -f "$key" ]; then
        ssh-add -q "$key"
    fi
done
```
