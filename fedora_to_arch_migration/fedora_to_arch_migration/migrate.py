#!/usr/bin/env python3
"""
Find exact-name matches for a Fedora package inventory in Arch official repos and AUR.
Default: report only. Use --install to install matched packages.
Run on Arch Linux from the directory containing this script and fedora-package-names.txt.
"""
import argparse
import json
import shutil
import subprocess
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

HERE = Path(__file__).resolve().parent
INPUT = HERE / "fedora-package-names.txt"
OUT = HERE / "results"
AUR_RPC = "https://aur.archlinux.org/rpc/v5/info"

def read_names():
    if not INPUT.exists():
        sys.exit(f"Missing input file: {INPUT}")
    return sorted({line.strip() for line in INPUT.read_text(encoding="utf-8").splitlines()
                   if line.strip() and not line.lstrip().startswith("#")}, key=str.lower)

def run(cmd, check=True, capture=False):
    return subprocess.run(cmd, check=check, text=True,
                          stdout=subprocess.PIPE if capture else None)

def official_names():
    if not shutil.which("pacman"):
        sys.exit("This script must be run on Arch Linux (pacman was not found).")
    result = run(["pacman", "-Slq"], capture=True)
    return set(result.stdout.split())

def aur_info(names, chunk_size=40):
    """Query AUR info in URL-safe batches; return exact package names returned by AUR."""
    found = set()
    for start in range(0, len(names), chunk_size):
        chunk = names[start:start + chunk_size]
        query = urllib.parse.urlencode([("arg[]", n) for n in chunk])
        url = AUR_RPC + "?" + query
        req = urllib.request.Request(url, headers={"User-Agent": "fedora-to-arch-package-migrator/1.0"})
        try:
            with urllib.request.urlopen(req, timeout=30) as response:
                payload = json.load(response)
            if payload.get("type") == "success":
                found.update(item["Name"] for item in payload.get("results", []))
        except Exception as exc:
            print(f"WARNING: AUR lookup batch {start + 1}-{start + len(chunk)} failed: {exc}",
                  file=sys.stderr)
            print("Some AUR matches may be missing. Re-run later to retry.", file=sys.stderr)
        time.sleep(0.15)
    return found

def write_list(path, values):
    path.write_text("".join(f"{v}\n" for v in sorted(values, key=str.lower)), encoding="utf-8")

def main():
    parser = argparse.ArgumentParser(description="Map Fedora package names to Arch and optionally install exact-name matches.")
    parser.add_argument("--install", action="store_true", help="install matched official packages and AUR packages")
    parser.add_argument("--include-aur", action="store_true", help="with --install, include exact-name AUR matches")
    args = parser.parse_args()

    if args.include_aur and not args.install:
        parser.error("--include-aur only has an effect with --install")

    source = read_names()
    print(f"Loaded {len(source)} unique Fedora package names.")
    print("Reading local Arch repository package databases (make sure they are current)...")
    official = official_names()
    official_matches = set(source) & official
    remaining = sorted(set(source) - official_matches, key=str.lower)

    print(f"Checking {len(remaining)} remaining names against the AUR...")
    aur = aur_info(remaining)
    aur_matches = (set(remaining) & aur) - official_matches
    unmatched = set(source) - official_matches - aur_matches

    OUT.mkdir(exist_ok=True)
    write_list(OUT / "official-matches.txt", official_matches)
    write_list(OUT / "aur-matches.txt", aur_matches)
    write_list(OUT / "unmatched.txt", unmatched)
    write_list(OUT / "all-exact-matches.txt", official_matches | aur_matches)

    print("\nResults")
    print(f"  Official repository exact-name matches: {len(official_matches)}")
    print(f"  AUR exact-name matches:                 {len(aur_matches)}")
    print(f"  No exact-name match found:              {len(unmatched)}")
    print(f"\nLists saved in: {OUT}")
    print("NOTE: unmatched means no exact name found, not necessarily that the software is unavailable.")
    print("Names can differ between Fedora and Arch; review unmatched.txt and add known equivalents manually.")

    if not args.install:
        print("\nDry run only. Review the result lists, then run with --install.")
        return

    if not official_matches and not (args.include_aur and aur_matches):
        print("No packages selected for installation.")
        return

    if official_matches:
        print("\nInstalling official repository matches...")
        run(["sudo", "pacman", "-S", "--needed", *sorted(official_matches)])

    if args.include_aur and aur_matches:
        helper = shutil.which("yay") or shutil.which("paru")
        if not helper:
            sys.exit("\nAUR packages were requested, but neither yay nor paru is installed. "
                     "Install an AUR helper first, then rerun with --install --include-aur.")
        print(f"\nInstalling AUR exact-name matches using {Path(helper).name}...")
        run([helper, "-S", "--needed", *sorted(aur_matches)])

    print("\nDone. Review any package build prompts carefully.")

if __name__ == "__main__":
    main()
