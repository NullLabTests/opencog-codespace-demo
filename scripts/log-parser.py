#!/usr/bin/env python3
# CogServer log parser — structured log analysis
# SPDX-License-Identifier: Apache-2.0
# SPDX-FileCopyrightText: 2026 Contributors to OpenCog

import re
import sys
from collections import Counter
from datetime import datetime

def parse_log(path):
    entries = []
    pattern = re.compile(
        r'(?P<timestamp>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})?\s*'
        r'(?P<level>Error|Warning|Info|Debug)?:?\s*'
        r'(?P<message>.*)'
    )
    with open(path) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            m = pattern.match(line)
            if m:
                entries.append(m.groupdict())
    return entries

def main():
    path = sys.argv[1] if len(sys.argv) > 1 else "/tmp/cogserver.log"
    try:
        entries = parse_log(path)
    except FileNotFoundError:
        print(f"Log file not found: {path}")
        sys.exit(1)

    levels = Counter(e["level"] or "Unknown" for e in entries)
    print(f"=== CogServer Log: {path} ===")
    print(f"Total entries:   {len(entries)}")
    print(f"By level:")
    for level, count in levels.most_common():
        print(f"  {level:12s} {count}")
    print(f"First entry:     {entries[0]['timestamp']}" if entries[0]["timestamp"] else "")
    print(f"Last entry:      {entries[-1]['timestamp']}" if entries[-1]["timestamp"] else "")

    errors = [e for e in entries if e["level"] == "Error"]
    if errors:
        print(f"\nErrors ({len(errors)}):")
        for e in errors[:10]:
            print(f"  {e['timestamp']} {e['message'][:120]}")

if __name__ == "__main__":
    main()
