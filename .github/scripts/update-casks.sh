#!/bin/bash
# Usage: update-casks.sh <user/tap>
# Brings every cask in line with its latest release: a newer version is written together with its
# checksum, and a checksum that no longer matches the download is refreshed. Each change becomes
# one commit in the tap; pushing is left to the caller.
set -euo pipefail

tap=${1:?usage: update-casks.sh <user/tap>}
cd "$(brew --repository "$tap")"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

brew livecheck --cask --tap "$tap" --json | tee "$work/livecheck.json"
if jq -e 'any(.[]; .version.latest == null)' "$work/livecheck.json" >/dev/null; then
  echo "error: livecheck found no version for at least one cask" >&2
  exit 1
fi
jq -r '.[] | [.cask, .version.current, .version.latest, .version.outdated] | @tsv' \
  "$work/livecheck.json" >"$work/casks.tsv"

while IFS=$'\t' read -r cask current latest outdated <&3; do
  if [[ $outdated == true ]]; then
    version=$latest
    message="$cask $latest"
  elif brew fetch --cask --force "$tap/$cask"; then
    continue
  else
    # A release that was built again keeps its version but ships a different file.
    version=$current
    message="$cask: update checksum"
  fi
  brew bump-cask-pr --write-only --no-audit --no-style --version "$version" "$tap/$cask"
  git commit --quiet --message "$message" -- "Casks/$cask.rb"
  echo "Committed: $message"
done 3<"$work/casks.tsv"
