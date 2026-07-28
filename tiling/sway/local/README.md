# Sway Local Config Directory

Populate it with `*.conf` files holding machine specific sway settings that are meant to be auto-included and ignored by git.

Included last, in filename order, so they override `../conf.d/`.

## Example files

- `outputs.conf`: monitor modes, positions, scales and workspace assignments
- `inputs.conf`: keyboard layout, per-device touchpad tweaks

`swaymsg -t get_outputs` lists output names and modes. `position` is in logical pixels, so after `scale`.

## Variables

`set $var` does not work here. Sway substitutes variables at parse time and this layer is parsed last, so override the `bindsym` instead.
