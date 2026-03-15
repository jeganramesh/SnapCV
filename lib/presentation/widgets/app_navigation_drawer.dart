import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/models/resume.dart';
import '../providers/resume_providers.dart';
import '../screens/resume_editor_screen.dart';

/// App Navigation Drawer
/// Lists all saved resumes for quick access
class AppNavigationDrawer extends ConsumerWidget {
  const AppNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumes = ref.watch(resumeListProvider);

    return Drawer(
      backgroundColor: AppTheme.backgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.description,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'SnapCV',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.labelColor,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Menu Items
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: AppTheme.primaryColor,
              ),
              title: const Text(
                'Home',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'MY RESUMES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.secondaryLabelColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            // Resume List
            Expanded(
              child: resumes.isEmpty
                  ? const Center(
                      child: Text(
                        'No resumes yet',
                        style: TextStyle(
                          color: AppTheme.secondaryLabelColor,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: resumes.length,
                      itemBuilder: (context, index) {
                        final resume = resumes[index];
                        return _ResumeDrawerItem(resume: resume);
                      },
                    ),
            ),
            // Footer
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '${resumes.length} resume${resumes.length == 1 ? '' : 's'}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.tertiaryLabelColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual resume item in the drawer
class _ResumeDrawerItem extends StatelessWidget {
  final Resume resume;

  const _ResumeDrawerItem({required this.resume});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.description_outlined,
          color: AppTheme.primaryColor,
          size: 18,
        ),
      ),
      title: Text(
        resume.title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _formatDate(resume.updatedAt),
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.tertiaryLabelColor,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResumeEditorScreen(resumeId: resume.id),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
