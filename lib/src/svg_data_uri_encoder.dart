import 'dart:io';
import 'dart:convert';

/// Converts an SVG file at the given path to a data URI string.
///
/// Returns the data URI as a string. Throws a [FileSystemException] if the file
/// doesn't exist or can't be read.
/// {@category Minification}
Future<String> svgFileToDataUri(
  String path, {
  bool minify = false,
  bool validate = false,
}) async {
  final file = File(path);

  // Check if the file exists.
  if (!(await file.exists())) {
    throw FileSystemException('File not found', path);
  }

  final content = await file.readAsString();
  // Process SVG content based on options
  String processedContent = content;

  /// {@category Minification}
  if (minify) {
    // Add minification logic
    processedContent = processedContent.replaceAll(RegExp(r'\s+'), ' ');
  }

  if (validate) {
    // Add validation logic
    if (!processedContent.contains('<svg')) {
      throw FormatException('Invalid SVG file');
    }
  }

  // Convert to data URI
  final base64Content = base64Encode(utf8.encode(processedContent));
  return 'data:image/svg+xml;base64,$base64Content';
}
