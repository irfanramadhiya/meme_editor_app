import 'package:flutter/material.dart';
import 'package:meme_editor_app/model/meme.dart';
import 'package:meme_editor_app/network/api_sevice.dart';

class HomeViewModel extends ChangeNotifier {

  List<Meme> memes = [];
  bool isLoading = false;
  String error = '';

  Future<void> fetchMemes() async {
    isLoading = true;
    notifyListeners();
    ApiService api = ApiService();

    try {
      memes = await api.fetchMemes();
      error = '';
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
