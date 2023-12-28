#!/bin/bash


install_packages() {

  pacman_packages=(
    alacritty
    amd-ucode
    base
    base-devel
    docker
    docker-compose
    go
    htop
    less
    libva-utils
    linux-zen
    pacman-contrib
    pavucontrol
    scrot
    tree
    ttf-dejavu
    unrar
    unzip
    xclip
    xf86-video-amdgpu
    xorg-server
    xorg-xinit
    xorg-xinput
    xorg-xkill
    xorg-xsetroot
    zram-generator
    zsh
  )

  aur_packages=(
    postman-bin
    vscodium-bin
    ungoogled-chromium-bin
  )

    sudo pacman -S "${pacman_packages[@]}"
    sudo aura -A "${aur_packages[@]}"
}

install_aura() {
    git clone https://aur.archlinux.org/aura-bin.git
    cd aura-bin
    makepkg -si
    rm -rf aura-bin
}

move_config() {
    local source_dir="$(pwd)"
    
    cp -rv "${source_dir}/.config" ~/
    cp -v "${source_dir}/.xinitrc" ~/
    cp -v "${source_dir}/.Xresources" ~/
    cp -v "${source_dir}/.zshenv" ~/ 
}

install_suckless() {
  local source_dir="$HOME/.config"

  suckless_components=("dwm" "dmenu" "tabbed")

  for component in "${suckless_components[@]}"; do
      cd "${source_dir}/${component}" || exit 1

      sudo make clean install > /dev/null 2>&1
      echo "${component} installed"
  done
}

post_installation() {
  chsh -s $(which zsh)
  sudo chmod +s /usr/bin/poweroff && sudo chmod +s /usr/bin/reboot
}

install_packages
install_aura
move_config
install_suckless
post_installation
