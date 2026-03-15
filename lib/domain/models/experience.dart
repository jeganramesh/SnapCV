import 'package:hive/hive.dart';

part 'experience.g.dart';

@HiveType(typeId: 2)
class Experience extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String company;

  @HiveField(2)
  String position;

  @HiveField(3)
  String location;

  @HiveField(4)
  String startDate;

  @HiveField(5)
  String endDate;

  @HiveField(6)
  bool isCurrentJob;

  @HiveField(7)
  String description;

  Experience({
    required this.id,
    this.company = '',
    this.position = '',
    this.location = '',
    this.startDate = '',
    this.endDate = '',
    this.isCurrentJob = false,
    this.description = '',
  });

  Experience copyWith({
    String? id,
    String? company,
    String? position,
    String? location,
    String? startDate,
    String? endDate,
    bool? isCurrentJob,
    String? description,
  }) {
    return Experience(
      id: id ?? this.id,
      company: company ?? this.company,
      position: position ?? this.position,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentJob: isCurrentJob ?? this.isCurrentJob,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'position': position,
      'location': location,
      'startDate': startDate,
      'endDate': endDate,
      'isCurrentJob': isCurrentJob,
      'description': description,
    };
  }

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] ?? '',
      company: json['company'] ?? '',
      position: json['position'] ?? '',
      location: json['location'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      isCurrentJob: json['isCurrentJob'] ?? false,
      description: json['description'] ?? '',
    );
  }

  bool get isEmpty =>
      company.isEmpty && position.isEmpty && startDate.isEmpty;
}
