import 'package:go_router/go_router.dart';
import 'package:meme_editor_app/model/meme.dart';
import 'package:meme_editor_app/ui/detail/detail_view.dart';
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
  ],
);
