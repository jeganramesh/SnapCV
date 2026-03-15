import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/ats_scoring/ats_scoring_engine.dart';
import '../../domain/models/resume.dart';

/// ATS Score Widget
/// Displays the ATS compatibility score for a resume
class AtsScoreWidget extends StatelessWidget {
  final Resume resume;
  final bool showDetails;
  final VoidCallback? onTap;

  const AtsScoreWidget({
    super.key,
    required this.resume,
    this.showDetails = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final score = AtsScoringEngine.calculateScore(resume);
    final scoreColor = Color(AtsScoringEngine.getScoreColorValue(score));
    final scoreLabel = AtsScoringEngine.getScoreLabel(score);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.systemGray5,
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.analytics_outlined,
                  size: 20,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 8),
                const Text(
                  'ATS Score',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.labelColor,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: scoreColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    scoreLabel,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: scoreColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  '$score',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: scoreColor,
                  ),
                ),
                const Text(
                  ' / 100',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.secondaryLabelColor,
                  ),
                ),
              ],
            ),
            if (showDetails) ...[
              const SizedBox(height: 12),
              _buildScoreBreakdown(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildScoreBreakdown() {
    return Column(
      children: [
        _buildScoreBar('Personal Info', _getPersonalInfoScore(), 25),
        const SizedBox(height: 8),
        _buildScoreBar('Experience', _getExperienceScore(), 25),
        const SizedBox(height: 8),
        _buildScoreBar('Education', _getEducationScore(), 15),
        const SizedBox(height: 8),
        _buildScoreBar('Skills', _getSkillsScore(), 20),
        const SizedBox(height: 8),
        _buildScoreBar('Projects', _getProjectsScore(), 15),
      ],
    );
  }

  Widget _buildScoreBar(String label, int score, int maxScore) {
    final progress = score / maxScore;
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.secondaryLabelColor,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.systemGray5,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 30,
          child: Text(
            '$score/$maxScore',
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.secondaryLabelColor,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  int _getPersonalInfoScore() {
    int score = 0;
    final info = resume.personalInfo;
    if (info.fullName.isNotEmpty) score += 5;
    if (info.email.isNotEmpty) score += 5;
    if (info.phone.isNotEmpty) score += 5;
    if (info.location.isNotEmpty) score += 5;
    if (info.summary.isNotEmpty) score += 5;
    return score;
  }

  int _getExperienceScore() {
    int score = 0;
    for (var exp in resume.experienceList) {
      if (exp.company.isNotEmpty && exp.position.isNotEmpty) {
        score += 5;
      }
    }
    return score.clamp(0, 25);
  }

  int _getEducationScore() {
    int score = 0;
    for (var edu in resume.educationList) {
      if (edu.institution.isNotEmpty && edu.degree.isNotEmpty) {
        score += 5;
      }
    }
    return score.clamp(0, 15);
  }

  int _getSkillsScore() {
    int skillCount = resume.skillList.where((s) => s.name.isNotEmpty).length;
    if (skillCount >= 5) return 20;
    if (skillCount >= 3) return 15;
    if (skillCount >= 1) return 10;
    return 0;
  }

  int _getProjectsScore() {
    int score = 0;
    for (var project in resume.projectList) {
      if (project.name.isNotEmpty && project.description.isNotEmpty) {
        score += 5;
      }
    }
    return score.clamp(0, 15);
  }
}
