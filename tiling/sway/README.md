# sway

- `config` - entry point, symlinked by `link.sh` to `~/.config/sway/config`. Nothing but includes.
- `conf.d/*.conf` - the shared config, split by topic, loaded in filename order
- `local/*.conf` - machine-specific config, git-ignored, loaded last so it wins. See `local/README.md`
- `tofi.config` - launcher theme, symlinked to `~/.config/tofi/config`
- `sway-nvidia.desktop` - session entry, installed not symlinked
- `install-sway-session.sh` - installs session entry

Only `config` is symlinked. `conf.d/` and `local/` are pulled in by absolute-path includes, so adding a file there needs no `link.sh` change.

## Setup

```sh
sudo apt install sway sway-backgrounds swaybg swaylock waybar tofi \
  mako-notifier wl-clipboard grim slurp xdg-desktop-portal-wlr \
  brightnessctl brightness-udev pavucontrol

sudo usermod -aG video $USER

cd ~/.dotfiles
./link.sh
./tiling/sway/install-sway-session.sh   # needs root
```

Log out and back in afterwards.