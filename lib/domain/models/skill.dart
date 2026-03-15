import 'package:hive/hive.dart';

part 'skill.g.dart';

@HiveType(typeId: 4)
class Skill extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String level;

  @HiveField(3)
  String category;

  Skill({
    required this.id,
    this.name = '',
    this.level = '',
    this.category = '',
  });

  Skill copyWith({
    String? id,
    String? name,
    String? level,
    String? category,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'level': level,
      'category': category,
    };
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      level: json['level'] ?? '',
      category: json['category'] ?? '',
    );
  }

  bool get isEmpty => name.isEmpty;
}
