import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/resume.dart';

/// Resume Preview Widget
/// Displays a miniature preview of a resume on the home screen
class ResumePreviewWidget extends StatelessWidget {
  final Resume resume;
  final VoidCallback? onTap;

  const ResumePreviewWidget({
    super.key,
    required this.resume,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.systemGray5,
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(context),
              const Divider(height: 1),
              // Content Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Role/Headline
                      if (resume.personalInfo.summary.isNotEmpty)
                        _buildSummary(context),
                      const SizedBox(height: 12),
                      // Skills
                      if (resume.skillList.isNotEmpty)
                        _buildSkills(context),
                      const SizedBox(height: 12),
                      // Experience Summary
                      if (resume.experienceList.isNotEmpty)
                        _buildExperienceSummary(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppTheme.primaryColor.withValues(alpha: 0.05),
      child: Row(
        children: [
          // Avatar placeholder
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                _getInitials(),
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resume.personalInfo.fullName.isNotEmpty
                      ? resume.personalInfo.fullName
                      : 'Untitled Resume',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.labelColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  resume.title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.secondaryLabelColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppTheme.systemGray3,
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    final summary = resume.personalInfo.summary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Summary',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppTheme.secondaryLabelColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          summary.length > 100 ? '${summary.substring(0, 100)}...' : summary,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.labelColor,
            height: 1.4,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSkills(BuildContext context) {
    final skills = resume.skillList
        .where((s) => s.name.isNotEmpty)
        .take(4)
        .map((s) => s.name)
        .toList();

    if (skills.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Skills',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppTheme.secondaryLabelColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.systemGray6,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                skill,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.labelColor,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildExperienceSummary(BuildContext context) {
    final expCount = resume.experienceList.length;
    final projectCount = resume.projectList.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Experience',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppTheme.secondaryLabelColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            _buildStatBadge('$expCount', 'Jobs'),
            const SizedBox(width: 8),
            _buildStatBadge('$projectCount', 'Projects'),
          ],
        ),
        if (resume.experienceList.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            _getLatestPosition(),
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.labelColor,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildStatBadge(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.secondaryLabelColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials() {
    final name = resume.personalInfo.fullName;
    if (name.isEmpty) return '?';
    
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  String _getLatestPosition() {
    if (resume.experienceList.isEmpty) return '';
    
    final latest = resume.experienceList.first;
    if (latest.position.isNotEmpty && latest.company.isNotEmpty) {
      return '${latest.position} at ${latest.company}';
    }
    return latest.position.isNotEmpty ? latest.position : latest.company;
  }
}
