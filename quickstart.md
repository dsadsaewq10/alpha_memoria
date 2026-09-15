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

   # Run specifically on Windows Desktop
   flutter run -d windows
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
├── app.dart                   # MaterialApp root configuration, theme, & route binding
├── main.dart                  # Entry point with MultiProvider initialization
├── core/
│   ├── constants/
│   │   ├── app_colors.dart        # Brand color tokens (dark navy #0A3B72, accents, badges)
│   │   └── app_text_styles.dart    # GoogleFonts (Outfit & Inter) typography
│   └── routes/
│       └── app_routes.dart        # Central route registry & navigator
├── data/
│   ├── mock/                      # Mock repositories (auth, bookings, packages, alerts)
│   └── repositories/              # Abstract repository interfaces
├── models/                        # Data models (User, Booking, Package, Alert)
├── providers/                     # State management (Auth, Booking, Package, Alert)
├── screens/
│   ├── appointment/               # Multi-appointment tracker screen & responsive views
│   ├── booking/                   # 4-step booking flow (Select, Date, Details, Payment)
│   ├── booking_confirmed/         # Order confirmation & status screen
│   ├── home/                      # Preserved Home screen dashboard
│   ├── profile/                   # User Profile & 5 Detail Screens
│   └── welcome/ & auth/           # Onboarding, Login, & Registration screens
└── widgets/                       # Reusable design system components
    ├── booking/                   # Booking stepper, calendar, & design previewers
    └── layout/                    # AppTopBar and BottomNavBar
```

---

## 📱 Core Features & Screens

### 1. 📅 4-Step Booking Flow (Bookings Tab)
| Step | Screen | File Link | Key Features |
| :--- | :--- | :--- | :--- |
| **Step 1** | **Select Package** | [select_package_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking/select_package_screen.dart) | Package 1 (₱9,500) & Package 2 (₱12,500) with photo cards, feature bullet points, and responsive 2-column or stacked layout |
| **Step 2** | **Secure Your Date** | [secure_date_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking/secure_date_screen.dart) | Dynamic calendar with month chevrons (`<` `>`), interactive **Month & Year Picker** sheet, 20-year jump dialog, dynamic calendar grid, and clickable Start/End time pickers |
| **Step 3** | **Events Detail** | [events_detail_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking/events_detail_screen.dart) | Event type dropdown, event name, theme, location pin, venue, guest count stepper (`- 50 +`), client contact info, and crew notes |
| **Step 4** | **Payment** | [payment_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking/payment_screen.dart) | Dark card with custom QR code, GCash & Maya copyable numbers, and interactive **Click-to-Upload** receipt box supporting **JPG, PNG, and PDF** formats with validation |
| **Success** | **Booking Confirmed** | [booking_confirmed_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking_confirmed/booking_confirmed_screen.dart) | Celebration icon, booking summary card, reference code, countdown pill, "What Happens Next" verification step, and navigation to appointments |

### 2. 📋 Multi-Appointment Management (Appointment Tab)
- **File**: [appointment_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/appointment/appointment_screen.dart)
- Displays **all active bookings** for the user (`#LM-8926`, `#AM-89412`, `#NX-55201` + new bookings).
- **Mobile View**: Horizontal appointment selector chips with status indicators (Green for Approved, Amber for Pending). Detailed cards for date, duration, venue, and progress tracking.
- **Tablet / Desktop / Web View**: Responsive 2-column split view (left: appointment list, right: comprehensive appointment details).

### 3. 👤 Profile Sub-Screens
| Screen | File Link | Primary Features |
| :--- | :--- | :--- |
| **Personal Info** | [personal_information_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/personal_information_screen.dart) | Editable rows for Full Name, Email, Phone, Date of Birth + "Save Changes" |
| **My Bookings** | [my_bookings_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/my_bookings_screen.dart) | "Upcoming" vs "Past" tabs, event details sheet, and booking cancellation |
| **Payment Methods**| [payment_methods_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/payment_methods_screen.dart) | Saved cards, Default card badge, and interactive Add New Card sheet |
| **App Settings** | [app_settings_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/app_settings_screen.dart) | Notifications switch, Language & Theme pickers, Privacy options |
| **Support** | [support_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/support_screen.dart) | Topic search bar, FAQs, Live Chat, Bug Report |

---

## 🗺️ Route Navigation Map

- `/` → Welcome Screen ([welcome_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/welcome/welcome_screen.dart))
- `/login` → Login Screen ([login_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/auth/login_screen.dart))
- `/register` → Registration Screen ([register_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/auth/register_screen.dart))
- `/main-nav` → Main Navigation Dashboard ([main_navigation_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/main_navigation_screen.dart))
  - Tab 0: Home ([home_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/home/home_screen.dart))
  - Tab 1: Bookings ([select_package_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking/select_package_screen.dart))
  - Tab 2: Appointment ([appointment_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/appointment/appointment_screen.dart))
  - Tab 3: Profile ([profile_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/profile_screen.dart))
- **Booking Flow Routes**:
  - `/select-package` → [SelectPackageScreen](file:///c:/Users/user/alpha_memoria/lib/screens/booking/select_package_screen.dart) (Step 1 of 4)
  - `/secure-date` → [SecureDateScreen](file:///c:/Users/user/alpha_memoria/lib/screens/booking/secure_date_screen.dart) (Step 2 of 4)
  - `/events-detail` → [EventsDetailScreen](file:///c:/Users/user/alpha_memoria/lib/screens/booking/events_detail_screen.dart) (Step 3 of 4)
  - `/payment` → [PaymentScreen](file:///c:/Users/user/alpha_memoria/lib/screens/booking/payment_screen.dart) (Step 4 of 4)
  - `/booking-confirmed` → [BookingConfirmedScreen](file:///c:/Users/user/alpha_memoria/lib/screens/booking_confirmed/booking_confirmed_screen.dart)
  - `/appointment` → [AppointmentScreen](file:///c:/Users/user/alpha_memoria/lib/screens/appointment/appointment_screen.dart)
- **Profile Detail Routes**:
  - `/personal-info` → [PersonalInformationScreen](file:///c:/Users/user/alpha_memoria/lib/screens/profile/personal_information_screen.dart)
  - `/my-bookings` → [MyBookingsScreen](file:///c:/Users/user/alpha_memoria/lib/screens/profile/my_bookings_screen.dart)
  - `/payment-methods` → [PaymentMethodsScreen](file:///c:/Users/user/alpha_memoria/lib/screens/profile/payment_methods_screen.dart)
  - `/app-settings` → [AppSettingsScreen](file:///c:/Users/user/alpha_memoria/lib/screens/profile/app_settings_screen.dart)
  - `/support` → [SupportScreen](file:///c:/Users/user/alpha_memoria/lib/screens/profile/support_screen.dart)
