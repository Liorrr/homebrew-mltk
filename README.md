# homebrew-mltk

Homebrew tap for [mltk](https://github.com/Liorrr/mltk) — pytest for ML.

## Install

```bash
brew tap Liorrr/mltk
brew install mltk
```

## Usage

```bash
mltk scan mymodel.pkl --data data.csv
mltk --help
```

## Notes

- Builds the Rust extension from source on first install (requires ~5 min)
- Pre-built bottles are available after the first CI run and speed up subsequent installs
- PyPI install: `pip install mlspec` (the `mltk` PyPI name is pending transfer)
