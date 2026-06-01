# Security Policy

## Supported Versions

This repository is documentation and demo scripts for the OpenCog AtomSpace.
It does not contain production server code. Security issues should be reported
to the upstream OpenCog project for the affected component.

| Component | Supported |
|---|---|
| This repo (docs, scripts) | ✅ |
| OpenCog AtomSpace | ✅ (upstream) |
| OpenCog CogServer | ✅ (upstream) |
| OpenCog cogutil | ✅ (upstream) |

## Reporting a Vulnerability

**Do not open a public GitHub issue** for security vulnerabilities.

Instead, contact the OpenCog maintainers directly:

- **Linas Vepstas** — linasvepstas@gmail.com (AtomSpace, CogServer, cogutil)
- For this repository: open an issue with the label `security`

You should receive a response within 48 hours. If not, follow up via Discord.

## Scope

- This repo: documentation typos, broken links, incorrect setup instructions
- Upstream: code vulnerabilities in atomspace, cogserver, cogutil, or
  their dependencies (Guile, Boost, RocksDB, etc.)

## Preferred Reporting Process

1. Describe the vulnerability in detail
2. Include steps to reproduce
3. Suggest a fix if possible
4. Do not share the vulnerability publicly until it is resolved
