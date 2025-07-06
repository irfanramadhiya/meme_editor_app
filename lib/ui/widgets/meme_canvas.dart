import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meme_editor_app/model/text_overlay.dart';

class MemeCanvas extends StatelessWidget {
  final String imagePath;
  final List<TextOverlay> overlays;
  final void Function(int index, Offset delta, Size imageSize)? onPanUpdate;

  const MemeCanvas({
    super.key,
    required this.imagePath,
    required this.overlays,
    this.onPanUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageSize = Size(constraints.maxWidth, constraints.maxHeight);

        return Stack(
          children: [
            Positioned.fill(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            ),
            ...overlays.asMap().entries.map((entry) {
              final index = entry.key;
              final overlay = entry.value;
              final left = overlay.x * imageSize.width;
              final top = overlay.y * imageSize.height;

              return Positioned(
                left: left,
                top: top,
                child: GestureDetector(
                  onPanUpdate: onPanUpdate != null
                      ? (details) =>
                          onPanUpdate!(index, details.delta, imageSize)
                      : null,
                  child: Text(
                    overlay.text,
                    style: TextStyle(
                      fontSize: overlay.fontSize,
                      color: Colors.black,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
