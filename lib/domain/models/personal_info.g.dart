// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalInfoAdapter extends TypeAdapter<PersonalInfo> {
  @override
  final int typeId = 0;

  @override
  PersonalInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalInfo(
      fullName: fields[0] as String,
      email: fields[1] as String,
      phone: fields[2] as String,
      location: fields[3] as String,
      linkedIn: fields[4] as String,
      portfolio: fields[5] as String,
      summary: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalInfo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.linkedIn)
      ..writeByte(5)
      ..write(obj.portfolio)
      ..writeByte(6)
      ..write(obj.summary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
