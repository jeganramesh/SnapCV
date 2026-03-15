import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/models/models.dart';
import '../../core/constants/app_constants.dart';

class ResumeRepository {
  late Box<Resume> _resumesBox;

  ResumeRepository() {
    _resumesBox = Hive.box<Resume>(AppConstants.resumesBox);
  }

  // Get all resumes
  List<Resume> getAllResumes() {
    return _resumesBox.values.toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  // Get a single resume by ID
  Resume? getResumeById(String id) {
    try {
      return _resumesBox.values.firstWhere((resume) => resume.id == id);
    } catch (e) {
      return null;
    }
  }

  // Create a new resume
  Future<void> createResume(Resume resume) async {
    await _resumesBox.put(resume.id, resume);
  }

  // Update an existing resume
  Future<void> updateResume(Resume resume) async {
    resume.updatedAt = DateTime.now();
    await _resumesBox.put(resume.id, resume);
  }

  // Delete a resume
  Future<void> deleteResume(String id) async {
    await _resumesBox.delete(id);
  }

  // Watch for changes in the resumes box
  Stream<BoxEvent> watchResumes() {
    return _resumesBox.watch();
  }
}
