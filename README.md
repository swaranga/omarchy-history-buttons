# History Buttons for Omarchy

Two bar buttons for the Omarchy shell:

- **󰂚 Notification history**: click to show your recent notifications again, click again to hide them; right-click to dismiss all.
- **󰅇 Clipboard history**: click to open the clipboard manager.

They run the same actions as Omarchy's keybindings (Super+Shift+Alt+, and Super+Ctrl+V). Requires Omarchy 4.5 or later.

## Install

```bash
omarchy plugin add https://github.com/swaranga/omarchy-history-buttons.git --enable
```

Move it with `omarchy bar move io.github.swaranga.history-buttons --section <section>`.

## Options

By default one widget shows both buttons. To place them separately, give each
entry in `~/.config/omarchy/shell.json` a `buttons` list:

```json
{ "id": "io.github.swaranga.history-buttons", "buttons": ["notifications"] },
{ "id": "io.github.swaranga.history-buttons", "buttons": ["clipboard"] }
```
