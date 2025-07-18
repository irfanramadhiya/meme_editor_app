import 'package:flutter/material.dart';
import 'package:meme_editor_app/model/text_overlay.dart';

class DetailViewModel extends ChangeNotifier {
  List<TextOverlay> overlays = [];
  final List<List<TextOverlay>> _history = [];
  final List<List<TextOverlay>> _redoStack = [];

  void addText(BuildContext context) async {
    final controller = TextEditingController();
    final text = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Meme Text or Add Sticker'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Your meme text'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Add Text'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop('😂'),
            child: const Text('Add Sticker 😂'),
          ),
        ],
      ),
    );

    if (text != null && text.trim().isNotEmpty) {
      _saveToHistory();
      _redoStack.clear();
      overlays.add(TextOverlay(text: text.trim(), x: 0.8, y: 0.4));
      notifyListeners();
    }
  }

  void addSticker(String emoji) {
    _saveToHistory();
    _redoStack.clear();
    overlays.add(TextOverlay(text: emoji, x: 0.8, y: 0.4));
    notifyListeners();
  }

  void redo() {
    if (_redoStack.isNotEmpty) {
      _history.add(List<TextOverlay>.from(overlays.map((e) => e.copyWith())));
      overlays = _redoStack.removeLast();
      notifyListeners();
    }
  }

  void undo() {
    if (_history.isNotEmpty) {
      _redoStack.add(List<TextOverlay>.from(overlays.map((e) => e.copyWith())));
      overlays = _history.removeLast();
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

  void _saveToHistory() {
    _history.add(List<TextOverlay>.from(overlays.map((e) => e.copyWith())));
  }
}
