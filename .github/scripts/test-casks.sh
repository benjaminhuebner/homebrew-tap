#!/bin/bash
# Usage: test-casks.sh <user/tap>
# Checks the tap's style, then audits each cask and installs it once before removing it again.
# For CI runners only: removing a cask here also deletes the app's settings and data.
set -euo pipefail

tap=${1:?usage: test-casks.sh <user/tap>}
if [[ -z ${CI:-} ]]; then
  echo "error: this installs and zaps every cask; run it on a CI runner" >&2
  exit 1
fi

# In developer mode Homebrew stops on deprecated cask syntax, which the audit otherwise passes
# without a word until the next release turns it into an error for everyone.
export HOMEBREW_DEVELOPER=1

brew style "$tap"
for file in "$(brew --repository "$tap")"/Casks/*.rb; do
  cask=$tap/$(basename "$file" .rb)
  brew audit --cask --strict --online "$cask"
  brew install --cask "$cask"
  brew uninstall --cask --zap "$cask"
done
