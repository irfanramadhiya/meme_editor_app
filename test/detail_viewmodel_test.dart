import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:meme_editor_app/model/text_overlay.dart';
import 'package:meme_editor_app/ui/detail/detail_viewmodel.dart';

void main() {
  group('DetailViewModel', () {
    test('moveOverlay updates position correctly', () {
      final viewModel = DetailViewModel();

      // Add initial overlay at center
      viewModel.overlays.add(TextOverlay(text: 'Hello', x: 0.5, y: 0.5));

      // Simulate a drag of 50px right and 30px down on a 200x200 image
      viewModel.moveOverlay(0, const Offset(50, 30), const Size(200, 200));

      final movedOverlay = viewModel.overlays[0];

      expect(movedOverlay.x, closeTo(0.75, 0.001)); // 0.5 + 50/200
      expect(movedOverlay.y, closeTo(0.65, 0.001)); // 0.5 + 30/200
    });
  });
}
