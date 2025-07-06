import 'package:dio/dio.dart';
import 'package:meme_editor_app/model/meme.dart';

class ApiService {
  static const String _baseUrl = 'https://api.imgflip.com';

  Future<List<Meme>> fetchMemes() async {
    try {
      final response = await Dio().get('$_baseUrl/get_memes');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List memes = response.data['data']['memes'];
        return memes.map((e) => Meme.fromJson(e)).toList();
      } else {
        throw Exception('API returned an error: ${response.data}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch memes: ${e.message}');
    }
  }
}
