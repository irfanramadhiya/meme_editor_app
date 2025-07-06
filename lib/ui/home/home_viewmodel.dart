import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meme_editor_app/model/meme.dart';
import 'package:meme_editor_app/network/api_sevice.dart';
import 'package:path_provider/path_provider.dart';

class HomeViewModel extends ChangeNotifier {
  List<Meme> memes = [];
  bool isLoading = false;
  String error = '';

  final memeBox = Hive.box<Meme>('memes');

  List<Meme> allMemes = [];
  String _searchQuery = '';

  void setMemes(List<Meme> loadedMemes) {
    allMemes = loadedMemes;
    _applySearch();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    _applySearch();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      memes = allMemes;
    } else {
      memes = allMemes
          .where(
            (meme) =>
                meme.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  Future<void> fetchMemes(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      final apiMemes = await ApiService().fetchMemes();
      for (var meme in apiMemes) {
        final localFile = await _downloadAndSave(meme.url, meme.id);
        final memeWithPath = Meme(
          id: meme.id,
          name: meme.name,
          url: meme.url,
          width: meme.width,
          height: meme.height,
          boxCount: meme.boxCount,
          captions: meme.captions,
          localPath: localFile.path,
        );
        await memeBox.put(meme.id, memeWithPath);
      }
      setMemes(memeBox.values.toList());

      error = '';
    } catch (e) {
      if (memeBox.isNotEmpty) {
        memes = memeBox.values.toList();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong please check your internet'),
          ),
        );
      } else {
        error = e.toString();
      }
    }

    isLoading = false;
    notifyListeners();
  }

  Future<File> _downloadAndSave(String url, String id) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$id.jpg');

    if (!await file.exists()) {
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      await file.writeAsBytes(response.data);
    }

    return file;
  }
}
