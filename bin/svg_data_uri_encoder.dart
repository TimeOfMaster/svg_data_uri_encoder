import 'dart:io';
import 'package:svg_data_uri_encoder/svg_data_uri_encoder.dart';
import 'package:svg_data_uri_encoder/src/clipboard.dart';

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
  -m, --minify          Minify SVG before encoding
  -c, --clipboard       Copy result to clipboard
  -o, --output FILE     Write output to a file instead of stdout
  -v, --verbose         Show detailed processing information
  --validate            Validate SVG before encoding
''');
}

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

String? _getOutputPath(List<String> args) {
  final outputIndex = args.indexOf('-o');
  if (outputIndex == -1) {
    final longOutputIndex = args.indexOf('--output');
    if (longOutputIndex == -1) return null;
    return args.length > longOutputIndex + 1 ? args[longOutputIndex + 1] : null;
  }
  return args.length > outputIndex + 1 ? args[outputIndex + 1] : null;
}
