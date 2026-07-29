# sway

- `config` - entry point, symlinked by `link.sh` to `~/.config/sway/config`. Nothing but includes.
- `conf.d/*.conf` - the shared config, split by topic, loaded in filename order
- `local/*.conf` - machine-specific config, git-ignored, loaded last so it wins. See `local/README.md`
- `tofi.config` - launcher theme, symlinked to `~/.config/tofi/config`
- `waybar` - configured in `../waybar/` and launched from `conf.d/50-bar.conf`
- `sway-nvidia.desktop` - session entry, installed not symlinked
- `install-sway-session.sh` - installs session entry

Only `config` is symlinked. `conf.d/` and `local/` are pulled in by absolute-path includes, so adding a file there needs no `link.sh` change.

## Setup

```sh
sudo apt install sway sway-backgrounds swaybg swaylock waybar tofi \
  mako-notifier wl-clipboard grim slurp xdg-desktop-portal-wlr \
  brightnessctl brightness-udev pavucontrol blueman

sudo usermod -aG video $USER

# waybar has its own bluetooth module. Disable only blueman's tray plugin, not the applet:
gsettings set org.blueman.general plugin-list "['!StatusNotifierItem']"

cd ~/.dotfiles
./link.sh
./tiling/sway/install-sway-session.sh   # needs root
```

Log out and back in afterwards.