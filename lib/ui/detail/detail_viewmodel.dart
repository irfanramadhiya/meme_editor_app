import 'package:flutter/material.dart';
import 'package:meme_editor_app/model/text_overlay.dart';

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
      overlays.add(TextOverlay(text: text.trim(), x: 0.4, y: 0.4));
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
}
