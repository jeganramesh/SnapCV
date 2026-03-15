/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'SnapCV';
  static const String appVersion = '1.0.0';

  // Hive Box Names
  static const String resumesBox = 'resumes_box';

  // Default Section Order
  static const List<String> defaultSectionOrder = [
    'personalInfo',
    'experience',
    'projects',
    'education',
    'skills',
  ];

  // Section Display Names
  static const Map<String, String> sectionDisplayNames = {
    'personalInfo': 'Personal Information',
    'experience': 'Experience',
    'projects': 'Projects',
    'education': 'Education',
    'skills': 'Skills',
  };
}
