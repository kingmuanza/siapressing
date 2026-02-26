# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Development Commands

```bash
# Get dependencies
flutter pub get

# Run the app (debug mode)
flutter run

# Run with specific device
flutter run -d <device_id>

# Build release APK (Android)
flutter build apk

# Build release IPA (iOS)
flutter build ios

# Run static analysis
flutter analyze

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Format code
dart format .
```

## Project Overview

This is **siapressing**, a Flutter application targeting iOS and Android. The project uses:
- Dart SDK ^3.9.0
- Material Design (uses-material-design: true)
- flutter_lints for static analysis

## Architecture

Currently a single-file app (`lib/main.dart`) with the default Flutter counter template:
- `MyApp` - Root StatelessWidget with MaterialApp configuration
- `MyHomePage` - Main StatefulWidget
- `_MyHomePageState` - State management for the counter

As the app grows, consider organizing into:
- `lib/screens/` - Screen/page widgets
- `lib/widgets/` - Reusable UI components
- `lib/models/` - Data models
- `lib/services/` - Business logic and API calls
