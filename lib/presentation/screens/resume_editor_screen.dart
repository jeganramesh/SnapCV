import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/models/models.dart';
import '../providers/resume_providers.dart';

class ResumeEditorScreen extends ConsumerStatefulWidget {
  final String resumeId;

  const ResumeEditorScreen({super.key, required this.resumeId});

  @override
  ConsumerState<ResumeEditorScreen> createState() => _ResumeEditorScreenState();
}

class _ResumeEditorScreenState extends ConsumerState<ResumeEditorScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(currentResumeProvider.notifier).loadResume(widget.resumeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final resume = ref.watch(currentResumeProvider);

    if (resume == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.secondaryBackgroundColor,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _editTitle(context, resume),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  resume.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.edit, size: 16),
            ],
          ),
        ),
        backgroundColor: AppTheme.backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _saveResume(context),
          ),
        ],
      ),
      body: _buildReorderableSections(resume),
    );
  }

  Widget _buildReorderableSections(Resume resume) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: resume.sectionOrder.length,
      onReorder: (oldIndex, newIndex) {
        _onReorder(oldIndex, newIndex, resume);
      },
      proxyDecorator: (child, index, animation) {
        return Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: child,
        );
      },
      itemBuilder: (context, index) {
        final sectionKey = resume.sectionOrder[index];
        return _buildSectionCard(sectionKey, resume, Key(sectionKey));
      },
    );
  }

  Widget _buildSectionCard(String sectionKey, Resume resume, Key key) {
    final displayName = AppConstants.sectionDisplayNames[sectionKey] ?? sectionKey;
    
    return Card(
      key: key,
      margin: const EdgeInsets.only(bottom: 12),
      color: AppTheme.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.systemGray5, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.systemGray5, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.drag_handle, color: AppTheme.systemGray),
                const SizedBox(width: 8),
                Text(
                  displayName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                _buildAddButton(sectionKey),
              ],
            ),
          ),
          // Section Content
          _buildSectionContent(sectionKey, resume),
        ],
      ),
    );
  }

  Widget _buildAddButton(String sectionKey) {
    IconData icon;
    switch (sectionKey) {
      case 'personalInfo':
        return const SizedBox.shrink(); // Personal info has no add button
      case 'education':
        icon = Icons.school;
        break;
      case 'experience':
        icon = Icons.work;
        break;
      case 'projects':
        icon = Icons.folder;
        break;
      case 'skills':
        icon = Icons.star;
        break;
      default:
        return const SizedBox.shrink();
    }

    return IconButton(
      icon: Icon(icon, color: AppTheme.primaryColor),
      onPressed: () => _addItem(sectionKey),
    );
  }

  Widget _buildSectionContent(String sectionKey, Resume resume) {
    switch (sectionKey) {
      case 'personalInfo':
        return _buildPersonalInfoSection(resume.personalInfo);
      case 'education':
        return _buildEducationSection(resume.educationList);
      case 'experience':
        return _buildExperienceSection(resume.experienceList);
      case 'projects':
        return _buildProjectsSection(resume.projectList);
      case 'skills':
        return _buildSkillsSection(resume.skillList);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPersonalInfoSection(PersonalInfo info) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTextField(
            label: 'Full Name',
            value: info.fullName,
            onChanged: (value) => _updatePersonalInfo(fullName: value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Email',
            value: info.email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => _updatePersonalInfo(email: value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Phone',
            value: info.phone,
            keyboardType: TextInputType.phone,
            onChanged: (value) => _updatePersonalInfo(phone: value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Location',
            value: info.location,
            onChanged: (value) => _updatePersonalInfo(location: value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'LinkedIn',
            value: info.linkedIn,
            onChanged: (value) => _updatePersonalInfo(linkedIn: value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Portfolio',
            value: info.portfolio,
            onChanged: (value) => _updatePersonalInfo(portfolio: value),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            label: 'Summary',
            value: info.summary,
            maxLines: 4,
            onChanged: (value) => _updatePersonalInfo(summary: value),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection(List<Education> educationList) {
    if (educationList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Text(
            'Tap + to add education',
            style: TextStyle(color: AppTheme.secondaryLabelColor),
          ),
        ),
      );
    }

    return Column(
      children: educationList.map((edu) => _buildEducationItem(edu)).toList(),
    );
  }

  Widget _buildEducationItem(Education edu) {
    return _buildItemCard(
      title: edu.institution.isNotEmpty ? edu.institution : 'New Education',
      subtitle: edu.degree.isNotEmpty ? edu.degree : 'Degree',
      onEdit: () => _editEducation(edu),
      onDelete: () => _deleteEducation(edu.id),
    );
  }

  Widget _buildExperienceSection(List<Experience> experienceList) {
    if (experienceList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Text(
            'Tap + to add experience',
            style: TextStyle(color: AppTheme.secondaryLabelColor),
          ),
        ),
      );
    }

    return Column(
      children: experienceList.map((exp) => _buildExperienceItem(exp)).toList(),
    );
  }

  Widget _buildExperienceItem(Experience exp) {
    return _buildItemCard(
      title: exp.company.isNotEmpty ? exp.company : 'New Company',
      subtitle: exp.position.isNotEmpty ? exp.position : 'Position',
      onEdit: () => _editExperience(exp),
      onDelete: () => _deleteExperience(exp.id),
    );
  }

  Widget _buildProjectsSection(List<Project> projectList) {
    if (projectList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Text(
            'Tap + to add project',
            style: TextStyle(color: AppTheme.secondaryLabelColor),
          ),
        ),
      );
    }

    return Column(
      children: projectList.map((proj) => _buildProjectItem(proj)).toList(),
    );
  }

  Widget _buildProjectItem(Project proj) {
    return _buildItemCard(
      title: proj.name.isNotEmpty ? proj.name : 'New Project',
      subtitle: proj.description.isNotEmpty ? proj.description : 'Description',
      onEdit: () => _editProject(proj),
      onDelete: () => _deleteProject(proj.id),
    );
  }

  Widget _buildSkillsSection(List<Skill> skillList) {
    if (skillList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Text(
            'Tap + to add skill',
            style: TextStyle(color: AppTheme.secondaryLabelColor),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: skillList.map((skill) => _buildSkillChip(skill)).toList(),
      ),
    );
  }

  Widget _buildSkillChip(Skill skill) {
    return Chip(
      label: Text(skill.name),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: () => _deleteSkill(skill.id),
      backgroundColor: AppTheme.systemGray6,
      side: const BorderSide(color: AppTheme.systemGray5),
    );
  }

  Widget _buildItemCard({
    required String title,
    required String subtitle,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.systemGray5, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 20),
            color: AppTheme.primaryColor,
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            color: AppTheme.destructiveColor,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    TextInputType? keyboardType,
    int maxLines = 1,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      initialValue: value,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppTheme.systemGray6,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
      ),
      onChanged: onChanged,
    );
  }

  void _onReorder(int oldIndex, int newIndex, Resume resume) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final List<String> newOrder = List.from(resume.sectionOrder);
    final item = newOrder.removeAt(oldIndex);
    newOrder.insert(newIndex, item);
    ref.read(currentResumeProvider.notifier).updateSectionOrder(newOrder);
    ref.read(resumeListProvider.notifier).updateResume(
      resume.copyWith(sectionOrder: newOrder),
    );
  }

  void _updatePersonalInfo({
    String? fullName,
    String? email,
    String? phone,
    String? location,
    String? linkedIn,
    String? portfolio,
    String? summary,
  }) {
    final resume = ref.read(currentResumeProvider);
    if (resume != null) {
      final updatedInfo = resume.personalInfo.copyWith(
        fullName: fullName,
        email: email,
        phone: phone,
        location: location,
        linkedIn: linkedIn,
        portfolio: portfolio,
        summary: summary,
      );
      ref.read(currentResumeProvider.notifier).updatePersonalInfo(updatedInfo);
    }
  }

  void _addItem(String sectionKey) {
    switch (sectionKey) {
      case 'education':
        _addEducation();
        break;
      case 'experience':
        _addExperience();
        break;
      case 'projects':
        _addProject();
        break;
      case 'skills':
        _addSkill();
        break;
    }
  }

  void _addEducation() {
    final education = Education(id: const Uuid().v4());
    ref.read(currentResumeProvider.notifier).addEducation(education);
    _editEducation(education);
  }

  void _editEducation(Education education) {
    _showEditDialog(
      title: 'Education',
      fields: [
        {'label': 'Institution', 'value': education.institution, 'key': 'institution'},
        {'label': 'Degree', 'value': education.degree, 'key': 'degree'},
        {'label': 'Field of Study', 'value': education.fieldOfStudy, 'key': 'fieldOfStudy'},
        {'label': 'Start Date', 'value': education.startDate, 'key': 'startDate'},
        {'label': 'End Date', 'value': education.endDate, 'key': 'endDate'},
        {'label': 'GPA', 'value': education.gpa, 'key': 'gpa'},
        {'label': 'Description', 'value': education.description, 'key': 'description', 'maxLines': 3},
      ],
      onSave: (values) {
        final updated = education.copyWith(
          institution: values['institution'],
          degree: values['degree'],
          fieldOfStudy: values['fieldOfStudy'],
          startDate: values['startDate'],
          endDate: values['endDate'],
          gpa: values['gpa'],
          description: values['description'],
        );
        ref.read(currentResumeProvider.notifier).updateEducation(updated);
      },
    );
  }

  void _deleteEducation(String id) {
    ref.read(currentResumeProvider.notifier).deleteEducation(id);
  }

  void _addExperience() {
    final experience = Experience(id: const Uuid().v4());
    ref.read(currentResumeProvider.notifier).addExperience(experience);
    _editExperience(experience);
  }

  void _editExperience(Experience experience) {
    _showEditDialog(
      title: 'Experience',
      fields: [
        {'label': 'Company', 'value': experience.company, 'key': 'company'},
        {'label': 'Position', 'value': experience.position, 'key': 'position'},
        {'label': 'Location', 'value': experience.location, 'key': 'location'},
        {'label': 'Start Date', 'value': experience.startDate, 'key': 'startDate'},
        {'label': 'End Date', 'value': experience.endDate, 'key': 'endDate'},
        {'label': 'Description', 'value': experience.description, 'key': 'description', 'maxLines': 4},
      ],
      onSave: (values) {
        final updated = experience.copyWith(
          company: values['company'],
          position: values['position'],
          location: values['location'],
          startDate: values['startDate'],
          endDate: values['endDate'],
          description: values['description'],
        );
        ref.read(currentResumeProvider.notifier).updateExperience(updated);
      },
    );
  }

  void _deleteExperience(String id) {
    ref.read(currentResumeProvider.notifier).deleteExperience(id);
  }

  void _addProject() {
    final project = Project(id: const Uuid().v4());
    ref.read(currentResumeProvider.notifier).addProject(project);
    _editProject(project);
  }

  void _editProject(Project project) {
    _showEditDialog(
      title: 'Project',
      fields: [
        {'label': 'Name', 'value': project.name, 'key': 'name'},
        {'label': 'Description', 'value': project.description, 'key': 'description', 'maxLines': 3},
        {'label': 'Technologies', 'value': project.technologies, 'key': 'technologies'},
        {'label': 'Link', 'value': project.link, 'key': 'link'},
        {'label': 'Start Date', 'value': project.startDate, 'key': 'startDate'},
        {'label': 'End Date', 'value': project.endDate, 'key': 'endDate'},
      ],
      onSave: (values) {
        final updated = project.copyWith(
          name: values['name'],
          description: values['description'],
          technologies: values['technologies'],
          link: values['link'],
          startDate: values['startDate'],
          endDate: values['endDate'],
        );
        ref.read(currentResumeProvider.notifier).updateProject(updated);
      },
    );
  }

  void _deleteProject(String id) {
    ref.read(currentResumeProvider.notifier).deleteProject(id);
  }

  void _addSkill() {
    _showAddSkillDialog();
  }

  void _showAddSkillDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Skill'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Skill Name',
            hintText: 'e.g., Flutter, Python',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final skill = Skill(id: const Uuid().v4(), name: controller.text);
                ref.read(currentResumeProvider.notifier).addSkill(skill);
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _deleteSkill(String id) {
    ref.read(currentResumeProvider.notifier).deleteSkill(id);
  }

  void _showEditDialog({
    required String title,
    required List<Map<String, dynamic>> fields,
    required Function(Map<String, String>) onSave,
  }) {
    final Map<String, TextEditingController> controllers = {};
    for (var field in fields) {
      controllers[field['key'] as String] = TextEditingController(text: field['value'] as String);
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppTheme.systemGray5, width: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    TextButton(
                      onPressed: () {
                        final values = <String, String>{};
                        controllers.forEach((key, controller) {
                          values[key] = controller.text;
                        });
                        onSave(values);
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
              // Fields
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: fields.map((field) {
                    final key = field['key'] as String;
                    final maxLines = field['maxLines'] as int? ?? 1;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextField(
                        controller: controllers[key],
                        maxLines: maxLines,
                        decoration: InputDecoration(
                          labelText: field['label'] as String,
                          filled: true,
                          fillColor: AppTheme.systemGray6,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editTitle(BuildContext context, Resume resume) {
    final controller = TextEditingController(text: resume.title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resume Title'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Title',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(currentResumeProvider.notifier).updateTitle(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _saveResume(BuildContext context) async {
    final resume = ref.read(currentResumeProvider);
    if (resume != null) {
      await ref.read(resumeListProvider.notifier).updateResume(resume);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Resume saved'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    }
  }
}
