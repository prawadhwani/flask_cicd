#!/bin/sh

# Generate cloud config
cat > "cloud-config.yml" <<EOF
#cloud-config
ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCh9rBOKtvbN2A0eUvLdJwqztoIKCqE+PIsHEFvOHN9dMBinqSMpUvxWH8f82wD1z7Pt7dTspV4x9b2j/RWTtihCjvOZC0gh4oaHxT+QvDfDkSMrCDorxIPpREk2c2wgmi5bslkV74voRtratu7pXKKBgEanBZyXJNQw5lKX53PdZ/TBgu3rGF+3LeBRMZEj0e5593uRCmHh5I0YM0sncU1HGAoG6Y4oBWJT8zq7ZdfM+QNpJx0+LkEbCKDBdHxeWt4Wr0bCVaIKUQWgMTZkKW+dbzkMCcSw0D9pTAr5TTh/bs+SVhrfz2JEGga6onwbqW57UvYnDsKASBV/oNOMoWyF++DpPfUaMgIsRUPrgPVn1E11a+WWKog1wl31OQxQVfurpJEEbAyS0u1XW8Gwu14DfJ9PPaOw6gq0X1hJ9fjHKfzTSjznDCAkRHSY03a29c66oNiqZpX3cU2XjS/yn/HP1+u8OFdc57Q6H6GYNBV09BIqzCXiUFJce0nN1Wcg1Sk3axyau0FzS3svk6lzEyUVpbRO0s6WoluvS14F174K2bOvnsC5XxPNYCiuENxY5ImgW4cGEJdBDkahctBxwieLFuj+7Qf1jw8NQ7pOHKhpFKxFfSCLhDz7x+kH/Xhz9PlQYr4rykLkn7eY275EsdepQksBnbmO2bZsyR1uu0LAQ== prakashwadhwani@Prakashs-MacBook-Air.local
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
