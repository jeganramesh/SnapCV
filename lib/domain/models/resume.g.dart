// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResumeAdapter extends TypeAdapter<Resume> {
  @override
  final int typeId = 5;

  @override
  Resume read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Resume(
      id: fields[0] as String?,
      title: fields[1] as String,
      personalInfo: fields[2] as PersonalInfo?,
      educationList: (fields[3] as List?)?.cast<Education>(),
      experienceList: (fields[4] as List?)?.cast<Experience>(),
      projectList: (fields[5] as List?)?.cast<Project>(),
      skillList: (fields[6] as List?)?.cast<Skill>(),
      sectionOrder: (fields[7] as List?)?.cast<String>(),
      createdAt: fields[8] as DateTime?,
      updatedAt: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Resume obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.personalInfo)
      ..writeByte(3)
      ..write(obj.educationList)
      ..writeByte(4)
      ..write(obj.experienceList)
      ..writeByte(5)
      ..write(obj.projectList)
      ..writeByte(6)
      ..write(obj.skillList)
      ..writeByte(7)
      ..write(obj.sectionOrder)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResumeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
