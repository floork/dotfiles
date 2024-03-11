# Dotfiles Repository

This repository contains my personal dotfiles, configurations, and scripts tailored to customize and enhance my development environment across various tools and applications.

## Table of Contents

- [Overview](#overview)
- [Usage](#usage)
- [Structure](#structure)
- [Installation](#installation)
- [TODO](#todo)
- [Contributing](#contributing)
- [License](#license)

## Overview

Dotfiles are configuration files (often hidden) used to customize the behavior and appearance of various applications, shells, and utilities on Unix-like operating systems. They typically include settings for command-line tools, text editors, version control systems, window managers, and more.

This repository serves as a centralized location for storing and managing my dotfiles. It allows me to easily synchronize my configurations across different machines and quickly set up my preferred development environment on new systems.

## Usage

Feel free to explore the contents of this repository and adapt any configurations or scripts to suit your needs. You can browse through individual directories to find specific configurations for different tools and applications.

## Structure

- **[shell](shell)**: Contains custom command aliases & functions for convenience.
- **[bash](bash)**: Configurations for the Bash shell.
- **[dotfiles](dotfiles)**: Personal scripts and executable files.
- **[dunst](dunst)**: Configuration for the Dunst notification daemon.
- **[fish](fish)**: Configurations for the Fish shell.
- **[github cli](gh)**: GitHub-related configurations.
- **[git](git)**: Git configurations and aliases.
- **[hypr](hypr)**: Configuration for the Hypr terminal emulator.
- **[neofetch](neofetch)**: Custom configuration for Neofetch.
- **[nvim](nvim)**: Configurations for the Neovim text editor.
- **[obs](obs)**: Configuration for the OBS Studio streaming software.
- **[starship](starship)**: Custom configuration for the Starship prompt.
- **[Thunar](Thunar)**: Customizations for the Thunar file manager.
- **[tmux](tmux)**: Configuration for the Tmux terminal multiplexer.
- **[waybar](waybar)**: Configuration for the Waybar status bar.
- **[wezterm](wezterm)**: Configuration for the WezTerm terminal emulator.
- **[wofi](wofi)**: Configuration for the Wofi application launcher.
- **[zsh](zsh)**: Configurations for the Zsh shell.
- **[CODE_OF_CONDUCT](CODE_OF_CONDUCT.md)**: Code of Conduct for contributing to this repository.
- **[CONTRIBUTING](CONTRIBUTING.md)**: Guidelines for contributing to this repository.
- **[install](install.sh)**: Installation script for deploying dotfiles.
- **[LICENSE](LICENSE.md)**: License information for the contents of this repository.
- **[README](README.md)**: This README file.

## Installation

To install these dotfiles on your system:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/dotfiles.git
   ```
2. Change into the directory:

```bash
cd dotfiles
```

3. Run the installation script:

```bash
    ./install.sh
```

This script will symlink the dotfiles to their appropriate locations in your home directory.

## TODO

- [x] overhaul
- [ ] nushell
   - [ ] aliases in separate file
   - [ ] fix uncommented functions and import them properly

## Contributing

Contributions to improve or expand these dotfiles are welcome! Please refer to the contribution guidelines before submitting any pull requests.

## License

This project is licensed under the MIT License.

