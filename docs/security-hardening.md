# Security Hardening Guide

Guidelines for running the CogServer securely in production-adjacent
environments.

## Network Security

### Bind to Localhost Only

For single-user or LAN setups, bind all ports to localhost:

```bash
cogserver -p 127.0.0.1:17001 -w 127.0.0.1:18080 -m 127.0.0.1:18888
```

Or in Docker, omit port publishing:
```yaml
ports:
  - "127.0.0.1:17001:17001"
```

### Use a Reverse Proxy for TLS

The CogServer has no built-in TLS. Use nginx or Caddy for HTTPS and WSS:

```nginx
server {
    listen 443 ssl;
    server_name cogserver.example.com;

    ssl_certificate /etc/letsencrypt/live/.../fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/.../privkey.pem;

    location / {
        proxy_pass http://127.0.0.1:18080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

### Firewall Rules

```bash
# Allow only specific sources
sudo ufw allow from 192.168.1.0/24 to any port 17001
sudo ufw allow from 192.168.1.0/24 to any port 18080
sudo ufw deny 17001
sudo ufw deny 18080
```

## Authentication

The CogServer has **no built-in authentication**. All connections have
full read/write access. Mitigations:

1. **Bind to localhost** — restrict to local connections
2. **SSH tunnel** — require SSH for remote access
3. **Reverse proxy auth** — add HTTP basic auth or OAuth at the proxy level
4. **Docker network** — use an internal Docker network with no port exposure

## Data Protection

### Persistence Encryption

If using RocksDB storage, encrypt the data directory:

```bash
# LUKS encrypted volume
sudo cryptsetup luksFormat /dev/sdX
sudo cryptsetup open /dev/sdX cogserver-data
sudo mkfs.ext4 /dev/mapper/cogserver-data
sudo mount /dev/mapper/cogserver-data /var/lib/cogserver
```

### Secrets

- Never commit `.env` files — they are in `.gitignore`
- Use environment variables or Docker secrets for sensitive values
- Rotate API keys and tokens regularly

## Monitoring

### Logging

Enable debug logging for intrusion detection:

```bash
cogserver -p 17001 -w 18080 --log-level=debug
```

### File Integrity

Monitor critical files:

```bash
# Track all files in the cogserver installation
sudo find /usr/local/bin/cogserver -type f -exec sha256sum {} \; > /var/log/cogserver-baseline.txt
```

## Docker Security

```yaml
services:
  cogserver:
    security_opt:
      - no-new-privileges:true
    read_only: true
    tmpfs:
      - /tmp
    cap_drop:
      - ALL
    cap_add:
      - NET_BIND_SERVICE
```
