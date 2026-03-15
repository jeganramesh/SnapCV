import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/resume_repository.dart';
import '../../domain/models/models.dart';

// Repository provider
final resumeRepositoryProvider = Provider<ResumeRepository>((ref) {
  return ResumeRepository();
});

// Resume list notifier
class ResumeListNotifier extends StateNotifier<List<Resume>> {
  final ResumeRepository _repository;

  ResumeListNotifier(this._repository) : super([]) {
    loadResumes();
  }

  void loadResumes() {
    state = _repository.getAllResumes();
  }

  Future<void> createResume() async {
    final resume = Resume();
    await _repository.createResume(resume);
    loadResumes();
  }

  Future<void> updateResume(Resume resume) async {
    await _repository.updateResume(resume);
    loadResumes();
  }

  Future<void> deleteResume(String id) async {
    await _repository.deleteResume(id);
    loadResumes();
  }
}

// Resume list provider
final resumeListProvider =
    StateNotifierProvider<ResumeListNotifier, List<Resume>>((ref) {
  final repository = ref.watch(resumeRepositoryProvider);
  return ResumeListNotifier(repository);
});

// Current resume being edited
class CurrentResumeNotifier extends StateNotifier<Resume?> {
  final ResumeRepository _repository;

  CurrentResumeNotifier(this._repository) : super(null);

  void loadResume(String id) {
    state = _repository.getResumeById(id);
  }

  void createNewResume() {
    state = Resume();
  }

  Future<void> saveResume(Resume resume) async {
    if (state != null) {
      await _repository.updateResume(resume);
    } else {
      await _repository.createResume(resume);
    }
    state = resume;
  }

  void updatePersonalInfo(PersonalInfo info) {
    if (state != null) {
      state = state!.copyWith(personalInfo: info);
    }
  }

  void addEducation(Education education) {
    if (state != null) {
      final list = List<Education>.from(state!.educationList)..add(education);
      state = state!.copyWith(educationList: list);
    }
  }

  void updateEducation(Education education) {
    if (state != null) {
      final list = state!.educationList.map((e) {
        return e.id == education.id ? education : e;
      }).toList();
      state = state!.copyWith(educationList: list);
    }
  }

  void deleteEducation(String id) {
    if (state != null) {
      final list = state!.educationList.where((e) => e.id != id).toList();
      state = state!.copyWith(educationList: list);
    }
  }

  void addExperience(Experience experience) {
    if (state != null) {
      final list = List<Experience>.from(state!.experienceList)..add(experience);
      state = state!.copyWith(experienceList: list);
    }
  }

  void updateExperience(Experience experience) {
    if (state != null) {
      final list = state!.experienceList.map((e) {
        return e.id == experience.id ? experience : e;
      }).toList();
      state = state!.copyWith(experienceList: list);
    }
  }

  void deleteExperience(String id) {
    if (state != null) {
      final list = state!.experienceList.where((e) => e.id != id).toList();
      state = state!.copyWith(experienceList: list);
    }
  }

  void addProject(Project project) {
    if (state != null) {
      final list = List<Project>.from(state!.projectList)..add(project);
      state = state!.copyWith(projectList: list);
    }
  }

  void updateProject(Project project) {
    if (state != null) {
      final list = state!.projectList.map((p) {
        return p.id == project.id ? project : p;
      }).toList();
      state = state!.copyWith(projectList: list);
    }
  }

  void deleteProject(String id) {
    if (state != null) {
      final list = state!.projectList.where((p) => p.id != id).toList();
      state = state!.copyWith(projectList: list);
    }
  }

  void addSkill(Skill skill) {
    if (state != null) {
      final list = List<Skill>.from(state!.skillList)..add(skill);
      state = state!.copyWith(skillList: list);
    }
  }

  void updateSkill(Skill skill) {
    if (state != null) {
      final list = state!.skillList.map((s) {
        return s.id == skill.id ? skill : s;
      }).toList();
      state = state!.copyWith(skillList: list);
    }
  }

  void deleteSkill(String id) {
    if (state != null) {
      final list = state!.skillList.where((s) => s.id != id).toList();
      state = state!.copyWith(skillList: list);
    }
  }

  void updateSectionOrder(List<String> order) {
    if (state != null) {
      state = state!.copyWith(sectionOrder: order);
    }
  }

  void updateTitle(String title) {
    if (state != null) {
      state = state!.copyWith(title: title);
    }
  }
}

// Current resume provider
final currentResumeProvider =
    StateNotifierProvider<CurrentResumeNotifier, Resume?>((ref) {
  final repository = ref.watch(resumeRepositoryProvider);
  return CurrentResumeNotifier(repository);
});
