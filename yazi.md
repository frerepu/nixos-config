# Yazi File Manager Cheatsheet

**Terminal-based file manager configured in `/home/faelterman/.dotfiles/modules/yazi.nix`**

> **Note for Belgian AZERTY keyboard users**: Numbers 1-9 require Shift key. Special characters like brackets are in different positions.

---

## Navigation

### Basic Movement

| Key | Action | AZERTY Note |
|-----|--------|-------------|
| `j` / `↓` | Move down (next file) | |
| `k` / `↑` | Move up (previous file) | |
| `h` / `←` | Go to parent directory | |
| `l` / `→` | Enter directory / Open file | |
| `Enter` | Open selected file(s) | |
| `H` | Go back in history | Shift+h |
| `L` | Go forward in history | Shift+l |

### Quick Navigation

| Key | Action | AZERTY Note |
|-----|--------|-------------|
| `gg` | Jump to top | Press g twice |
| `G` | Jump to bottom | Shift+g |
| `Ctrl-u` | Move up half page | |
| `Ctrl-d` | Move down half page | |
| `Ctrl-b` | Move up full page | |
| `Ctrl-f` | Move down full page | |
| `PageUp` | Move up full page | |
| `PageDown` | Move down full page | |

### Go To Shortcuts

| Key | Action |
|-----|--------|
| `gh` | Go to home directory (`~`) |
| `gc` | Go to config directory (`~/.config`) |
| `gd` | Go to Downloads directory |
| `g Space` | Jump to directory interactively |
| `gf` | Follow symlink to target |

---

## File Operations

### Copy, Cut, Paste

| Key | Action |
|-----|--------|
| `y` | Yank (copy) selected files |
| `x` | Cut selected files |
| `p` | Paste yanked/cut files |
| `P` | Paste and overwrite if exists |
| `Y` or `X` | Cancel yank/cut operation |

### Create, Rename, Delete

| Key | Action |
|-----|--------|
| `a` | Create file (add `/` at end for directory) |
| `r` | Rename selected file |
| `d` | Delete (trash) selected files |
| `D` | Permanently delete files (no trash) |

### Links

| Key | Action |
|-----|--------|
| `-` | Create symlink (absolute path) |
| `_` | Create symlink (relative path) |
| `Ctrl--` | Create hardlink |

### Open Files

| Key | Action |
|-----|--------|
| `o` or `Enter` | Open with default application |
| `O` | Open interactively (choose application) |

---

## Selection

| Key | Action |
|-----|--------|
| `Space` | Toggle selection for current file and move down |
| `Ctrl-a` | Select all files |
| `Ctrl-r` | Invert selection (toggle all) |
| `v` | Enter visual mode (start selection) |
| `V` | Enter visual mode (unset) |
| `Esc` | Clear selection / Exit visual mode |

---

## Search & Filter

### Search

| Key | Action |
|-----|--------|
| `s` | Search files by name (via fd) |
| `S` | Search files by content (via ripgrep) |
| `Ctrl-s` | Cancel ongoing search |
| `/` | Find next file (interactive) |
| `?` | Find previous file |
| `n` | Jump to next match |
| `N` | Jump to previous match |

### Filter

| Key | Action |
|-----|--------|
| `f` | Filter files (smart filter) |
| `Esc` | Clear filter |

### Jump Tools

| Key | Action |
|-----|--------|
| `z` | Jump via fzf (fuzzy finder) |
| `Z` | Jump via zoxide (recent directories) |

---

## View Options

| Key | Action | Note |
|-----|--------|------|
| `.` | Toggle hidden files/folders visibility | **Enabled by default** in your config |

---

## Tabs

**⚠️ AZERTY Note**: Numbers 1-9 require Shift key!

| Key | Action | AZERTY |
|-----|--------|--------|
| `t` | Create new tab in current directory | |
| `Shift-1` to `Shift-9` | Switch to tab 1-9 | Use Shift + number |
| `[` | Switch to previous tab | AltGr+^ |
| `]` | Switch to next tab | AltGr+$ |
| `{` | Swap tab with previous | AltGr+' then Shift |
| `}` | Swap tab with next | AltGr+= then Shift |
| `Ctrl-c` | Close current tab (or quit if last) | |

---

## Sorting

All sorting commands start with `,` (comma):

| Key | Action |
|-----|--------|
| `,a` | Sort alphabetically |
| `,A` | Sort alphabetically (reverse) |
| `,n` | Sort naturally (handles numbers) |
| `,N` | Sort naturally (reverse) |
| `,m` | Sort by modified time |
| `,M` | Sort by modified time (reverse) |
| `,b` | Sort by birth time (creation) |
| `,B` | Sort by birth time (reverse) |
| `,s` | Sort by size |
| `,S` | Sort by size (reverse) |
| `,e` | Sort by extension |
| `,E` | Sort by extension (reverse) |
| `,r` | Sort randomly |

---

## Line Mode

Change what information is displayed next to files. All commands start with `m`:

| Key | Action |
|-----|--------|
| `mn` | None (minimal display) |
| `ms` | Show file sizes |
| `mp` | Show permissions |
| `mm` | Show modified time |
| `mb` | Show birth time (creation) |
| `mo` | Show owner |

---

## Copy Metadata

Copy file information to clipboard. All commands start with `c`:

| Key | Action |
|-----|--------|
| `cc` | Copy full path |
| `cd` | Copy directory path |
| `cf` | Copy filename |
| `cn` | Copy filename without extension |

---

## Preview & Spot

| Key | Action |
|-----|--------|
| `Tab` | Spot (focus on) hovered file |
| `K` | Scroll preview up 5 units |
| `J` | Scroll preview down 5 units |

**In Spot mode**:
- `Tab` / `Esc` - Close spot
- `h` / `l` - Swipe between files
- `j` / `k` - Scroll within file

---

## Shell & Tasks

| Key | Action |
|-----|--------|
| `;` | Run interactive shell command |
| `:` | Run blocking shell command |
| `w` | Show task manager |
| `.` | Toggle hidden files visibility |

---

## Help & System

| Key | Action |
|-----|--------|
| `~` or `F1` | Open help screen |
| `q` | Quit yazi |
| `Q` | Quit without saving cwd-file |
| `Ctrl-z` | Suspend yazi |
| `Esc` | Exit mode / Clear selection / Cancel |

---

## Quick Reference Card

### Most Common Operations

| Task | Keys |
|------|------|
| Navigate | `hjkl` or arrow keys |
| Enter directory | `l` or `→` or `Enter` |
| Go back | `h` or `←` |
| Select file | `Space` |
| Copy files | `y` then navigate and `p` |
| Move files | `x` then navigate and `p` |
| Delete files | `d` (trash) or `D` (permanent) |
| Create file/dir | `a` (add `/` for directory) |
| Rename | `r` |
| Search | `s` (name) or `S` (content) |
| Filter | `f` |
| New tab | `t` |
| Jump to directory | `z` (fzf) or `Z` (zoxide) |
| Toggle hidden | `.` |
| Show help | `~` or `F1` |

---

## Configuration

Your yazi is configured with:
- **Terminal**: kitty
- **Editor**: nvim (opened in kitty)
- **Show hidden files**: Enabled by default
- **Sort**: Alphabetical, directories first
- **Theme**: Catppuccin colors
- **Desktop launcher**: Available in application menu

### Config files location
- Main config: `/home/faelterman/.dotfiles/modules/yazi.nix`
- Runtime config: `~/.config/yazi/`

---

## Tips

- **AZERTY Keyboard**: Remember to use Shift for numbers when switching tabs (Shift+1, Shift+2, etc.)
- **Creating directories**: When using `a` to create, end the name with `/` for a directory
- **Bulk operations**: Use `Space` to select multiple files, then operate on all at once
- **Quick navigation**: Use `z` for fuzzy finding or `Z` for recent directories
- **Visual mode**: Press `v` and use movement keys to select, then `y`/`x`/`d` to operate
- **Preview scrolling**: Use `J`/`K` to scroll in the preview pane
- **Mouse support**: Click and scroll are enabled
- **Symlink following**: Use `gf` when hovering over a symlink to jump to its target
