#!/bin/bash
# Install Git hooks for this repository
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

HOOKS_DIR=".git/hooks"

echo "=== Installing Git Hooks ==="

# Pre-commit hook: check for trailing whitespace
cat > "$HOOKS_DIR/pre-commit" << 'EOF'
#!/bin/bash
echo "Running pre-commit checks..."
if grep -rnI '\s\+$' --include='*.scm' --include='*.py' --include='*.md' . 2>/dev/null | grep -v '.git/' | grep -v 'assets/'; then
    echo "WARNING: Trailing whitespace found in files above."
    echo "Run: sed -i 's/[[:space:]]*$//' <file>"
fi
EOF
chmod +x "$HOOKS_DIR/pre-commit"
echo "  Installed pre-commit hook"

# Post-merge hook: check for new hooks
cat > "$HOOKS_DIR/post-merge" << 'EOF'
#!/bin/bash
echo "Post-merge: checking for updated hooks..."
current_dir=$(dirname "$0")
hooks_dir=$(dirname "$current_dir")
if [ -f "$hooks_dir/.pre-commit-config.yaml" ]; then
    echo "  pre-commit config available — run 'pre-commit install' to update hooks"
fi
EOF
chmod +x "$HOOKS_DIR/post-merge"
echo "  Installed post-merge hook"

echo ""
echo "Hooks installed successfully."
echo "To use pre-commit properly: pip install pre-commit && pre-commit install"
