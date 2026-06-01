#!/usr/bin/env python3
"""cogcli — Command-line interface for OpenCog CogServer.

Usage:
    cogcli scheme '(cog-count-atoms)'
    cogcli count
    cogcli query '(Inheritance (Variable "$x") (Concept "animal"))'
    cogcli eval '(Plus (Number 1) (Number 2))'
    cogcli create '(Concept "hello")'
    cogcli status
    cogcli script path/to/demo.scm
"""

import sys
import json
import socket
import argparse

COGSERVER_HOST = "localhost"
COGSERVER_REPL_PORT = 17001
COGSERVER_WEB_PORT = 18080


def telnet_command(expression, host=COGSERVER_HOST, port=COGSERVER_REPL_PORT, timeout=5):
    """Send a Scheme expression to the CogServer REPL and return the response."""
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(timeout)
    sock.connect((host, port))
    sock.sendall((expression + "\n").encode())
    response = b""
    try:
        while True:
            chunk = sock.recv(4096)
            if not chunk:
                break
            response += chunk
    except socket.timeout:
        pass
    sock.close()
    return response.decode(errors="replace")


def main():
    parser = argparse.ArgumentParser(
        description="CLI for OpenCog CogServer",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    parser.add_argument("--host", default=COGSERVER_HOST, help="CogServer host")
    parser.add_argument("--port", type=int, default=COGSERVER_REPL_PORT, help="REPL port")
    parser.add_argument("--timeout", type=int, default=5, help="Connection timeout (s)")

    sub = parser.add_subparsers(dest="command", required=True)

    p_scheme = sub.add_parser("scheme", help="Run a Scheme expression")
    p_scheme.add_argument("expression", help="Scheme expression to evaluate")

    sub.add_parser("count", help="Count atoms in the atomspace")
    sub.add_parser("status", help="Check CogServer status")

    p_query = sub.add_parser("query", help="Run a GetLink query")
    p_query.add_argument("pattern", help="Query pattern (without (Get ...) wrapper)")

    p_eval = sub.add_parser("eval", help="Evaluate an arithmetic expression")
    p_eval.add_argument("expression", help="Arithmetic expression")

    p_create = sub.add_parser("create", help="Create an atom")
    p_create.add_argument("atom", help="Atom expression (e.g., '(Concept \"x\")')")

    p_script = sub.add_parser("script", help="Run a .scm file")
    p_script.add_argument("path", help="Path to .scm file")

    args = parser.parse_args()

    if args.command == "scheme":
        result = telnet_command(args.expression, args.host, args.port, args.timeout)
        print(result.strip())

    elif args.command == "count":
        result = telnet_command("(cog-count-atoms)", args.host, args.port, args.timeout)
        for line in result.split("\n"):
            line = line.strip()
            if line and not line.startswith("guile") and not line.startswith("opencog"):
                print(line)

    elif args.command == "status":
        try:
            result = telnet_command("(cog-count-atoms)", args.host, args.port, args.timeout)
            if "guile" in result or "opencog" in result:
                print(f"CogServer is running on {args.host}:{args.port}")
                print(f"Web UI: http://{args.host}:{COGSERVER_WEB_PORT}/visualizer/")
            else:
                print("CogServer returned unexpected response.")
        except (ConnectionRefusedError, socket.timeout):
            print(f"ERROR: CogServer is not reachable on {args.host}:{args.port}")
            sys.exit(1)

    elif args.command == "query":
        expr = f"(cog-execute! (Get {args.pattern}))"
        result = telnet_command(expr, args.host, args.port, args.timeout)
        for line in result.split("\n"):
            line = line.strip()
            if line and not line.startswith("guile") and not line.startswith("opencog"):
                print(line)

    elif args.command == "eval":
        result = telnet_command(f"(cog-evaluate! {args.expression})", args.host, args.port, args.timeout)
        for line in result.split("\n"):
            line = line.strip()
            if line and not line.startswith("guile") and not line.startswith("opencog") and not line.startswith("Backtrace"):
                print(line)

    elif args.command == "create":
        result = telnet_command(args.atom, args.host, args.port, args.timeout)
        for line in result.split("\n"):
            line = line.strip()
            if line and not line.startswith("guile") and not line.startswith("opencog"):
                print(line)

    elif args.command == "script":
        try:
            with open(args.path) as f:
                content = f.read()
            result = telnet_command(content, args.host, args.port, args.timeout)
            for line in result.split("\n"):
                line = line.strip()
                if line and not line.startswith("guile") and not line.startswith("opencog"):
                    print(line)
        except FileNotFoundError:
            print(f"ERROR: File not found: {args.path}")
            sys.exit(1)


if __name__ == "__main__":
    main()
