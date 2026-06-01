# Docker Deployment Guide

Deploy the OpenCog CogServer using Docker in various configurations.

## Quick Start

```bash
docker compose up -d
telnet localhost 17001
curl http://localhost:18080/stats
```

## Images

### Build Locally

```bash
docker build -t opencog-demo .
docker compose up -d
```

### Pull Pre-built (GHCR)

```bash
docker pull ghcr.io/NullLabTests/opencog-codespace-demo:latest
```

## Profiles

### Development Profile

Hot-reloads local scripts:

```bash
docker compose -f docker-compose.dev.yml up -d
```

### Production Profile

Full persistence with health checks:

```bash
docker compose -f docker-compose.prod.yml up -d
```

### Test Profile

Run the integration test suite:

```bash
docker compose -f docker-compose.dev.yml --profile test up --abort-on-container-exit
```

## Custom Configuration

### Environment Variables

| Variable | Default | Description |
|---|---|---|
| `COGSERVER_REPL_PORT` | `17001` | Telnet REPL port |
| `COGSERVER_WEB_PORT` | `18080` | Web/WebSocket port |
| `COGSERVER_MCP_PORT` | `18888` | MCP port |
| `COGSERVER_BIN` | `/usr/local/bin/cogserver` | CogServer binary path |
| `COGSERVER_LOG_LEVEL` | `info` | Log verbosity |

### Persistent Storage

```yaml
volumes:
  cogserver-data:/tmp/atomspace-data
```

Back up the volume:
```bash
docker run --rm -v cogserver-data:/data -v $(pwd):/backup ubuntu \
    tar -czf /backup/cogserver-data.tar.gz /data
```

## Troubleshooting

### Container won't start

```bash
docker logs opencog-cogserver
docker compose down && docker compose up -d
```

### Port conflict

```bash
# Check what's using the port
sudo lsof -i :17001
# Change port in docker-compose.yml
```

### Permission issues

```bash
# Ensure data directory is writable
chmod 777 /tmp/atomspace-data
```
