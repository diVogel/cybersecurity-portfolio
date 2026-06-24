# Linux File System

All files and directories in Linux are organized under the root directory **"/"**. Even if data is stored on different physical devices, it is presented as a single directory hierarchy. Some directories are always present, while others may or may not exist depending on the system configuration.

| Directory   | Purpose                                                                 |
| ----------- | ----------------------------------------------------------------------- |
| /           | Root directory containing the entire filesystem hierarchy               |
| /bin, /sbin | Essential system commands and utilities                                 |
| /var        | Variable data such as logs, cache files, and temporary application data |
| /dev        | Virtual device files representing hardware and system devices           |
| /etc        | System and application configuration files                              |

## File Permissions

Every file and directory has permissions that can be modified.

* **r (read)** = 4
* **w (write)** = 2
* **x (execute)** = 1

The command **ls -l** can be used to display additional information about files, including permissions, ownership, and other metadata.

## What Are Configuration Files?

Configuration files are text files that store settings for various system components and applications. They are commonly located in the following directories:

* **/etc/** — the primary directory for system-wide and application configuration files.
* **~/.config/** — directory containing user-specific configuration files.

| Service                         | Path                                                                 |
| ------------------------------- | -------------------------------------------------------------------- |
| Network interface configuration | /etc/network/interfaces<br>/etc/netplan/*.yaml                       |
| Web server configuration        | /etc/httpd/conf/httpd.conf (Apache)<br>/etc/nginx/nginx.conf (Nginx) |
| User and permission management  | /etc/passwd<br>/etc/shadow<br>/etc/group                             |
| Kernel configuration            | /etc/sysctl.conf                                                     |
| SSH configuration               | /etc/ssh/sshd_config                                                 |

Configuration files are typically plain text files and can be edited using text editors such as **nano**, **vim**, or **vi**.

## Examples

### Network Configuration

Changing the IP address in the **/etc/network/interfaces** file:

```bash
auto eth0
iface eth0 inet static
    address 192.168.1.10
    netmask 255.255.255.0
    gateway 192.168.1.1
```

### Web Server Configuration

Changing the document root for a web server in the **/etc/nginx/sites-available/default** file:

```nginx
server {
    listen 80;
    server_name example.com;
    root /var/www/example;
    index index.html;
}
```

After making changes, verify the configuration syntax and restart Nginx.

### System Parameter Configuration

Changing kernel parameters in the **/etc/sysctl.conf** file:

```bash
net.ipv4.ip_forward=1
```

Apply the changes:

```bash
sysctl -p
```

This command reloads the parameters from **/etc/sysctl.conf** without requiring a system reboot.
