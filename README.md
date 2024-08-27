# Dotfiles Configuration for `.zshrc` and `i3blocks` on EndeavourOS

This repository contains my custom configurations for the Z shell (`.zshrc`) and the `i3blocks` status bar, along with associated scripts, tailored for use on [EndeavourOS](https://endeavouros.com/).

## Table of Contents

- [Dotfiles Configuration for `.zshrc` and `i3blocks` on EndeavourOS](#dotfiles-configuration-for-zshrc-and-i3blocks-on-endeavouros)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Installation](#installation)
  - [Configuration Details](#configuration-details)
    - [Zsh Configuration (`.zshrc`)](#zsh-configuration-zshrc)
    - [i3blocks Configuration](#i3blocks-configuration)
    - [EndeavourOS Specifics](#endeavouros-specifics)
  - [Custom Scripts](#custom-scripts)
    - [Usage](#usage)
  - [License](#license)
  - [Remember](#remember)

## Introduction

This repository includes:

- A customized `.zshrc` file for an enhanced Zsh shell experience.
- Configuration files for `i3blocks` to create a personalized and informative status bar.
- Shell scripts used by `i3blocks` to display system information.

These configurations are specifically optimized for use on [EndeavourOS](https://endeavouros.com/), a lightweight and flexible Arch-based Linux distribution.

## Installation

To use these configurations on EndeavourOS, follow these steps:

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   ```

2. **Backup Existing Configurations:**

   Before replacing your current configuration files, make sure to back them up:

   ```bash
   cp ~/.zshrc ~/.zshrc.backup
   cp ~/.config/i3blocks/config ~/.config/i3blocks/config.backup
   ```

3. **Symlink the Configuration Files:**

   Link the configuration files to their respective locations:

   ```bash
   ln -sf ~/dotfiles/.zshrc ~/.zshrc
   ln -sf ~/dotfiles/i3blocks/config ~/.config/i3blocks/config
   ```

4. **Reload the Configurations:**

   To apply the changes, either restart your session or source the configuration files:

   ```bash
   source ~/.zshrc
   pkill -SIGUSR1 i3blocks
   ```

## Configuration Details

### Zsh Configuration (`.zshrc`)

My `.zshrc` configuration includes:

- **Aliases:** Handy shortcuts for frequently used commands.
- **Prompt Customization:** A colorful and informative prompt using `oh-my-zsh` with custom themes and plugins.
- **Environment Variables:** Custom paths, editor settings, and other environment variables.
- **Plugins:** Additional functionality via plugins such as `zsh-autosuggestions` and `zsh-syntax-highlighting`.

### i3blocks Configuration

The `i3blocks` configuration file (`config`) is designed to display useful system information on the status bar, including:

- **CPU Usage:** Displays real-time CPU load.
- **Memory Usage:** Shows the current memory utilization.
- **Local Network Status:** Displays the local IP and network status.
- **Network Status:** Displays the IP and network status.
- **Date & Time:** A centrally aligned clock with date information.

Each block is highly customizable, with options to adjust colors, icons, and update intervals.

### EndeavourOS Specifics

These configurations have been tested and optimized for EndeavourOS. They take advantage of the specific package versions and system behavior typical of this distribution.

## Custom Scripts

The repository includes several shell scripts used by `i3blocks` to fetch and display system information. These scripts are located in the `scripts/` directory and include:

- **cpu_usage:** A script to monitor CPU load.
- **memory:** Displays current memory usage.
- **local_ip:** Fetches the local IP address and connection status.
- **ip_and_flag:** Fetches the global IP address your the country your ip belongs to.

### Usage

These scripts are called by `i3blocks` at regular intervals to update the status bar. You can modify them to fit your specific needs.

## License

This repository is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html). See the `LICENSE` file for more details.

## Remember

- **fonts:** install FontAwesome to handle icons.
- **adding new scripts:** please remember when you are creating new script use chmod +x ./scripts/[scriptName] for i3blocks to be able to run it
