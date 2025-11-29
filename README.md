# clipog
Simple Bash scripts to send the content of my clipboard in macOS to my Omarchy Linux

## Installation and configuration

1. Make sure that the packages `avahi`, `nss-mdns` and `openssh` are installed in _Omarchy_.
```bash
sudo pacman -Syu avahi nss-mdns openssh
```

2. (Optional) Set a hostname in the _Omarchy_ computer:
```bash
sudo hostnamectl set-hostname omarchy
```

3. Configure your SSH public key and (optional) set your `authorized_keys` file to login directly.

4. Include the file `hypr-env-ssh` in your `~/.bashrc` file in the _Omarchy_ laptop.

5. Call the script.