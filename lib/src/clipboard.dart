import 'dart:io';

Future<void> copyToClipboard(String text) async {
  try {
    final process = await Process.start('clip', [], runInShell: true);
    process.stdin.write(text);
    await process.stdin.close();
    await process.exitCode;
  } catch (e) {
    throw Exception('Failed to copy to clipboard: $e');
  }
}
