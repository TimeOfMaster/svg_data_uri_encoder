import 'dart:io';

/// Copies the provided text to the system clipboard.
///
/// {@category Clipboard}
///
/// This function detects the operating system and uses the appropriate clipboard command:
/// - Windows: uses 'clip'
/// - macOS: uses 'pbcopy'
/// - Linux: uses 'xclip' or 'xsel'
///
/// Parameters:
///   - [text]: The string content to be copied to the clipboard
///
/// Throws:
///   - [Exception] if the clipboard operation fails or platform is unsupported
///
/// Example:
///
/// ```dart
/// await copyToClipboard('Hello, clipboard!');
/// ```
Future<void> copyToClipboard(String text) async {
  final String command;
  final List<String> arguments;

  if (Platform.isWindows) {
    command = 'clip';
    arguments = [];
  } else if (Platform.isMacOS) {
    command = 'pbcopy';
    arguments = [];
  } else if (Platform.isLinux) {
    command = 'xclip';
    arguments = ['-selection', 'clipboard'];
  } else {
    throw Exception('Unsupported platform');
  }

  try {
    final process = await Process.start(command, arguments, runInShell: true);
    process.stdin.write(text);
    await process.stdin.close();
    await process.exitCode;
  } catch (e) {
    throw Exception('Failed to copy to clipboard: $e');
  }
}
