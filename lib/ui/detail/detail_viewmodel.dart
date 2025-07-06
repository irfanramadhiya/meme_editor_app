import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meme_editor_app/model/text_overlay.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailViewModel extends ChangeNotifier {
  List<TextOverlay> overlays = [];
  final List<List<TextOverlay>> _history = [];

  void addText(BuildContext context) async {
    final controller = TextEditingController();
    final text = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Meme Text'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Your meme text'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // cancel
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (text != null && text.trim().isNotEmpty) {
      _saveToHistory();
      overlays.add(TextOverlay(text: text.trim(), x: 0.8, y: 0.4));
      notifyListeners();
    }
  }

  void moveOverlay(int index, Offset delta, Size imageSize) {
    final overlay = overlays[index];
    overlays[index] = overlay.copyWith(
      x: (overlay.x + delta.dx / imageSize.width).clamp(0.0, 1.0),
      y: (overlay.y + delta.dy / imageSize.height).clamp(0.0, 1.0),
    );
    notifyListeners();
  }

  void undo() {
    if (_history.isNotEmpty) {
      overlays = _history.removeLast();
      notifyListeners();
    }
  }

  void _saveToHistory() {
    _history.add(List<TextOverlay>.from(overlays.map((e) => e.copyWith())));
  }

  Future<void> save(GlobalKey globalKey) async {
    print("Save");
  // 1. Request storage permission (for Android)
  // if (Platform.isAndroid) {
  //   final status = await Permission.storage.request();
  //   if (!status.isGranted) {
  //     print("Permission denied");
  //     return;
  //   }
  // }

  try {
    // 2. Capture widget as image
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      print("Failed to convert image");
      return;
    }

    Uint8List pngBytes = byteData.buffer.asUint8List();

    // 3. Get path
    final directory = await getExternalStorageDirectory(); // e.g. /storage/emulated/0/Android/data/...
    final myImagePath = '${directory!.path}/MyImages';
    await Directory(myImagePath).create(recursive: true);

    final filePath = '$myImagePath/image_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);
    await file.writeAsBytes(pngBytes);

    print("✅ Image saved successfully to: $filePath");
  } catch (e) {
    print("❌ Error saving image: $e");
  }
}
}
