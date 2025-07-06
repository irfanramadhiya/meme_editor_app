import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class ExportViewmodel extends ChangeNotifier {
  final GlobalKey key = GlobalKey();
  Future<void> saveMemeImage() async {
    print("save");
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
      print('Error saving image: $e');
    }
  }
}
