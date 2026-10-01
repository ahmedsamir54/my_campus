# MyCampus — SoftTaqwa University Mobile Portal 🎓

[![Download APK](https://img.shields.io/badge/Download%20APK-v1.0%20arm64%20(24.6%20MB)-00A651?logo=android&logoColor=white&style=for-the-badge)](https://github.com/ahmedsamir54/my_campus/raw/main/releases/MyCampus-v1.0-arm64.apk)
[![Figma Design](https://img.shields.io/badge/Figma-Design%20System-F24E1E?logo=figma&logoColor=white&style=for-the-badge)](https://www.figma.com/board/8b2pyF8bwhxUE5ccD3QYiJ/MyCampus-%E2%80%94-SoftTaqwa-Design-System?node-id=0-1&t=A6f5gN4Dui6qBHRz-1)

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2B%20BLoC%20%2F%20Cubit-00A651?logo=blueprint&logoColor=white)](ARCHITECTURE.md)
[![Tests](https://img.shields.io/badge/Tests-26%2F26%20Passed-10B981?logo=checkmarx&logoColor=white)](test/)
[![Linter](https://img.shields.io/badge/Linter-0%20Issues-brightgreen?logo=dart)](analysis_options.yaml)
[![Theme](https://img.shields.io/badge/Theme-Light%20%26%20Dark%20Mode-131D28)](lib/core/theme/)

> **MyCampus** is a next-generation mobile campus ecosystem designed for **SoftTaqwa University**. Engineered with **Clean Architecture**, **BLoC/Cubit**, and an enterprise-grade design system, MyCampus unifies academic life, routine schedules, attendance analytics, student identity, and campus resources into a unified, lightning-fast digital experience.

---

## ⚡ Quick Links & Evaluator Access

| 📦 **Download APK** | 🎨 **Figma Design Board** | 📖 **Architecture Docs** |
| :--- | :--- | :--- |
| [**Download MyCampus-v1.0-arm64.apk**](https://github.com/ahmedsamir54/my_campus/raw/main/releases/MyCampus-v1.0-arm64.apk) <br/> *(Direct Android install • 24.6 MB)* | [**MyCampus — SoftTaqwa Design System**](https://www.figma.com/board/8b2pyF8bwhxUE5ccD3QYiJ/MyCampus-%E2%80%94-SoftTaqwa-Design-System?node-id=0-1&t=A6f5gN4Dui6qBHRz-1) <br/> *(Component tokens & UI mockups)* | [**Read Technical Blueprint**](ARCHITECTURE.md) <br/> *(Clean Architecture & BLoC state specs)* |

### 🔑 Demo Student Credentials (Instant Evaluation)

The app comes with pre-configured mock data for evaluators to test all features immediately without account registration:

> **Portal Login Credentials:**
> - **Student ID / Email:** `CU-2023-8841` *(pre-filled by default)*
> - **Password:** `password123` *(pre-filled by default)*
> - **One-Tap Instant Entry:** Tap **"Sign In to Campus"** or tap **"Face ID"** / **"Touch ID"** for instant simulated biometric login.

---

## 🎨 Design System & Board

- **Official Figma Design Workspace:**  
  👉 [**MyCampus — SoftTaqwa Design System**](https://www.figma.com/board/8b2pyF8bwhxUE5ccD3QYiJ/MyCampus-%E2%80%94-SoftTaqwa-Design-System?node-id=0-1&t=A6f5gN4Dui6qBHRz-1)

The UI reflects the SoftTaqwa University visual identity:
- **Brand Primary:** `#00A651` (SoftTaqwa Emerald)
- **Deep Primary:** `#064E3B` & `#073A27`
- **Mint Accents & Badges:** `#34D399` & `#D1FAE5`
- **Dark Mode Canvas:** `#0B0F17` (Deep Obsidian) and `#131D28` / `#101B27` (Card Surface)
- **Typography:** Modern Google Fonts [Inter](https://fonts.google.com/specimen/Inter) scale

---

## ⚡ Core Features & Capabilities

### 1. Unified Splash & Lifecycle Router
- **Zero-Flicker Native Launch:** Native Android/iOS splash screen configured via `flutter_native_splash`, displaying the university emblem on pure white without secondary flutter stutter.
- **Single-Display Onboarding Lifecycle:** Built-in persistence via `shared_preferences`. First-time users experience a smooth animated carousel; subsequent launches intelligently route directly to Login or Dashboard based on session token state.

### 2. Secure SSO Authentication & Biometrics
- **Multi-Factor Access:** Standard university credentials with student email validation (`@softtaqwa.edu`).
- **Hardware Biometrics:** Seamless Touch ID & Face ID integration with immediate token caching and auto-login capabilities.
- **Session Management:** Secure local storage token handling and immediate cache invalidation upon logout.

### 3. Smart Academic Dashboard
- **Campus Hero:** Dynamic university landmark banner with real-time weather and semester telemetry (`Central University • Spring '26`).
- **Live Next Class Card:** Real-time countdown widget (`In 15m`), course title, instructor, room code, and class state.
- **8-Tile Quick Actions Grid:** Rapid navigation to Notices, Classes, Attendance (with live 94% badge), Results, Assignments, Events, Profile, and More.
- **Featured University Events:** Interactive registration banner for major campus happenings (e.g., Annual AI & Robotics Hackathon 2026).
- **Full Dark & Light Themes:** Toggleable via the top navigation bar with complete palette adaptation across cards, text, and icons.

### 4. Interactive Routine & Schedule
- **5-Day Horizontal Date Selector:** Animated date strip with active day highlighting and today indicators.
- **Live Ongoing Lecture Tracking:** Highlights ongoing classes with elapsed time bars, professor information, room details, and indoor wayfinding modals.
- **Lecture Notes & Rubric Downloads:** Quick attachment downloads and grading rubric inspections directly from the timeline.
- **Complete Dark Mode Support:** Deep obsidian surfaces, neon green live badges, and contrast-optimized readability.

### 5. Attendance Analytics & Simulation
- **Circular Attendance Gauge:** High-resolution SVG-style 89% visual gauge with safe-zone indicators.
- **Safe-Zone Absence Calculator:** Real-time calculation showing how many lectures can be safely missed without falling below university requirements.
- **QR / Barcode Check-In:** Rapid attendance logging via camera scanner.

### 6. Digital PVC Student ID Card
- **Emulated PVC Card:** Authentic student card render with photo, university crest, student ID number, barcode, and QR code.
- **Contactless NFC Pass:** Emulated contactless turnstile/library access pass.

---

## 🏗️ Software Architecture

The application strictly implements **Clean Architecture** combined with **MVVM (Model-View-ViewModel)** using **BLoC / Cubit** in a **feature-first** modular layout:

```
lib/
├── app.dart                          # Root MaterialApp & global theme configuration
├── injection_container.dart          # Service Locator (get_it) dependency wiring
├── main.dart                         # Entry point & platform initialization
│
├── core/                             # Cross-cutting concerns & shared foundations
│   ├── constants/                    # Colors, typography, asset paths, strings
│   ├── error/                        # Failures (Domain) and Exceptions (Data)
│   ├── routes/                       # AppRoutes & navigation route generator
│   ├── theme/                        # AppTheme (Light/Dark) & ThemeCubit
│   ├── usecases/                     # Base UseCase<Type, Params> contracts
│   └── widgets/                      # Shared reusable UI atoms & molecules
│
└── features/                         # Feature-first modular layers
    ├── auth/                         # Authentication & Biometrics
    ├── onboarding/                   # Onboarding carousel & lifecycle persistence
    ├── splash/                       # Initial route resolver & launcher router
    ├── dashboard/                    # Campus home & quick actions
    ├── routine/                      # Timetable, live lectures, schedule
    ├── attendance/                   # Circular gauge & simulation
    ├── profile/                      # Digital PVC Student ID & settings
    └── navigation/                   # Root bottom navigation shell
```

Each feature adheres to the strict 3-tier boundary:
```
feature/
├── data/
│   ├── datasources/                  # Local (SharedPreferences) & Remote (API/JSON)
│   ├── models/                       # JSON serialization & Entity mappers
│   └── repositories/                 # Concrete repository implementations
├── domain/
│   ├── entities/                     # Pure business domain entities
│   ├── repositories/                 # Abstract contracts
│   └── usecases/                     # Single-purpose business transaction interactors
└── presentation/
    ├── cubit/                        # BLoC / Cubit business logic state managers
    ├── pages/                        # Screen views
    └── widgets/                      # Scoped UI components
```

For complete technical specifications, see [ARCHITECTURE.md](ARCHITECTURE.md).

---

## 🛠️ Tech Stack & Dependencies

| Category | Technology / Package | Purpose |
| :--- | :--- | :--- |
| **Framework** | Flutter 3.x / Dart 3.x | Cross-platform mobile development |
| **Architecture** | Clean Architecture (Feature-First) | Enterprise separation of concerns |
| **State Management** | `flutter_bloc` (v8.1+) | Predictable, unidirectional reactive state |
| **Dependency Injection** | `get_it` (v7.6+) | Service locator & loose coupling |
| **Functional Error Handling** | `dartz` (v0.10+) | Monadic `Either<Failure, T>` return types |
| **Value Equality** | `equatable` (v2.0+) | Value-based state & entity comparisons |
| **Typography** | `google_fonts` (Inter) | Typography system conforming to design guide |
| **Local Persistence** | `shared_preferences` | Onboarding lifecycle flags, tokens, theme mode |
| **Splash & Icons** | `flutter_native_splash`, `flutter_launcher_icons` | Zero-flicker native branding |

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>=3.3.0 <4.0.0`)
- [Dart SDK](https://dart.dev/get-dart) (`>=3.0.0 <4.0.0`)
- Android Studio / Xcode / VS Code with Flutter extensions
- A physical device or emulator/simulator (iOS / Android)

### Installation & Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ahmedsamir54/my_campus.git
   cd my_campus
   ```

2. **Install project dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify code quality:**
   ```bash
   flutter analyze
   ```
   *(Expected: `No issues found!`)*

4. **Execute test suite:**
   ```bash
   flutter test
   ```
   *(Expected: `All 26 tests passed!`)*

5. **Launch the application:**
   ```bash
   flutter run
   ```

---

## 🧪 Testing & Code Quality

The codebase enforces strict test coverage across data parsing, repository implementations, domain use cases, and cubit state transitions:

```text
00:01 +26: All tests passed!
```

Key test suites include:
- `test/features/onboarding/onboarding_test.dart` — Single-display lifecycle persistence logic.
- `test/features/auth/auth_test.dart` — Credential & biometric login flow and session caching.
- `test/features/splash/splash_test.dart` — Initial route resolution to Onboarding, Login, or Dashboard.
- `test/features/attendance/attendance_test.dart` — Absence projection & safe-zone calculation.
- `test/features/routine/routine_test.dart` — Daily lecture parsing & schedule switching.
- `test/features/profile/profile_test.dart` — Student ID serialization and local preferences.

---

## 📝 Recent Development Milestones

- **Production APK Release Compilation:** Compiled standalone release APK (`56.5 MB`) for evaluator testing and direct device side-loading.
- **Native App Launcher Icon & Splash Unification:** Embedded the custom SoftTaqwa University green graduation badge as the native app icon and eliminated secondary splash flicker.
- **Onboarding Single-Display Lifecycle:** Enforced `kHasCompletedOnboarding` flag in local persistence to ensure first-time onboarding displays only once.
- **Complete Dashboard Dark Mode:** Full adaptation of the campus hero, quick action cards, next class widget, and typography to obsidian and deep emerald surfaces.
- **Routine & Schedule Dark Mode:** Implemented dark mode across the timetable strip, active ongoing class card with live indicators, and upcoming lecture cards.
- **Avatar Styling Refinement:** Restored the clean icon avatar aesthetic with dynamic online status badge.

---

## 📄 License & Intellectual Property

This project is developed for **SoftTaqwa University**. All university trademarks, logos, and UI designs belong to their respective copyright holders.
