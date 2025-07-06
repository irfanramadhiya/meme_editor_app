import 'package:flutter/material.dart';
import 'package:meme_editor_app/config/router.dart';
import 'package:meme_editor_app/model/meme.dart';
import 'package:meme_editor_app/ui/widgets/meme_canvas.dart';
import 'package:provider/provider.dart';
import 'detail_viewmodel.dart';

class DetailView extends StatelessWidget {
  final Meme meme;
  const DetailView({super.key, required this.meme});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DetailViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Meme'),
        actions: [
          IconButton(
            onPressed: () => router.push(
              '/export',
              extra: {
                'memeUrl': meme.localPath,
                'overlays': vm.overlays.map((e) => e.copyWith()).toList(),
              },
            ),
            icon: Icon(Icons.download),
          ),
          IconButton(onPressed: vm.undo, icon: const Icon(Icons.undo)),
          IconButton(icon: const Icon(Icons.redo), onPressed: vm.redo),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          vm.addText(context);
        },
        child: const Icon(Icons.text_fields),
      ),
      body: MemeCanvas(imagePath: meme.localPath, overlays: vm.overlays, onPanUpdate: vm.moveOverlay,)
    );
  }
}
