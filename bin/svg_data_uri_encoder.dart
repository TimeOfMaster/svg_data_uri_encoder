import 'dart:io';
import 'package:svg_data_uri_encoder/src/svg_data_uri_encoder.dart';
import 'package:svg_data_uri_encoder/src/clipboard.dart';

/// Prints usage information for the SVG Data URI Encoder tool.
///
/// Displays available command-line options and arguments, including:
/// - File path argument for the SVG file to encode
/// - Help options (-h, --help)
/// - Minification options (-m, --minify) for reducing SVG file size
/// - Clipboard options (-c, --clipboard)
/// - Output file options (-o, --output)
/// - Verbose mode (-v, --verbose)
/// - Validation option (--validate)
void printUsage() {
  print('''
SVG Data URI Encoder

Usage: 
  dart encode_svg.dart <path-to-svg-file> [options]
  dart encode_svg.dart [-h|--help]

Arguments:
  <path-to-svg-file>    Path to the SVG file to encode

Options:
  -h, --help            Show this help message
  -m, --minify          Minify SVG before encoding (removes whitespace, 
                       comments, and optimizes paths)
  -c, --clipboard       Copy result to clipboard
  -o, --output FILE     Write output to a file instead of stdout
  -v, --verbose         Show detailed processing information
  --validate            Validate SVG before encoding

Examples:
  # Minify and encode an SVG file
  dart encode_svg.dart icon.svg -m

  # Minify, encode and copy to clipboard
  dart encode_svg.dart logo.svg -m -c

  # Save minified result to a file
  dart encode_svg.dart image.svg -m -o encoded.txt
''');
}

/// The main entry point for the SVG Data URI Encoder tool.
///
/// Processes command-line [arguments] to convert an SVG file to a data URI.
/// Supports various options including:
/// - Minification of SVG content:
///   * Removes comments and unnecessary whitespace
///   * Optimizes path data
///   * Removes empty groups and unused attributes
///   * Shortens color values
///   * Reduces precision of numbers
/// - Copying result to clipboard
/// - Writing output to a file
/// - Verbose logging
/// - SVG validation
///
/// The minification process can significantly reduce file size while
/// maintaining the visual appearance of the SVG.
///
/// Returns a Future that completes when the processing is done.
///
/// Exits with code 0 on success, 1 on error or when no arguments are provided.
Future<void> main(List<String> arguments) async {
  final Map<String, bool> options = {
    'minify': arguments.contains('-m') || arguments.contains('--minify'),
    'clipboard': arguments.contains('-c') || arguments.contains('--clipboard'),
    'verbose': arguments.contains('-v') || arguments.contains('--verbose'),
    'validate': arguments.contains('--validate'),
  };

  if (arguments.isEmpty ||
      arguments.contains('-h') ||
      arguments.contains('--help')) {
    printUsage();
    exit(arguments.isEmpty ? 1 : 0);
  }

  final outputPath = _getOutputPath(arguments);

  try {
    if (options['verbose'] == true) {
      print('Processing SVG file: ${arguments[0]}');
    }

    var dataUri = await svgFileToDataUri(
      arguments[0],
      minify: options['minify'] ?? false,
      validate: options['validate'] ?? false,
    );

    if (options['clipboard'] == true) {
      try {
        await copyToClipboard(dataUri);
        if (options['verbose'] == true) print('Copied to clipboard');
      } catch (e) {
        print('Failed to copy to clipboard: $e');
      }
    }

    if (outputPath != null) {
      await File(outputPath).writeAsString(dataUri);
      if (options['verbose'] == true) print('Written to: $outputPath');
    } else {
      print('Data URI:\n$dataUri');
    }
  } catch (e) {
    print('An error occurred: $e');
    exit(1);
  }
}

/// Gets the output file path from command line arguments.
///
/// Searches for the -o or --output option in the [args] list and returns
/// the following argument as the output path. If no output option is found
/// or no path is provided after the option, returns null.
///
/// [args] - The command line arguments to search through
///
/// Returns the output file path if specified, null otherwise.
String? _getOutputPath(List<String> args) {
  final outputIndex = args.indexOf('-o');
  if (outputIndex == -1) {
    final longOutputIndex = args.indexOf('--output');
    if (longOutputIndex == -1) return null;
    return args.length > longOutputIndex + 1 ? args[longOutputIndex + 1] : null;
  }
  return args.length > outputIndex + 1 ? args[outputIndex + 1] : null;
}
