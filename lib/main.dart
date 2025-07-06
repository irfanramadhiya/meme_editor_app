import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meme_editor_app/config/router.dart';
import 'package:meme_editor_app/model/meme.dart';
import 'package:meme_editor_app/ui/detail/detail_viewmodel.dart';
import 'package:meme_editor_app/ui/export/export_viewmodel.dart';
import 'package:meme_editor_app/ui/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MemeAdapter());
  await Hive.openBox<Meme>('memes');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => DetailViewModel()),
        ChangeNotifierProvider(create: (_) => ExportViewmodel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
