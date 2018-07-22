#!/bin/sh

# Generate cloud config
cat > "cloud-config.yml" <<EOF
#cloud-config
ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCh9rBOKtvbN2A0eUvLdJwqztoIKCqE+PIsHEFvOHN9dMBinqSMpUvxWH8f82wD1z7Pt7dTspV4x9b2j/RWTtihCjvOZC0gh4oaHxT+QvDfDkSMrCDorxIPpREk2c2wgmi5bslkV74voRtratu7pXKKBgEanBZyXJNQw5lKX53PdZ/TBgu3rGF+3LeBRMZEj0e559#redacted key
write_files:
  - path: /etc/ssh/sshd_config
    permissions: "0600"
    owner: root:root
    content: |
      AuthorizedKeysFile .ssh/authorized_keys
      ClientAliveInterval 180
      Subsystem	sftp /usr/libexec/sftp-server
      UseDNS no
      PermitRootLogin no
      ServerKeyBits 2048
      AllowGroups docker
rancher:
  network:
    dns:
      override: true
      nameservers:
        - 8.8.8.8
        - 8.8.4.4
    interfaces:
      eth0:
        dhcp: true
  state:
    dev: LABEL=RANCHER_STATE
    fstype: auto
    autoformat:
      - /dev/vda
  services_include:
    centos-console: true
EOF

# Install RancherOS to disk, then reboot
sudo ros install --no-reboot -f -t generic -c cloud-config.yml -d /dev/vda
sudo reboot