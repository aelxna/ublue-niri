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

### Install packages
echo "Installing programs..."
dnf5 install -y --skip-unavailable --skip-broken \
  gdm \
  niri \
  waybar \
  swaybg \
  adw-gtk3-theme \
  SwayNotificationCenter \
  swayidle \
  swayosd \
  fuzzel \
  cliphist \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome \
  xwayland-satellite \
  polkit-kde \
  gnome-keyring \
  gnome-keyring-pam \
  seahorse \
  wireplumber \
  pipewire-pulse \
  brightnessctl \
  udiskie \
  darkman \
  dbus-daemon \
  kde-connect \
  gvfs-goa \
  gvfs-mtp \
  gnome-online-accounts \
  evolution-data-server \
  evolution-alarm-notify \
  blueman \
  fprintd \
  fprintd-pam \
  gnome-control-center \
  gnome-tweaks \
  nautilus \
  playerctl \
  wl-clipboard \
  fuse \
  fuse-libs \
  fuse-common \
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
  rustup \
  cmake \
  clang-tools-extra \

dnf5 -y swap libfprint libfprint-tod-goodix
dnf5 -y swap swaylock swaylock-effects

# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable manciukic/libfprint-tod-goodix

#### Example for enabling a System Unit File

systemctl enable podman.socket
