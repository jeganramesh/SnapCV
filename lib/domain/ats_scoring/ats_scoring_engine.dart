import '../models/resume.dart';

/// ATS Scoring Engine
/// Calculates resume compatibility score based on ATS-friendly criteria
class AtsScoringEngine {
  /// Calculate ATS score for a resume (0-100)
  static int calculateScore(Resume resume) {
    int score = 0;
    int maxScore = 100;

    // Personal Info (25 points max)
    score += _calculatePersonalInfoScore(resume);

    // Experience (25 points max)
    score += _calculateExperienceScore(resume);

    // Education (15 points max)
    score += _calculateEducationScore(resume);

    // Skills (20 points max)
    score += _calculateSkillsScore(resume);

    // Projects (15 points max)
    score += _calculateProjectsScore(resume);

    // Ensure score is within bounds
    return score.clamp(0, maxScore);
  }

  /// Score personal info section (25 points)
  /// - Name: 5 points
  /// - Email: 5 points
  /// - Phone: 5 points
  /// - Location: 5 points
  /// - Summary: 5 points
  static int _calculatePersonalInfoScore(Resume resume) {
    int score = 0;
    final info = resume.personalInfo;

    if (info.fullName.isNotEmpty) score += 5;
    if (info.email.isNotEmpty) score += 5;
    if (info.phone.isNotEmpty) score += 5;
    if (info.location.isNotEmpty) score += 5;
    if (info.summary.isNotEmpty) score += 5;

    return score;
  }

  /// Score experience section (25 points)
  /// - Each valid experience entry: 5 points (max 25)
  static int _calculateExperienceScore(Resume resume) {
    int score = 0;
    
    for (var exp in resume.experienceList) {
      // Valid if has company and position
      if (exp.company.isNotEmpty && exp.position.isNotEmpty) {
        score += 5;
      }
    }
    
    return score.clamp(0, 25);
  }

  /// Score education section (15 points)
  /// - Each valid education entry: 5 points (max 15)
  static int _calculateEducationScore(Resume resume) {
    int score = 0;
    
    for (var edu in resume.educationList) {
      // Valid if has institution and degree
      if (edu.institution.isNotEmpty && edu.degree.isNotEmpty) {
        score += 5;
      }
    }
    
    return score.clamp(0, 15);
  }

  /// Score skills section (20 points)
  /// - 5+ skills: 20 points
  /// - 3-4 skills: 15 points
  /// - 1-2 skills: 10 points
  static int _calculateSkillsScore(Resume resume) {
    int skillCount = resume.skillList.where((s) => s.name.isNotEmpty).length;
    
    if (skillCount >= 5) return 20;
    if (skillCount >= 3) return 15;
    if (skillCount >= 1) return 10;
    return 0;
  }

  /// Score projects section (15 points)
  /// - Each valid project: 5 points (max 15)
  static int _calculateProjectsScore(Resume resume) {
    int score = 0;
    
    for (var project in resume.projectList) {
      // Valid if has name and description
      if (project.name.isNotEmpty && project.description.isNotEmpty) {
        score += 5;
      }
    }
    
    return score.clamp(0, 15);
  }

  /// Get score color based on score value
  static String getScoreLabel(int score) {
    if (score >= 80) return 'Excellent';
    if (score >= 60) return 'Good';
    if (score >= 40) return 'Fair';
    return 'Needs Work';
  }

  /// Get score color hex value
  static int getScoreColorValue(int score) {
    if (score >= 80) return 0xFF34C759; // Green
    if (score >= 60) return 0xFF007AFF; // Blue
    if (score >= 40) return 0xFFFF9500; // Orange
    return 0xFFFF3B30; // Red
  }
}
