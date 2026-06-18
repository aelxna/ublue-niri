#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Enable repositories
echo "Setting up Terra repository..."
if ! dnf5 repolist --all | grep -q '^terra '; then
  echo "Installing Terra repository..."
  curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo -o /etc/yum.repos.d/terra.repo
  dnf5 install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release || true
fi

echo "Enabling Terra repository..."
dnf5 config-manager setopt terra.enabled=1

# Fingerprint sensor driver for Dell XPS 13 9310 and similar devices
dnf5 -y copr enable manciukic/libfprint-tod-goodix

### Remove gnome-shell
dnf5 remove -y gnome-shell gnome-session-wayland-session gnome-software

### Install packages
echo "Installing programs..."
dnf5 install -y --skip-unavailable --skip-broken \
  niri \
  waybar \
  swaybg \
  SwayNotificationCenter \
  swayidle \
  hyprlock \
  wofi \
  xdg-desktop-portal-gtk \
  darkman \
  kde-connect \
  zsh \
  fish \
  ripgrep \
  fd-find \
  bat \
  direnv \
  zoxide \
  dua-cli \
  neovim \
  eza \
  fzf \
  yazi \
  tmux \
  git \
  wget \
  curl \
  btop \
  zed \
  starship \
  ghostty \
  tailscale \
  podman-compose \
  distrobox \
  python3 \
  @c-development \
  @development-tools \
  @virtualization \
  rust \
  cargo \
  cmake \
  clang \

dnf5 -y swap libfprint libfprint-tod-goodix

# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable manciukic/libfprint-tod-goodix

#### Example for enabling a System Unit File

systemctl enable podman.socket
