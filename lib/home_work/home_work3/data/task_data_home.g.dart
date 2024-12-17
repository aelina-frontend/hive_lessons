// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_data_home.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskDataHomeAdapter extends TypeAdapter<TaskDataHome> {
  @override
  final int typeId = 4;

  @override
  TaskDataHome read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskDataHome(
      id: fields[0] as String,
      title: fields[1] as String,
      dateTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TaskDataHome obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskDataHomeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
