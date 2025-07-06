import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meme_editor_app/model/text_overlay.dart';
import 'package:meme_editor_app/ui/export/export_viewmodel.dart';
import 'package:provider/provider.dart';

class ExportView extends StatelessWidget {
  final String memeUrl;
  final List<TextOverlay> overlays;

  const ExportView({super.key, required this.memeUrl, required this.overlays});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ExportViewmodel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Export Meme')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await vm.saveMemeImage();
        },
        child: const Icon(Icons.save),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final imageSize = Size(constraints.maxWidth, constraints.maxHeight);
          return Center(
            child: RepaintBoundary(
              key: vm.key,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.file(
                      File(memeUrl),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
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
}
