import 'package:hive/hive.dart';

part 'meme.g.dart';

@HiveType(typeId: 0)
class Meme extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final int width;

  @HiveField(4)
  final int height;

  @HiveField(5)
  final int boxCount;

  @HiveField(6)
  final int captions;

  @HiveField(7)
  final String localPath; // For offline use

  Meme({
    required this.id,
    required this.name,
    required this.url,
    required this.width,
    required this.height,
    required this.boxCount,
    required this.captions,
    required this.localPath,
  });

  factory Meme.fromJson(Map<String, dynamic> json, {String localPath = ''}) {
    return Meme(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
      boxCount: json['box_count'],
      captions: json['captions'],
      localPath: localPath,
    );
  }
}
