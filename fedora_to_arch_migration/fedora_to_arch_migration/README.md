# Fedora → Arch package migration

This folder was generated from your Fedora installed-package inventory.

## Files
- `fedora-package-names.txt`: 1,776 unique Fedora package names extracted from the 1,981 package entries in the inventory. CPU architectures and Fedora version/repository fields were removed.
- `migrate.py`: checks exact-name matches in Arch's configured official repositories and the AUR.
- `results/`: created when you run the script; contains the match and unmatched lists.

## Run on your Arch Linux installation

1. Copy this whole folder to the Arch machine.
2. Update the system and sync package databases first:
   `sudo pacman -Syu`
3. Run a report first:
   `python3 migrate.py`
4. Review `results/official-matches.txt`, `results/aur-matches.txt`, and `results/unmatched.txt`.
5. Install only official repository exact-name matches:
   `python3 migrate.py --install`
6. If you have `yay` or `paru` installed and have reviewed the AUR list, install both groups:
   `python3 migrate.py --install --include-aur`

## Important limitations / safety

- The script uses exact package-name matches only. Fedora and Arch package names and package splits differ, so `unmatched.txt` is not a list of definitely unavailable software.
- It does not install AUR packages unless you explicitly use `--install --include-aur`.
- Fedora's installed inventory includes dependencies, libraries, firmware, system components, and architecture-specific packages. Installing every match can add a lot of packages and may not recreate Fedora's desktop/system configuration exactly.
- Read AUR build prompts and PKGBUILDs before approving them. The AUR is user-maintained, not an official Arch repository.
- Review all result lists before installing. Consider migrating applications and developer tools first, then add system components only when needed.
