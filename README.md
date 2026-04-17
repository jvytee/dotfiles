# dotfiles

Personal collection of configuration files.

## Usage

Clone the repository and link it with GNU stow:

```shell
git clone https://github.com/jvytee/dotfiles.git
cd dotfiles
stow -t ~ home/
```

## Remote deployments

Install NixOS on _hetzner01_ using NixOS Anywhere:

```shell
nix run github:nix-community/nixos-anywhere -- \
  --generate-hardware-config nixos-generate-config ./hardware-configuration.nix \
  --flake .#hetzner01 \
  --target-host root@hochzeit.cloudsal.at
```

Deploy NixOS configuration to _quadrat_:

```shell
cd quadrat
nixos-rebuild switch \
    -I nixos-config=quadrat/configuration.nix \
    --build-host julian@192.168.178.118 \
    --target-host julian@192.168.178.118 \
    --sudo \
    --ask-sudo-password
```

