// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExperienceAdapter extends TypeAdapter<Experience> {
  @override
  final int typeId = 2;

  @override
  Experience read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Experience(
      id: fields[0] as String,
      company: fields[1] as String,
      position: fields[2] as String,
      location: fields[3] as String,
      startDate: fields[4] as String,
      endDate: fields[5] as String,
      isCurrentJob: fields[6] as bool,
      description: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Experience obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.company)
      ..writeByte(2)
      ..write(obj.position)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.endDate)
      ..writeByte(6)
      ..write(obj.isCurrentJob)
      ..writeByte(7)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperienceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
