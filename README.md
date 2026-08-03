# smallyunet Homebrew Tap

[![Homebrew](https://img.shields.io/badge/Homebrew-Tap-FBB040?logo=homebrew&logoColor=black)](https://brew.sh/)
[![Formulae](https://img.shields.io/badge/formulae-2-blue)](#available-formulae)

Homebrew formulae for command-line tools maintained by
[smallyunet](https://github.com/smallyunet). This tap supports both macOS and
Linux environments where [Homebrew](https://brew.sh/) is available.

## Quick start

Install a formula directly without adding the tap first:

```bash
brew install smallyunet/tap/echoevm
```

Alternatively, add the tap once and then install formulae by name:

```bash
brew tap smallyunet/tap
brew install echoevm
```

## Available formulae

| Formula | Description | Project |
| --- | --- | --- |
| `echoevm` | EVM debugger, tracer, differential tester, and replay tool | [smallyunet/echoevm](https://github.com/smallyunet/echoevm) |
| `konachan-downloader` | Multi-threaded downloader for konachan.net with smart updates and resumable downloads | [smallyunet/konachan-downloader](https://github.com/smallyunet/konachan-downloader) |

### EchoEVM

```bash
brew install smallyunet/tap/echoevm
echoevm version
echoevm --help
```

To build the latest development version from the default branch:

```bash
brew install --HEAD smallyunet/tap/echoevm
```

See the [EchoEVM documentation](https://github.com/smallyunet/echoevm#readme)
for bytecode execution, Solidity workflows, tracing, and transaction replay.

### Konachan Downloader

```bash
brew install smallyunet/tap/konachan-downloader
konachan-dl --help
```

For example, use smart mode to look for new images and resume previous progress:

```bash
konachan-dl --tags "hatsune_miku" --smart
```

See the [Konachan Downloader documentation](https://github.com/smallyunet/konachan-downloader#readme)
for tag filters, safe and unsafe modes, custom page ranges, and download behavior.

## Maintenance

Update Homebrew metadata and upgrade packages installed from this tap:

```bash
brew update
brew upgrade echoevm
brew upgrade konachan-downloader
```

Inspect an installed formula or view the tap's status:

```bash
brew info smallyunet/tap/echoevm
brew tap-info smallyunet/tap
```

Uninstall a formula, or remove the tap when it is no longer needed:

```bash
brew uninstall echoevm
brew untap smallyunet/tap
```

## Troubleshooting

If Homebrew is using stale formula metadata, refresh the tap and retry:

```bash
brew update
brew tap --repair
brew reinstall smallyunet/tap/echoevm
```

If a build or installation still fails, run the command again with `--verbose`
and open an issue in the relevant upstream project. For formula-specific or tap
issues, use this repository's
[issue tracker](https://github.com/smallyunet/homebrew-tap/issues).

## Contributing

Formula improvements and fixes are welcome. Before opening a pull request, run:

```bash
brew style ./echoevm.rb ./konachan-downloader.rb
brew audit --strict --online smallyunet/tap/echoevm
brew audit --strict --online smallyunet/tap/konachan-downloader
```

When updating a release, change both the source URL and SHA-256 checksum, then
verify the formula with `brew install --build-from-source` and `brew test`.

## License

Each formula refers to the license of its upstream project. See the linked
project repositories for details.
