# SnapCV - ATS Resume Builder

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.11-blue.svg" alt="Flutter">
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License">
  <img src="https://img.shields.io/badge/Version-1.0.0-orange.svg" alt="Version">
</p>

SnapCV is a modern ATS (Applicant Tracking System) Resume Builder built with Flutter. It provides a clean, intuitive interface for creating, editing, and managing professional resumes with local storage support.

## 📱 Features

### Core Features (Phase 1)
- ✅ **Create Resume** - Start with a blank resume template
- ✅ **Edit Structured Fields** - Modify personal info, education, experience, projects, and skills
- ✅ **Local Storage** - Resumes are saved locally using Hive database
- ✅ **View Stored Resumes** - Browse and select from saved resumes
- ✅ **Section Reordering** - Drag-and-drop to reorder resume sections
- ✅ **CRUD Operations** - Create, read, update, and delete resumes

### Upcoming Features (Phase 2+)
- 📄 PDF Export
- 🔍 ATS Analysis & Scoring
- 🎨 Multiple Themes
- 📤 Resume Sharing

## 🏗️ Architecture

The project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core utilities and configuration
│   ├── constants/           # App-wide constants
│   └── theme/              # Theme configuration (Apple-inspired design)
├── data/                    # Data layer
│   └── repositories/       # Local storage implementation
├── domain/                  # Domain layer
│   └── models/             # Data models (Resume, Education, etc.)
└── presentation/           # Presentation layer
    ├── providers/          # Riverpod state management
    └── screens/            # UI screens
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.11+
- **State Management**: Riverpod
- **Local Storage**: Hive
- **Typography**: Inter (Google Fonts)
- **Architecture**: Clean Architecture

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.11 or higher
- Dart SDK 3.11 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/snapcv.git
   cd snapcv
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters** (if needed)
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build APK

```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release
```

## 📖 Usage

### Home Screen
- View list of saved resumes
- Tap **+** to create a new resume
- Tap on a resume card to edit
- Swipe or tap delete icon to remove

### Resume Editor
- **Personal Info**: Edit name, email, phone, location, LinkedIn, portfolio, summary
- **Education**: Add, edit, delete education entries
- **Experience**: Add, edit, delete work experience
- **Projects**: Add, edit, delete project entries
- **Skills**: Add skills as chips, tap to delete

### Section Reordering
- Long-press and drag the handle icon to reorder sections
- Order is automatically saved

## 🎨 Design

The UI follows **Apple.com visual aesthetic principles**:
- Minimalist, clean design
- System colors (iOS-style)
- Inter font for modern readability
- Extensive white space
- Smooth transitions

## 📁 Project Structure

```
snapcv/
├── lib/
│   ├── core/
│   │   ├── constants/app_constants.dart
│   │   └── theme/app_theme.dart
│   ├── data/
│   │   └── repositories/resume_repository.dart
│   ├── domain/
│   │   └── models/
│   │       ├── education.dart
│   │       ├── experience.dart
│   │       ├── personal_info.dart
│   │       ├── project.dart
│   │       ├── resume.dart
│   │       └── skill.dart
│   ├── presentation/
│   │   ├── providers/resume_providers.dart
│   │   └── screens/
│   │       ├── home_screen.dart
│   │       └── resume_editor_screen.dart
│   └── main.dart
├── test/
│   └── widget_test.dart
├── pubspec.yaml
└── README.md
```

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting PRs.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod for state management
- Hive for local database
- Google Fonts for Inter typography

---

<p align="center">Made with ❤️ using Flutter</p>
