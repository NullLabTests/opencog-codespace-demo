# Backup and Restore

Back up your AtomSpace data for persistence across restarts.

## Backup Methods

### Method 1: RocksDB Persistence

Enable RocksDB storage and back up the data directory:

```scheme
;; In the REPL, set up RocksDB storage
(use-modules (opencog storage rocks))
(cog-create-storage! (RocksStorageNode "rocks:///tmp/atomspace-data/"))
(cog-storage-open! (RocksStorageNode "rocks:///tmp/atomspace-data/"))
(cog-storage-store! (RocksStorageNode "rocks:///tmp/atomspace-data/"))
```

Back up the data directory:
```bash
tar -czf cogserver-backup-$(date +%Y%m%d).tar.gz /tmp/atomspace-data/
```

### Method 2: Scheme Dump

Dump all atoms as portable Scheme expressions:

```bash
echo '(map cog-prt-atom (cog-atomspace))' | nc localhost 17001 > atomspace-dump.scm
```

Restore:
```bash
cat atomspace-dump.scm | nc localhost 17001
```

### Method 3: Python Export Script

```python
import asyncio, json, websockets

async def export_atoms():
    uri = "ws://localhost:18080/json"
    async with websockets.connect(uri) as ws:
        await ws.send(json.dumps({
            "command": "scheme",
            "body": "(map cog-prt-atom (cog-atomspace))"
        }))
        resp = await ws.recv()
        with open("atomspace-export.scm", "w") as f:
            f.write(json.loads(resp).get("result", ""))

asyncio.run(export_atoms())
```

## Automation

Add to cron for daily backups:

```cron
0 2 * * * tar -czf /backups/cogserver-$(date +\%Y\%m\%d).tar.gz /tmp/atomspace-data/
```

## Docker Backup

```bash
# Backup the CogServer data volume
docker run --rm -v cogserver-data:/data -v $(pwd):/backup ubuntu \
    tar -czf /backup/cogserver-data-$(date +%Y%m%d).tar.gz /data
```

## Restore

```bash
# RocksDB
tar -xzf cogserver-backup-20260601.tar.gz
sudo cp -r tmp/atomspace-data/* /tmp/atomspace-data/

# Scheme dump
cat atomspace-dump.scm | nc localhost 17001
```

## Best Practices

- Automate daily backups
- Store backups off-system (S3, SCP, NAS)
- Test restore procedure regularly
- Keep last 30 days of backups
