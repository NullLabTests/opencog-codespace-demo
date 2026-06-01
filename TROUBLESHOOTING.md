# Troubleshooting

## CogServer won't start

**Check if ports are in use:**
```bash
sudo lsof -i :17001 -i :18080 -i :18888
```

**Check the log:**
```bash
cat /tmp/cogserver.log
```

**Try killing and restarting:**
```bash
pkill cogserver && sleep 1 && ./start-cogserver.sh
```

## Can't connect to the REPL

**Telnet:**
```bash
telnet localhost 17001
```
If `telnet: unable to connect`, the CogServer isn't running.
Start it with `./start-cogserver.sh`.

**WebSocket:**
Open `http://localhost:18080/websockets/demo.html`.
If the page doesn't load, the web server isn't running on port 18080.

## WebSocket connection fails in browser

If you're accessing the visualizer over HTTPS (e.g., behind a proxy),
the WebSocket URL must use `wss://` instead of `ws://`. The visualizer
auto-detects this, but if you see WebSocket errors:

1. Open browser developer tools (F12)
2. Check the Console tab for WebSocket errors
3. Ensure the WebSocket URL starts with `wss://` for HTTPS pages

## Scheme expressions error when piped

**Problem:**
```bash
cat script.scm | nc localhost 17001
```
Shows errors like `ERROR: Unbound variable` or `Backtrace:`.

**Fix:**
Use single-line expressions instead of multi-line. The `nc` pipe can
mangle multi-line Scheme. Alternatively, paste expressions one at a time
into the WebSocket Shell.

## Atom count shows 0

```
(cog-count-atoms 'ConceptNode)
→ 0
```

Even when ConceptNodes exist. Use the unfiltered count instead:
```scheme
(cog-count-atoms)
```

Or count specific types by name:
```scheme
(cog-count-nodes)
```

## `cog-evaluate!` returns errors

```
(cog-evaluate! (Plus (Number 1) (Number 2)))
→ ERROR: Unbound variable: cog-evaluate!
```

The AtomSpace must be built with `-DHAVE_GUILE` for `cog-evaluate!` to
work. Verify with:
```scheme
,describe cog-evaluate!
```

If it's missing, rebuild atomspace with the flag enabled.

## Visualizer shows "Disconnected"

1. Ensure the CogServer is running
2. Click **Connect** on the visualizer page
3. Check that the WebSocket URL is correct (defaults to `ws://localhost:18080/`)
4. If using HTTPS, the URL will automatically switch to `wss://`

## Docker build fails

**Problem:** `docker build` fails during apt-get or cmake.

**Fix:**
```bash
docker build --no-cache -t opencog-demo .
```

Or try with more memory:
```bash
docker build --memory=8g -t opencog-demo .
```

## Git push fails with 403

```
remote: Permission denied
fatal: unable to access 'https://github.com/...'
```

The `GITHUB_TOKEN` env var may not have `repo` scope. Use a personal
access token (classic, with `repo` scope) instead:

```bash
git remote set-url origin https://<token>@github.com/user/repo.git
```

## Port already in use

```bash
# Find what's using the port
sudo lsof -i :17001

# Kill the process
sudo kill <PID>

# Or use fuser
sudo fuser -k 17001/tcp
```
