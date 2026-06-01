#!/usr/bin/env python3
# Config validation — checks repo structure and file integrity
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

import os
import sys
import re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
errors = []

def check_exists(path, description):
    full = os.path.join(ROOT, path)
    if not os.path.exists(full):
        errors.append(f"Missing: {description} ({path})")

def check_content(path, pattern, description):
    full = os.path.join(ROOT, path)
    if os.path.exists(full):
        with open(full) as f:
            if not re.search(pattern, f.read()):
                errors.append(f"Missing {description} in {path}")

print("=== Repo Configuration Check ===\n")

# Essential files
check_exists("README.md", "README")
check_exists("LICENSE", "License file")
check_exists("CONTRIBUTING.md", "Contributing guide")
check_exists("CODE_OF_CONDUCT.md", "Code of conduct")
check_exists("SECURITY.md", "Security policy")
check_exists("CHANGELOG.md", "Changelog")
check_exists("Makefile", "Makefile")
check_exists("Dockerfile", "Dockerfile")
check_exists("docker-compose.yml", "Docker Compose config")

# CI
check_exists(".github/workflows/verify.yml", "CI workflow")
check_exists(".github/dependabot.yml", "Dependabot config")
check_exists(".github/workflows/codeql.yml", "CodeQL workflow")

# Content validation
check_content("README.md", r"Concept", "shorthand Atomese examples in README")
check_content("LICENSE", r"Apache", "Apache 2.0 license text")
check_content("CONTRIBUTING.md", r"pull request|PR", "PR instructions")

# Demo scripts
for f in ["demo/comprehensive-demo.scm", "demo/evaluation-demo.scm",
           "demo/truth-values.scm", "demo/values-api.scm"]:
    check_exists(f, f"Demo script: {f}")

# Count demo scripts
demo_count = len([f for f in os.listdir(os.path.join(ROOT, "demo"))
                   if f.endswith(".scm")])
uc_count = len([f for f in os.listdir(os.path.join(ROOT, "demo", "use-cases"))
                if f.endswith(".scm")])

print(f"Root demos:     {demo_count}")
print(f"Use-case demos: {uc_count}")
print(f"Total demos:    {demo_count + uc_count}")

if errors:
    print(f"\n{len(errors)} issues found:")
    for e in errors:
        print(f"  - {e}")
    sys.exit(1)
else:
    print("\nAll checks passed!")
