# Clipboard Integration

The SVG Data URI Encoder provides clipboard support for easy copying of encoded SVGs.

## Platform Support

### Windows

Uses the `clip` command for clipboard operations.

### macOS

Uses the `pbcopy` command for clipboard operations.

### Linux

Requires `xclip` or `xsel` to be installed:

```bash
# Ubuntu/Debian
sudo apt-get install xclip

# Fedora
sudo dnf install xclip
```

## Usage

```bash
# Copy encoded SVG to clipboard
dart run bin/svg_data_uri_encoder.dart icon.svg -c

# Combine with minification
dart run bin/svg_data_uri_encoder.dart icon.svg -m -c
```

## Error Handling

The tool will gracefully handle clipboard failures and:

- Display an error message
- Continue execution
- Write output to stdout
