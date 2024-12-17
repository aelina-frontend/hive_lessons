// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkersAdapter extends TypeAdapter<Workers> {
  @override
  final int typeId = 2;

  @override
  Workers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Workers(
      name: fields[0] as String,
      surname: fields[1] as String,
      experience: fields[2] as int,
      salary: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Workers obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.surname)
      ..writeByte(2)
      ..write(obj.experience)
      ..writeByte(3)
      ..write(obj.salary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
