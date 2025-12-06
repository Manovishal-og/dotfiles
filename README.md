
# 🚀 Dotfiles

This repository contains my personal configuration files for development, window management, terminals, and productivity tools.  
It includes setups for:

- **Neovim**
- **Hyprland**
- **Kitty terminal**
- **tmux**
- **zsh (.zshrc)**

These dotfiles help maintain a consistent environment across machines and make reinstallation or migration easier.

---

## 📂 Folder Structure

dotfiles/
│── nvim/           # Neovim configuration
│── hyprland/       # Hyprland window manager config
│── kitty/          # Kitty terminal configuration
│── tmux/           # tmux configuration
└── zshrc           # zsh configuration file


---

## 🔧 Installation / Setup

To use these dotfiles on your system:

### 1. Clone this repository

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git
cd dotfiles
````

### 2. Copy configuration files to your home directory

```bash
cp -r nvim ~/.config/
cp -r hyprland ~/.config/
cp -r kitty ~/.config/
cp -r tmux ~/.config/
cp zshrc ~/.zshrc
```

> If using symlinks or GNU Stow for dotfile management, adjust accordingly.

---

## 🔄 Updating Dotfiles

After making changes locally, push updates to your repository:

```bash
git add .
git commit -m "Update dotfiles configuration"
git push
```

---

## ✨ Tools Used in These Configurations

* Linux / Unix shell
* Neovim
* Hyprland WM
* Kitty Terminal
* tmux
* zsh
* git for version control

---

## 📌 Why This Repository Exists

✔ Keeps my environment portable
✔ Makes reinstalling easier
✔ Tracks configuration changes
✔ Helps others reuse or learn from my setup

---

## 🤝 Contributing

Suggestions, improvements, or forks are welcome.
Happy customizing! ✨

---

