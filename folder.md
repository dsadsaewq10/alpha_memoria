# Folder Structure - `lib` Directory Overview

This document provides a detailed breakdown of the `lib/` directory structure for the **Alpha Memoria** Flutter application.

---

## 📁 Root Directory Layout (`lib/`)

```
lib/
├── app.dart                   # MaterialApp root configuration, theme, & route binding
├── main.dart                  # Entry point with MultiProvider initialization
├── core/                      # Global constants, design tokens, routes, and utilities
├── data/                      # Data layer (Abstract repositories & mock implementations)
├── models/                    # Data transfer objects & entity models
├── providers/                 # State management (ChangeNotifier providers)
├── screens/                   # User interface pages & sub-screens
└── widgets/                   # Reusable UI components & layout elements
```

---

## 🔍 Detailed Folder Breakdown

### 1. `lib/core/` — Design Tokens & Core Infrastructure
Contains global configuration parameters, brand constants, navigation routing, and shared helper functions.

- 🎨 **`core/constants/`**
  - [app_colors.dart](file:///c:/Users/user/alpha_memoria/lib/core/constants/app_colors.dart): Brand palette (Primary dark navy `#0A3B72`, badge tokens `#E0EDFB`, neutral grays `#E2E8F0`, and status colors).
  - [app_text_styles.dart](file:///c:/Users/user/alpha_memoria/lib/core/constants/app_text_styles.dart): GoogleFonts typography (Outfit for headings, Inter for body text).
  - `app_constants.dart`: Global app strings, default values, and configurations.
- 🛣️ **`core/routes/`**
  - [app_routes.dart](file:///c:/Users/user/alpha_memoria/lib/core/routes/app_routes.dart): Route constants and `onGenerateRoute` switch logic for screen transitions.
- 🛠️ **`core/utils/`**
  - Formatting helpers (dates, currency, string formatters).

---

### 2. `lib/data/` — Data Access Layer
Implements repository interfaces decoupling data fetching from business logic and state providers.

- 🔌 **`data/repositories/`** (Abstract Interfaces)
  - `auth_repository.dart`: User authentication & session management interface.
  - `booking_repository.dart`: Event booking CRUD interface.
  - `package_repository.dart`: Package catalog fetching interface.
  - `alert_repository.dart`: System alerts & notifications interface.
- 🧪 **`data/mock/`** (Mock Implementations)
  - [mock_auth_repository.dart](file:///c:/Users/user/alpha_memoria/lib/data/mock/mock_auth_repository.dart): Mock auth implementation for offline development.
  - [mock_booking_repository.dart](file:///c:/Users/user/alpha_memoria/lib/data/mock/mock_booking_repository.dart): In-memory booking list with multi-appointment mock data (`#LM-8926`, `#AM-89412`, `#NX-55201`).
  - `mock_package_repository.dart`: Catalog of photo booth packages (Package 1, Package 2, Celebration, VIP Gala).
  - `mock_alert_repository.dart`: Sample notification alerts.

---

### 3. `lib/models/` — Data Entities
Immutable Dart models representing domain entities with JSON serialization support (`fromJson` / `toJson`).

- `user_model.dart`: Represents user account profile details (`fullName`, email, phone, birthday).
- `booking_model.dart`: Complete booking order data (package, date, time slot, venue, theme, receipt file name, total amount, status).
- `package_model.dart`: Photo booth package details (name, price, features list, badge tag).
- `alert_model.dart`: System notification alerts with timestamps and read states.

---

### 4. `lib/providers/` — State Management
`ChangeNotifier` providers initialized in `main.dart` driving reactive UI updates across the app.

- [auth_provider.dart](file:///c:/Users/user/alpha_memoria/lib/providers/auth_provider.dart): Manages user login, registration, current user state, and logout.
- [booking_provider.dart](file:///c:/Users/user/alpha_memoria/lib/providers/booking_provider.dart): Manages the 4-step booking flow draft state, receipt upload attachment, order creation, active bookings list, and `cancelBooking()`.
- `package_provider.dart`: Fetches package lists and selected package details.
- `alert_provider.dart`: Manages unread notification badges and alert list filtering.

---

### 5. `lib/screens/` — Application Views & Pages
Groups UI screens logically by feature domain.

- 🚪 **`screens/welcome/`** & **`screens/auth/`**
  - `welcome_screen.dart`: Onboarding welcome hero screen.
  - `login_screen.dart`: User sign-in screen.
  - `register_screen.dart`: New account registration screen.
  - `forgot_password_screen.dart`: Password recovery screen.

- 🏠 **`screens/home/`**
  - [home_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/home/home_screen.dart): Preserved original Home dashboard featuring active appointment card, progress tracking, and design showcases.

- 📅 **`screens/booking/`** (The 4-Step Booking Flow)
  - [select_package_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking/select_package_screen.dart): **Step 1 of 4** — Package 1 (₱9,500) & Package 2 (₱12,500) cards with responsive layout (2-column on desktop/tablet, stacked on mobile).
  - [secure_date_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking/secure_date_screen.dart): **Step 2 of 4** — Date & time slot selection with month chevrons, interactive Month & Year picker sheet, year jump dialog, dynamic calendar grid, and clickable Start/End time pickers.
  - [events_detail_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking/events_detail_screen.dart): **Step 3 of 4** — Event type dropdown, event name, theme, location pin, venue, guest count stepper (`- 50 +`), client contact info, and crew notes.
  - [payment_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking/payment_screen.dart): **Step 4 of 4** — Custom QR code card with GCash & Maya copyable numbers, and interactive click-to-upload dashed receipt box supporting **JPG, PNG, and PDF** formats with validation.
  - `checkout_screen.dart`: Alternate payment checkout summary.
  - `customize_design_screen.dart`: Design frame personalization screen.

- 🎉 **`screens/booking_confirmed/`**
  - [booking_confirmed_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/booking_confirmed/booking_confirmed_screen.dart): Confirmation celebration card, booking reference, countdown pill, "What Happens Next" verification step, and navigation to appointments.

- 📋 **`screens/appointment/`**
  - [appointment_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/appointment/appointment_screen.dart): Multi-appointment management tab showing all active bookings with status pills, duration cards, package summaries, and responsive dual-column desktop layout.

- 👤 **`screens/profile/`** (User Profile & 5 Detail Screens)
  - [profile_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/profile_screen.dart): Main profile menu hub.
  - [personal_information_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/personal_information_screen.dart): Edit Full Name, Email, Phone Number, and Date of Birth.
  - [my_bookings_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/my_bookings_screen.dart): "Upcoming" vs "Past" text tabs, event details sheet, and booking cancellation.
  - [payment_methods_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/payment_methods_screen.dart): Saved credit cards, default card badge, and Add New Card modal sheet.
  - [app_settings_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/app_settings_screen.dart): Notifications toggle switch, Language & Theme pickers, Privacy & Security settings.
  - [support_screen.dart](file:///c:/Users/user/alpha_memoria/lib/screens/profile/support_screen.dart): Minimal top search bar, real-time topic search, FAQs, Live Chat, Bug Report.

- 🔔 **`screens/alerts/`** & 📦 **`screens/package/`**
  - `alerts_screen.dart`: Notifications dashboard with filterable alert tiles.
  - `package_detail_screen.dart`: Detailed package overview with feature specifications.

- 🧭 **`screens/main_navigation_screen.dart`**
  - Central bottom navigation hub hosting Tab 0 (Home), Tab 1 (Bookings), Tab 2 (Appointment), and Tab 3 (Profile).

---

### 6. `lib/widgets/` — Reusable Components & Layout
Modular widgets ensuring visual consistency and adherence to the app's design system.

- 🖼️ **`widgets/booking/`**
  - [booking_stepper.dart](file:///c:/Users/user/alpha_memoria/lib/widgets/booking/booking_stepper.dart): Top progress indicator for the 4-step booking workflow with navy fill.
  - `calendar_picker.dart`: Modular date selection grid.
  - `color_picker.dart`: Interactive palette picker for customizing photo booth frame colors.
  - `live_frame_preview.dart`: Real-time rendering of customized photo booth frame design.
  - `theme_selector.dart`: Frame theme style selector.
  - `time_slot_picker.dart`: Morning/Afternoon/Evening time slot selector.

- 📐 **`widgets/layout/`**
  - [app_top_bar.dart](file:///c:/Users/user/alpha_memoria/lib/widgets/layout/app_top_bar.dart): Standardized app top bar with bold navy "Alpha Memoria" branding.
  - [bottom_nav_bar.dart](file:///c:/Users/user/alpha_memoria/lib/widgets/layout/bottom_nav_bar.dart): Custom 4-tab bottom navigation bar with dark navy blue active pill.

- 🧱 **`widgets/common/`**
  - `app_avatar.dart`, `app_button.dart`, `app_card.dart`, `app_text_field.dart`.

- 🎪 **`widgets/home/`**
  - `hero_banner.dart`, `featured_packages_carousel.dart`, `trending_designs_grid.dart`, `home_search_bar.dart`.
