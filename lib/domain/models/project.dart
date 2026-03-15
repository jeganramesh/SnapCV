import 'package:hive/hive.dart';

part 'project.g.dart';

@HiveType(typeId: 3)
class Project extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String technologies;

  @HiveField(4)
  String link;

  @HiveField(5)
  String startDate;

  @HiveField(6)
  String endDate;

  Project({
    required this.id,
    this.name = '',
    this.description = '',
    this.technologies = '',
    this.link = '',
    this.startDate = '',
    this.endDate = '',
  });

  Project copyWith({
    String? id,
    String? name,
    String? description,
    String? technologies,
    String? link,
    String? startDate,
    String? endDate,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      technologies: technologies ?? this.technologies,
      link: link ?? this.link,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'technologies': technologies,
      'link': link,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      technologies: json['technologies'] ?? '',
      link: json['link'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
    );
  }

  bool get isEmpty => name.isEmpty && description.isEmpty;
}
