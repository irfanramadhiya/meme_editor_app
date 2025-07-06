// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemeAdapter extends TypeAdapter<Meme> {
  @override
  final int typeId = 0;

  @override
  Meme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meme(
      id: fields[0] as String,
      name: fields[1] as String,
      url: fields[2] as String,
      width: fields[3] as int,
      height: fields[4] as int,
      boxCount: fields[5] as int,
      captions: fields[6] as int,
      localPath: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Meme obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.width)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.boxCount)
      ..writeByte(6)
      ..write(obj.captions)
      ..writeByte(7)
      ..write(obj.localPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
