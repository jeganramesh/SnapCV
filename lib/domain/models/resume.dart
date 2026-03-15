import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'personal_info.dart';
import 'education.dart';
import 'experience.dart';
import 'project.dart';
import 'skill.dart';

part 'resume.g.dart';

@HiveType(typeId: 5)
class Resume extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  PersonalInfo personalInfo;

  @HiveField(3)
  List<Education> educationList;

  @HiveField(4)
  List<Experience> experienceList;

  @HiveField(5)
  List<Project> projectList;

  @HiveField(6)
  List<Skill> skillList;

  @HiveField(7)
  List<String> sectionOrder;

  @HiveField(8)
  DateTime createdAt;

  @HiveField(9)
  DateTime updatedAt;

  Resume({
    String? id,
    this.title = 'Untitled Resume',
    PersonalInfo? personalInfo,
    List<Education>? educationList,
    List<Experience>? experienceList,
    List<Project>? projectList,
    List<Skill>? skillList,
    List<String>? sectionOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        personalInfo = personalInfo ?? PersonalInfo(),
        educationList = educationList ?? [],
        experienceList = experienceList ?? [],
        projectList = projectList ?? [],
        skillList = skillList ?? [],
        sectionOrder = sectionOrder ??
            [
              'personalInfo',
              'experience',
              'projects',
              'education',
              'skills',
            ],
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Resume copyWith({
    String? id,
    String? title,
    PersonalInfo? personalInfo,
    List<Education>? educationList,
    List<Experience>? experienceList,
    List<Project>? projectList,
    List<Skill>? skillList,
    List<String>? sectionOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Resume(
      id: id ?? this.id,
      title: title ?? this.title,
      personalInfo: personalInfo ?? this.personalInfo,
      educationList: educationList ?? this.educationList,
      experienceList: experienceList ?? this.experienceList,
      projectList: projectList ?? this.projectList,
      skillList: skillList ?? this.skillList,
      sectionOrder: sectionOrder ?? this.sectionOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'personalInfo': personalInfo.toJson(),
      'educationList': educationList.map((e) => e.toJson()).toList(),
      'experienceList': experienceList.map((e) => e.toJson()).toList(),
      'projectList': projectList.map((e) => e.toJson()).toList(),
      'skillList': skillList.map((e) => e.toJson()).toList(),
      'sectionOrder': sectionOrder,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Resume.fromJson(Map<String, dynamic> json) {
    return Resume(
      id: json['id'],
      title: json['title'] ?? 'Untitled Resume',
      personalInfo: json['personalInfo'] != null
          ? PersonalInfo.fromJson(json['personalInfo'])
          : PersonalInfo(),
      educationList: (json['educationList'] as List<dynamic>?)
              ?.map((e) => Education.fromJson(e))
              .toList() ??
          [],
      experienceList: (json['experienceList'] as List<dynamic>?)
              ?.map((e) => Experience.fromJson(e))
              .toList() ??
          [],
      projectList: (json['projectList'] as List<dynamic>?)
              ?.map((e) => Project.fromJson(e))
              .toList() ??
          [],
      skillList: (json['skillList'] as List<dynamic>?)
              ?.map((e) => Skill.fromJson(e))
              .toList() ??
          [],
      sectionOrder: json['sectionOrder'] != null
          ? List<String>.from(json['sectionOrder'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}
