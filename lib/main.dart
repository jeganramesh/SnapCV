import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'domain/models/models.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive Adapters
  Hive.registerAdapter(PersonalInfoAdapter());
  Hive.registerAdapter(EducationAdapter());
  Hive.registerAdapter(ExperienceAdapter());
  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(SkillAdapter());
  Hive.registerAdapter(ResumeAdapter());
  
  // Open boxes
  await Hive.openBox<Resume>(AppConstants.resumesBox);
  
  runApp(const ProviderScope(child: SnapCVApp()));
}

class SnapCVApp extends StatelessWidget {
  const SnapCVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
