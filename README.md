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

- **shell**: Contains custom command aliases & functions for convenience.
- **bash**: Configurations for the Bash shell.
- **bin**: Personal scripts and executable files.
- **dunst**: Configuration for the Dunst notification daemon.
- **fish**: Configurations for the Fish shell.
- **gh**: GitHub-related configurations.
- **git**: Git configurations and aliases.
- **hypr**: Configuration for the Hypr terminal emulator.
- **neofetch**: Custom configuration for Neofetch.
- **nvim**: Configurations for the Neovim text editor.
- **obs**: Configuration for the OBS Studio streaming software.
- **starship**: Custom configuration for the Starship prompt.
- **Thunar**: Customizations for the Thunar file manager.
- **tmux**: Configuration for the Tmux terminal multiplexer.
- **waybar**: Configuration for the Waybar status bar.
- **wezterm**: Configuration for the WezTerm terminal emulator.
- **wofi**: Configuration for the Wofi application launcher.
- **zsh**: Configurations for the Zsh shell.
- **CODE_OF_CONDUCT.md**: Code of Conduct for contributing to this repository.
- **CONTRIBUTING.md**: Guidelines for contributing to this repository.
- **install.sh**: Installation script for deploying dotfiles.
- **LICENSE.md**: License information for the contents of this repository.
- **README.md**: This README file.

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

- [ ] overhaul
   - [ ] wofi-wifi.sh

## Contributing

Contributions to improve or expand these dotfiles are welcome! Please refer to the contribution guidelines before submitting any pull requests.

## License

This project is licensed under the MIT License.

