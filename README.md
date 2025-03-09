# SVG Data URI Encoder

A command-line tool written in Dart that converts SVG files into Base64-encoded data URIs, making them easy to embed in HTML, CSS, or JavaScript.

## Features

- Reads SVG files from the filesystem
- Converts SVG content to Base64
- Generates complete data URI strings
- Simple command-line interface
- Error handling for common issues

## Installation

1. Ensure you have the [Dart SDK](https://dart.dev/get-dart) installed
2. Clone this repository or download the source code
3. Run `dart pub get` to install dependencies

## Usage

Run the tool from the command line:

```bash
dart run bin/svg_data_uri_encoder.dart <path-to-svg-file>
```

Example:
```bash
dart run bin/svg_data_uri_encoder.dart assets/icon.svg
```

The tool will output a data URI that you can use directly in your code:
```css
background-image: url(data:image/svg+xml;base64,PHN2...);
```

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

## Requirements

- Dart SDK ^3.7.1
- Compatible with Windows, macOS, and Linux

## License

This project is licensed under the MIT License - see the LICENSE file for details.
