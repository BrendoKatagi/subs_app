# 📱 Subs App

![Coverage][coverage_badge]
[![License: MIT][license_badge]][license_link]

A production-ready Flutter application built with Clean Architecture and Bloc pattern, designed for subscription management and store operations.

---

## ✨ Key Features

- 🔐 **Authentication** - Secure user authentication with Firebase
- 🏪 **Store Management** - Complete store dashboard and management system
- 📊 **Subscription Tracking** - Real-time subscription management with QR codes
- 📱 **QR Code System** - Generate and scan QR codes for subscriptions
- 🌍 **Internationalization** - Multi-language support (English, Portuguese)
- 🔔 **Real-time Updates** - Socket.IO integration for live data
- 📱 **Multi-platform** - iOS, Android, Web, and Windows support

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **Domain-Driven Design (DDD)**:

```
lib/
├── app.dart                 # Main app configuration
├── bootstrap.dart          # Bloc observer & error handling
├── config/                 # Configuration (routes, environments, flavors)
├── features/              # Feature-based modular architecture
│   ├── auth/             # Authentication module
│   ├── home/             # Home/dashboard
│   ├── login/            # Login flow
│   ├── menu/             # Menu management
│   ├── profile/          # User profile
│   ├── sign_up/          # Registration
│   ├── store/            # Store management
│   ├── store_report/     # Reports & analytics
│   └── subscription/     # Subscription handling
├── shared/               # Shared code across features
│   ├── widgets/          # Reusable UI components
│   ├── utils/            # Helper functions
│   ├── extensions/      # Dart extensions
│   ├── constants/        # App constants
│   ├── storage/          # Local storage (Secure)
│   └── client/           # HTTP & API clients
└── l10n/                 # Localization files
```

### Design Patterns Used

- **Bloc Pattern** - State management
- **Repository Pattern** - Data layer abstraction
- **Dependency Injection** - GetIt for service locator
- **Service Layer** - API communication
- **Feature-First Directory Structure** - Scalable modular design

---

## 🛠️ Tech Stack

- **Framework**: Flutter 3.29.2
- **Language**: Dart 3.4.0+
- **State Management**: Bloc 8.1.1
- **Routing**: GoRouter 13.2.1
- **Dependency Injection**: GetIt 7.6.4
- **Networking**: Dio 5.4.1
- **Firebase**: Core, Auth, Firestore
- **Real-time**: Socket.IO Client
- **QR**: qr_flutter, mobile_scanner
- **Storage**: flutter_secure_storage
- **Localization**: flutter_localizations
- **UI**: Google Fonts, Shimmer loading

---

## 📦 Dependencies

### Core
- `bloc` & `flutter_bloc` - Business Logic Component
- `dio` - HTTP client
- `get_it` - Service locator
- `go_router` - Declarative routing

### Firebase
- `firebase_core` - Firebase initialization
- Firebase Auth & Firestore ready

### UI/UX
- `google_fonts` - Beautiful typography
- `shimmer` - Loading skeletons
- `flutter_rating_bar` - Rating widgets
- `qr_flutter` - QR generation
- `mobile_scanner` - QR scanning

### Utilities
- `flutter_dotenv` - Environment configuration
- `flutter_secure_storage` - Secure local storage
- `socket_io_client` - Real-time communication
- `url_launcher` - Deep links
- `wakelock_plus` - Screen management

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.4.0+
- Dart SDK 3.4.0+
- Firebase project (optional, for auth)

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/subs_app.git
cd subs_app

# Install dependencies
flutter pub get

# Run with flavor (development/staging/production)
flutter run --flavor development --target lib/main_development.dart
```

### Available Flavors

```sh
# Development
flutter run --flavor development --target lib/main_development.dart

# Staging
flutter run --flavor staging --target lib/main_staging.dart

# Production
flutter run --flavor production --target lib/main_production.dart
```

### Environment Setup

1. Copy `.env.example` to `.env.dev`, `.env.staging`, or `.env.prod`
2. Configure your API base URLs
3. Run `flutterfire configure` for Firebase setup

---

## 🧪 Testing

```bash
# Run all tests with coverage
flutter test --coverage --test-randomize-ordering-seed random

# Generate coverage report
genhtml coverage/lcov.info -o coverage/
open coverage/index.html
```

---

## 🌐 Internationalization

The app supports multiple languages:

```dart
// Add new strings in lib/l10n/arb/app_en.arb
{
    "@@locale": "en",
    "welcomeMessage": "Welcome to Subs App",
    "@welcomeMessage": {
        "description": "Welcome message shown on home screen"
    }
}
```

---

## 📱 Screenshots

[Add your app screenshots here]

---

## 🔧 Build Commands

```sh
# Build for web
flutter build web -t lib/main_production.dart --release

# Build Android APK
flutter build apk --flavor production -t lib/main_production.dart

# Build iOS
flutter build ios --flavor production -t lib/main_production.dart

# Generate code (build_runner)
dart run build_runner build --delete-conflicting-outputs
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Your Name**
- LinkedIn: [Your LinkedIn](https://www.linkedin.com/in/brendo-katagi/)

---

## 🙏 Acknowledgments

- [Very Good Ventures](https://verygood.ventures/) for the Very Good CLI
- Flutter team for the amazing framework
- Open source community for their invaluable packages

---

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
