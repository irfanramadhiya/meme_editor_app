import 'package:flutter/material.dart';
import 'package:meme_editor_app/model/text_overlay.dart';
import 'package:meme_editor_app/ui/export/export_viewmodel.dart';
import 'package:meme_editor_app/ui/widgets/meme_canvas.dart';
import 'package:provider/provider.dart';

class ExportView extends StatelessWidget {
  final String memeUrl;
  final List<TextOverlay> overlays;

  const ExportView({super.key, required this.memeUrl, required this.overlays});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ExportViewmodel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Meme'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () async {
              await vm.shareMeme();
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await vm.saveMemeImage();
        },
        child: const Icon(Icons.save),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: RepaintBoundary(
              key: vm.key,
              child: MemeCanvas(imagePath: memeUrl, overlays: overlays)
            ),
          );
        },
      ),
    );
  }
}
