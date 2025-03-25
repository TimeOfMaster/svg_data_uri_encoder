# SVG Data URI Encoder

A command-line tool written in Dart that converts SVG files into Base64-encoded data URIs, making them easy to embed.

## Features

- Reads SVG files from the filesystem
- Converts SVG content to Base64
- Generates complete data URI strings
- Minification options for smaller output
- Clipboard integration
- File output support
- Verbose logging
- SVG validation
- Error handling for common issues

## Installation

1. Ensure you have the [Dart SDK](https://dart.dev/get-dart) installed
2. Clone this repository or download the source code
3. Run `dart pub get` to install dependencies

## Usage

Basic usage:

```bash
dart run bin/svg_data_uri_encoder.dart <path-to-svg-file> [options]
```

Options:

- `-h, --help`: Show help message
- `-m, --minify`: Minify SVG before encoding
- `-c, --clipboard`: Copy result to clipboard
- `-o, --output FILE`: Write output to a file
- `-v, --verbose`: Show detailed processing information
- `--validate`: Validate SVG before encoding

Examples:

```bash
# Basic encoding
dart run bin/svg_data_uri_encoder.dart assets/icon.svg

# Minify and encode
dart run bin/svg_data_uri_encoder.dart assets/icon.svg -m

# Minify, encode and copy to clipboard
dart run bin/svg_data_uri_encoder.dart assets/logo.svg -m -c

# Save result to file with verbose output
dart run bin/svg_data_uri_encoder.dart assets/image.svg -m -o encoded.txt -v
```

### Minification

When using the `-m` or `--minify` option, the tool performs several optimizations:

- Removes comments and unnecessary whitespace
- Optimizes path data
- Removes empty groups and unused attributes
- Shortens color values
- Reduces precision of numbers

This can significantly reduce the output size while maintaining the visual quality.

## Building

To create a standalone executable:

For Windows:

```bash
dart compile exe bin/svg_data_uri_encoder.dart -o svg_encoder.exe
```

For Linux/macOS:

```bash
dart compile exe bin/svg_data_uri_encoder.dart -o svg_encoder
```

## Error Handling

The tool includes error handling for:

- Missing file path argument
- Non-existent files
- Invalid file content
- Clipboard operation failures
- File write permissions
- SVG validation errors

## Requirements

- Dart SDK ^3.7.1
- Compatible with Windows, macOS, and Linux

## License

This project is licensed under the MIT License - see the LICENSE file for details.
