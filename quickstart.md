# Quickstart Guide - Alpha Memoria App

Welcome to **Alpha Memoria**, a premium event & photo booth booking application built with Flutter.

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: `>=3.0.0` (Dart SDK `>=3.0.0`)
- **IDE**: VS Code, Android Studio, or IntelliJ IDEA with Flutter extensions installed.

### Installation & Run Commands

1. **Get Dependencies**
   ```bash
   flutter pub get
   ```

2. **Run Application**
   ```bash
   # Run on connected device or default emulator
   flutter run

   # Run specifically on Chrome (Web)
   flutter run -d chrome
   ```

3. **Static Analysis & Verification**
   ```bash
   flutter analyze
   ```

---

## 🏗️ Project Architecture & Key Files

The codebase follows a modular layered architecture combining **Providers** for state management, **Repositories** for data access, and reusable **Widgets/Screens**.

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart        # Unified brand color palette
│   │   └── app_text_styles.dart    # GoogleFonts (Outfit & Inter) typography
│   └── routes/
│       └── app_routes.dart        # Central route registry & navigator
├── models/                        # Data models (User, Booking, Package, Alert)
├── providers/                     # State management (Auth, Booking, Package, Alert)
├── screens/
│   ├── profile/                   # User Profile & 5 Detail Screens
│   │   ├── profile_screen.dart             # Main profile menu
│   │   ├── personal_information_screen.dart # Edit Name, Email, Phone, DOB
│   │   ├── my_bookings_screen.dart          # Upcoming & Past tabs + Cancellation
│   │   ├── payment_methods_screen.dart      # Saved cards & Add New Card modal
│   │   ├── app_settings_screen.dart         # Notifications toggle, Language, Theme
│   │   └── support_screen.dart              # Search bar, FAQs, Live Chat, Bug Report
│   ├── home/                      # Home dashboard & package browsing
│   └── booking/                   # Multi-step booking stepper flow
└── widgets/                       # Reusable design system components
```

---

## 📱 Profile Sub-Screens Overview

All 5 profile screens follow a unified design system:
- **Clean white background** (`#FFFFFF`) with light-gray row dividers (`#E2E8F0`).
- **Rounded blue icon badges** (`AppColors.primaryLight` background, `AppColors.primary` icon).
- **Bold dark titles** with light-gray subtitles.
- **Chevrons on the right** (`Icons.chevron_right_rounded`).

| Screen | File Link | Primary Features |
| :--- | :--- | :--- |
| **Personal Info** | [personal_information_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/personal_information_screen.dart) | Editable rows for Full Name, Email, Phone, Date of Birth + Bottom "Save Changes" button |
| **My Bookings** | [my_bookings_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/my_bookings_screen.dart) | "Upcoming" vs "Past" underline text tabs, event details sheet, **Booking Cancellation** |
| **Payment Methods**| [payment_methods_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/payment_methods_screen.dart) | Saved credit/debit card rows, Default card badge, interactive **Add New Card** sheet |
| **App Settings** | [app_settings_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/app_settings_screen.dart) | Adaptive **Notifications** toggle switch, Language & Theme pickers, Privacy & Security options |
| **Support** | [support_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/support_screen.dart) | Minimal top search bar, real-time topic filtering, FAQs, Live Chat, Report a Problem |

---

## 🗺️ Route Navigation Map

- `/` → Welcome Screen
- `/login` → Login Screen
- `/register` → Registration Screen
- `/main-nav` → Main Dashboard (Home, Booking, Alerts, Profile)
- `/profile` → Profile Dashboard ([profile_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/profile_screen.dart))
  - `/personal-info` → [PersonalInformationScreen](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/personal_information_screen.dart)
  - `/my-bookings` → [MyBookingsScreen](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/my_bookings_screen.dart)
  - `/payment-methods` → [PaymentMethodsScreen](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/payment_methods_screen.dart)
  - `/app-settings` → [AppSettingsScreen](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/app_settings_screen.dart)
  - `/support` → [SupportScreen](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/support_screen.dart)
