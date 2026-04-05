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

To deploy the NixOS configuration for _quadrat_:

```shell
cd quadrat
nixos-rebuild switch \
    -I nixos-config=quadrat/configuration.nix \
    --build-host julian@192.168.178.118 \
    --target-host julian@192.168.178.118 \
    --sudo \
    --ask-sudo-password
```
