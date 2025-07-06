import 'package:go_router/go_router.dart';
import 'package:meme_editor_app/model/meme.dart';
import 'package:meme_editor_app/model/text_overlay.dart';
import 'package:meme_editor_app/ui/detail/detail_view.dart';
import 'package:meme_editor_app/ui/export/export_view.dart';
import 'package:meme_editor_app/ui/home/home_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeView()),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final meme = state.extra as Meme;
        return DetailView(meme: meme);
      },
    ),
    GoRoute(
      path: '/export',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final String memeUrl = extra['memeUrl'];
        final List<TextOverlay> overlays = List<TextOverlay>.from(
          extra['overlays'],
        );
        return ExportView(memeUrl: memeUrl, overlays: overlays);
      },
    ),
  ],
);
