# Contributing to the OpenCog AtomSpace Demo Repo

Thank you for your interest! This repository documents a working OpenCog
Classic stack deployment. Contributions that add value for the community
are welcome.

## How to Contribute

### 1. Fix or Improve Documentation

- Typo fixes, clearer explanations, better examples
- New demo scripts showing interesting Atomese patterns
- Missing sections or guides

### 2. Add Demo Scripts

New `.scm` scripts in `demo/use-cases/` are especially valuable. Each
script should:

- Have a clear single purpose (taxonomy, temporal, planning, etc.)
- Include a comment header with usage instructions
- Work when piped through `nc localhost 17001`
- Not depend on atoms created by other scripts

### 3. Report Issues

- **Broken links or images** — file a GitHub issue
- **Scripts that don't work** — include the full error output
- **Missing documentation** — tell us what you needed but couldn't find

### 4. Community Connections

- Add links to OpenCog community resources
- Update CONTRIBUTORS.md with new key contributors
- Share this repo on Discord, Reddit, or other AGI channels

## Pull Request Guidelines

1. **One change per PR** — makes review faster
2. **Keep scripts simple** — each demo should be understandable in 5 minutes
3. **Test your script** — run it: `cat your-script.scm | nc localhost 17001`
4. **Use consistent formatting** — 4-space indentation in Scheme, 80 char lines
5. **Update the README** if you add a new demo or doc (add it to the table)

## Code Standards

- Scheme: prefer `(Concept "name")` shorthand over `(ConceptNode "name")`
- Scheme: use `;` for comments, `;;;` for section headers
- Markdown: wrap code blocks with language tags (` ```scheme `)
- Screenshots: save as PNG, max 1280px width, in `assets/` directory
- Docs: one `docs/*.md` file per topic, link from the README table

## Getting Help

- Open a GitHub issue for repo-specific questions
- Join the [OpenCog Discord](https://discord.gg/vxPc6sz) for broader discussion
- See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues
