# Homebrew tap

[Homebrew](https://brew.sh) casks for my macOS apps.

| Cask | App | Requires |
| --- | --- | --- |
| [`smuggler`](Casks/smuggler.rb) | [Smuggler](https://smuggler.benjaminhuebner.com) frees downloaded files from macOS quarantine. | macOS 26 |

## Install

```sh
brew install --cask benjaminhuebner/tap/smuggler
```

That one command adds the tap and installs the app. Homebrew only loads casks from a third-party tap once you trust them, and installing by the full name trusts exactly this cask and nothing else in the tap.

To use the short name instead, add the tap and trust the cask yourself:

```sh
brew tap benjaminhuebner/tap
brew trust --cask benjaminhuebner/tap/smuggler
brew install --cask smuggler
```

## Update

The apps update themselves, so `brew upgrade` leaves them alone. To have Homebrew update one anyway:

```sh
brew upgrade --greedy smuggler
```

The casks here follow the releases on their own: every new release of an app updates its cask.

## Uninstall

```sh
brew uninstall --cask smuggler
```

Add `--zap` to remove the app's settings and data as well.

## Problems

If an app does not install through Homebrew, [open an issue](https://github.com/benjaminhuebner/homebrew-tap/issues) here. Bugs in an app itself belong in its own repository.
