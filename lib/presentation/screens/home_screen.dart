import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../providers/resume_providers.dart';
import 'resume_editor_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resumes = ref.watch(resumeListProvider);

    return Scaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      appBar: AppBar(
        title: const Text('SnapCV'),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      body: resumes.isEmpty
          ? _buildEmptyState(context, ref)
          : _buildResumeList(context, ref, resumes),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewResume(context, ref),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 80,
            color: AppTheme.systemGray3,
          ),
          const SizedBox(height: 16),
          Text(
            'No Resumes Yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.secondaryLabelColor,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to create your first resume',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.tertiaryLabelColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeList(BuildContext context, WidgetRef ref, List resumes) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: resumes.length,
      itemBuilder: (context, index) {
        final resume = resumes[index];
        return _buildResumeCard(context, ref, resume);
      },
    );
  }

  Widget _buildResumeCard(BuildContext context, WidgetRef ref, dynamic resume) {
    final name = resume.personalInfo.fullName.isNotEmpty
        ? resume.personalInfo.fullName
        : 'Untitled';
    final updatedAt = _formatDate(resume.updatedAt);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.systemGray5, width: 0.5),
      ),
      child: InkWell(
        onTap: () => _editResume(context, ref, resume.id),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.description,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resume.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.secondaryLabelColor,
                          ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Updated $updatedAt',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: AppTheme.destructiveColor,
                onPressed: () => _deleteResume(context, ref, resume.id),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'today';
    } else if (diff.inDays == 1) {
      return 'yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _createNewResume(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(resumeListProvider.notifier);
    await notifier.createResume();
    
    // Get the newly created resume
    final resumes = ref.read(resumeListProvider);
    if (resumes.isNotEmpty) {
      final newResume = resumes.first;
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResumeEditorScreen(resumeId: newResume.id),
          ),
        );
      }
    }
  }

  void _editResume(BuildContext context, WidgetRef ref, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResumeEditorScreen(resumeId: id),
      ),
    );
  }

  void _deleteResume(BuildContext context, WidgetRef ref, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Resume'),
        content: const Text('Are you sure you want to delete this resume?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(resumeListProvider.notifier).deleteResume(id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.destructiveColor,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
