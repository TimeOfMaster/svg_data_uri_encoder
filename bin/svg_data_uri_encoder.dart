import 'dart:io';
import 'dart:convert';

Future<void> main(List<String> arguments) async {
  // Ensure the user provides a file path argument.
  if (arguments.isEmpty) {
    print('Usage: dart encode_svg.dart <path-to-svg-file>');
    exit(1);
  }

  final filePath = arguments[0];
  final file = File(filePath);

  // Check if the file exists.
  if (!(await file.exists())) {
    print('Error: File not found at $filePath');
    exit(1);
  }

  try {
    // Read the SVG file content as a string.
    final svgContent = await file.readAsString();

    // Base64 encode the SVG content.
    final base64String = base64Encode(utf8.encode(svgContent));

    // Prepend the appropriate data URI scheme.
    final dataUri = 'data:image/svg+xml;base64,$base64String';

    // Print the resulting data URI.
    print('Data URI:\n$dataUri');
  } catch (e) {
    print('An error occurred: $e');
    exit(1);
  }
}
