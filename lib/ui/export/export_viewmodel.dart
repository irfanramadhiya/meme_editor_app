import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class ExportViewmodel extends ChangeNotifier {
  final key = GlobalKey();
  String? savedImagePath;

  Future<void> saveMemeImage() async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) return;
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final directory = await getExternalStorageDirectory();
      final path = '${directory!.path}/MyImages';
      await Directory(path).create(recursive: true);
      final file = File(
        '$path/meme_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await file.writeAsBytes(pngBytes);

      ScaffoldMessenger.of(
        key.currentContext!,
      ).showSnackBar(const SnackBar(content: Text('✅ Saved to gallery')));
    } catch (e) {
      ScaffoldMessenger.of(
        key.currentContext!,
      ).showSnackBar(SnackBar(content: Text('❌ Failed to save image: $e')));
    }
  }

  Future<void> shareMeme() async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        ScaffoldMessenger.of(key.currentContext!).showSnackBar(
          const SnackBar(content: Text('❌ Failed to capture image')),
        );
        return;
      }

      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/shared_meme.png');
      await tempFile.writeAsBytes(pngBytes);

      await Share.shareXFiles([
        XFile(tempFile.path),
      ], text: 'Check out my meme!');
    } catch (e) {
      ScaffoldMessenger.of(
        key.currentContext!,
      ).showSnackBar(SnackBar(content: Text('❌ Error while sharing: $e')));
    }
  }
}
