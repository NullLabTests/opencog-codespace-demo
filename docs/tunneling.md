# Remote Access & Tunneling

Access your CogServer from another machine using SSH tunneling or SOCKS
proxy. All localhost-bound ports become reachable remotely.

## SSH Local Port Forwarding

Forward a remote CogServer to your local machine:

```bash
ssh -L 17001:localhost:17001 \
     -L 18080:localhost:18080 \
     -L 18888:localhost:18888 \
     user@remote-host
```

Then connect `telnet localhost 17001` or open `http://localhost:18080/`
as if the CogServer were running locally.

## SSH Dynamic SOCKS Proxy

Create a SOCKS5 tunnel for all ports:

```bash
ssh -D 1080 user@remote-host
```

Configure your browser to use SOCKS5 proxy `localhost:1080`, then
navigate to `http://remote-host:18080/visualizer/`.

## SSH Config Shortcut

Add to `~/.ssh/config` for quick access:

```
Host cogserver
    HostName remote-host
    User user
    LocalForward 17001 localhost:17001
    LocalForward 18080 localhost:18080
    LocalForward 18888 localhost:18888
```

Then: `ssh cogserver`

## Security Notes

- These tunnels are **not encrypted end-to-end** beyond the SSH link
- For production, use WireGuard, Tailscale, or Cloudflare Tunnel
- The CogServer has no built-in auth — restrict SSH access to trusted users
