import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meme_editor_app/model/text_overlay.dart';
import 'package:path_provider/path_provider.dart';

class ExportView extends StatelessWidget {
  final String memeUrl;
  final List<TextOverlay> overlays;

  ExportView({super.key, required this.memeUrl, required this.overlays});

  final GlobalKey _exportKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export Meme')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _saveMemeImage(_exportKey);
        },
        child: const Icon(Icons.save),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final imageSize = Size(constraints.maxWidth, constraints.maxHeight);
          return Center(
            child: RepaintBoundary(
              key: _exportKey,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(memeUrl, fit: BoxFit.contain),
                  ),
                  ...overlays.map((overlay) {
                    final left = overlay.x * imageSize.width;
                    final top = overlay.y * imageSize.height;
                    return Positioned(
                      left: left,
                      top: top,
                      child: Text(
                        overlay.text,
                        style: TextStyle(
                          fontSize: overlay.fontSize,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _saveMemeImage(GlobalKey key) async {
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
