// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 1;

  @override
  Place read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Place(
      NamePlace: fields[0] as String,
      description: fields[1] as String,
      Image_URL: fields[2] as String,
      Country: fields[3] as String,
      visited: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.NamePlace)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.Image_URL)
      ..writeByte(3)
      ..write(obj.Country)
      ..writeByte(4)
      ..write(obj.visited);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
