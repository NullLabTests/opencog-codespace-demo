# Support

## Getting Help

- **Documentation:** See [docs/](docs/) for guides and references
- **Discord:** [OpenCog Community](https://discord.gg/vxPc6sz) — fastest response
- **GitHub Issues:** [Open an issue](https://github.com/NullLabTests/opencog-codespace-demo/issues) for bugs and feature requests
- **Stack Overflow:** Tag questions with `opencog` and `atomspace`

## Common Issues

| Issue | Solution |
|---|---|
| `Connection refused` on port 17001 | CogServer is not running — `make start` or `docker compose up -d` |
| `AtomSpace not found` in REPL | Run `(use-modules (opencog))` first |
| Visualizer shows blank page | Check browser console for WebSocket errors; ensure port 18080 is reachable |
| `Scheme shell not loaded` | Restart CogServer with `-p 17001 -w 18080` flags |

## Reporting a Bug

1. Check [FAQ](docs/faq.md) and [Troubleshooting](TROUBLESHOOTING.md)
2. Search [existing issues](https://github.com/NullLabTests/opencog-codespace-demo/issues)
3. If still unresolved, [open a new issue](https://github.com/NullLabTests/opencog-codespace-demo/issues/new/choose)
   with:
   - CogServer version (`cogserver --version` or commit hash)
   - Steps to reproduce
   - Full error output
   - Log file (`/tmp/cogserver.log`)

## Upstream Support

For issues with the OpenCog libraries themselves (not this demo):
- [OpenCog GitHub](https://github.com/opencog)
- [OpenCog Wiki](https://wiki.opencog.org)
- [OpenCog Discord](https://discord.gg/vxPc6sz)
