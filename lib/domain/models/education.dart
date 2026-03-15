import 'package:hive/hive.dart';

part 'education.g.dart';

@HiveType(typeId: 1)
class Education extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String institution;

  @HiveField(2)
  String degree;

  @HiveField(3)
  String fieldOfStudy;

  @HiveField(4)
  String startDate;

  @HiveField(5)
  String endDate;

  @HiveField(6)
  String gpa;

  @HiveField(7)
  String description;

  Education({
    required this.id,
    this.institution = '',
    this.degree = '',
    this.fieldOfStudy = '',
    this.startDate = '',
    this.endDate = '',
    this.gpa = '',
    this.description = '',
  });

  Education copyWith({
    String? id,
    String? institution,
    String? degree,
    String? fieldOfStudy,
    String? startDate,
    String? endDate,
    String? gpa,
    String? description,
  }) {
    return Education(
      id: id ?? this.id,
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      gpa: gpa ?? this.gpa,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institution': institution,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate,
      'endDate': endDate,
      'gpa': gpa,
      'description': description,
    };
  }

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] ?? '',
      institution: json['institution'] ?? '',
      degree: json['degree'] ?? '',
      fieldOfStudy: json['fieldOfStudy'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      gpa: json['gpa'] ?? '',
      description: json['description'] ?? '',
    );
  }

  bool get isEmpty =>
      institution.isEmpty &&
      degree.isEmpty &&
      fieldOfStudy.isEmpty &&
      startDate.isEmpty &&
      endDate.isEmpty;
}
