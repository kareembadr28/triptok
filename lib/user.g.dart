// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      Fname: fields[0] as String,
      Lname: fields[1] as String,
      Email: fields[2] as String,
      Pass: fields[3] as String,
      Places: (fields[4] as List?)?.cast<Place>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.Fname)
      ..writeByte(1)
      ..write(obj.Lname)
      ..writeByte(2)
      ..write(obj.Email)
      ..writeByte(3)
      ..write(obj.Pass)
      ..writeByte(4)
      ..write(obj.Places);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
