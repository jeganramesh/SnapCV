import 'package:hive/hive.dart';

part 'personal_info.g.dart';

@HiveType(typeId: 0)
class PersonalInfo extends HiveObject {
  @HiveField(0)
  String fullName;

  @HiveField(1)
  String email;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String location;

  @HiveField(4)
  String linkedIn;

  @HiveField(5)
  String portfolio;

  @HiveField(6)
  String summary;

  PersonalInfo({
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.location = '',
    this.linkedIn = '',
    this.portfolio = '',
    this.summary = '',
  });

  PersonalInfo copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? location,
    String? linkedIn,
    String? portfolio,
    String? summary,
  }) {
    return PersonalInfo(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      linkedIn: linkedIn ?? this.linkedIn,
      portfolio: portfolio ?? this.portfolio,
      summary: summary ?? this.summary,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'location': location,
      'linkedIn': linkedIn,
      'portfolio': portfolio,
      'summary': summary,
    };
  }

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      linkedIn: json['linkedIn'] ?? '',
      portfolio: json['portfolio'] ?? '',
      summary: json['summary'] ?? '',
    );
  }

  bool get isEmpty =>
      fullName.isEmpty &&
      email.isEmpty &&
      phone.isEmpty &&
      location.isEmpty &&
      linkedIn.isEmpty &&
      portfolio.isEmpty &&
      summary.isEmpty;
}
