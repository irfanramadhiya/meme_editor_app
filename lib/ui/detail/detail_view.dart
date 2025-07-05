import 'package:flutter/material.dart';
import 'package:meme_editor_app/model/meme.dart';
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
        title: Text('Edit Meme'),
        actions: [
          IconButton(onPressed: vm.undo, icon: const Icon(Icons.undo)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          vm.addText(context);
        },
        child: const Icon(Icons.text_fields),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final imageSize = Size(constraints.maxWidth, constraints.maxHeight);
          return Stack(
            children: [
              Positioned.fill(
                child: Image.network(meme.url, fit: BoxFit.contain),
              ),
              ...vm.overlays.asMap().entries.map((entry) {
                final index = entry.key;
                final overlay = entry.value;
                final left = overlay.x * imageSize.width;
                final top = overlay.y * imageSize.height;

                return Positioned(
                  left: left,
                  top: top,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      vm.moveOverlay(index, details.delta, imageSize);
                    },
                    child: Text(
                      overlay.text,
                      style: TextStyle(
                        fontSize: overlay.fontSize,
                        color: Colors.white,
                        backgroundColor: Colors.black54,
                      ),
                    ),
                  ),
                );
              })
            ],
          );
        },
      ),
    );
  }
}
