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
  - [app_colors.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/core/constants/app_colors.dart): Brand palette (`primary` blue, neutral grays, surface whites, and status colors).
  - [app_text_styles.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/core/constants/app_text_styles.dart): GoogleFonts typography (Outfit for headings, Inter for body text).
  - `app_constants.dart`: Global app strings, default values, and configurations.
- 🛣️ **`core/routes/`**
  - [app_routes.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/core/routes/app_routes.dart): Route constants and `onGenerateRoute` switch logic for screen transitions.
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
  - [mock_auth_repository.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/data/mock/mock_auth_repository.dart): Mock auth implementation for offline development.
  - [mock_booking_repository.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/data/mock/mock_booking_repository.dart): In-memory booking list with status updates (`Pending`, `Confirmed`, `Cancelled`).
  - `mock_package_repository.dart`: Catalog of photo booth packages (Starter, Celebration, VIP Gala).
  - `mock_alert_repository.dart`: Sample notification alerts.

---

### 3. `lib/models/` — Data Entities
Immutable Dart models representing domain entities with JSON serialization support (`fromJson` / `toJson`).

- `user_model.dart`: Represents user account profile details (`fullName`, email, phone, birthday).
- `booking_model.dart`: Complete booking order data (package, date, time slot, venue, theme, total amount, status).
- `package_model.dart`: Photo booth package details (name, price, features list, badge tag).
- `alert_model.dart`: System notification alerts with timestamps and read states.

---

### 4. `lib/providers/` — State Management
`ChangeNotifier` providers initialized in `main.dart` driving reactive UI updates across the app.

- [auth_provider.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/providers/auth_provider.dart): Manages user login, registration, current user state, and logout.
- [booking_provider.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/providers/booking_provider.dart): Manages multi-step booking stepper draft state, order creation, upcoming bookings, and `cancelBooking()`.
- `package_provider.dart`: Fetches package lists and selected package details.
- `alert_provider.dart`: Manages unread notification badges and alert list filtering.

---

### 5. `lib/screens/` — Application Views & Pages
Groups UI screens logically by feature domain.

- 🚪 **`screens/welcome/`** & **`screens/auth/`**
  - `welcome_screen.dart`: Onboarding welcome hero screen.
  - `login_screen.dart`: User sign-in screen.
  - `register_screen.dart`: New account registration screen.
- 🏠 **`screens/home/`**
  - `home_screen.dart`: Dashboard featuring hero banners, package carousels, and search.
- 📦 **`screens/package/`**
  - `package_detail_screen.dart`: Full package feature breakdown & selection.
- 📅 **`screens/booking/`** & **`screens/booking_confirmed/`**
  - `select_package_screen.dart`: Step 1 of booking flow.
  - `secure_date_screen.dart`: Step 2 — Date, time slot, and venue selection.
  - `customize_design_screen.dart`: Step 3 — Template theme, primary color, and custom text heading.
  - `checkout_screen.dart`: Step 4 — Payment summary & receipt upload.
  - `booking_confirmed_screen.dart`: Post-checkout order confirmation with reference code.
- 🔔 **`screens/alerts/`**
  - `alerts_screen.dart`: Notifications dashboard with filterable alert tiles.
- 👤 **`screens/profile/`** (User Profile & 5 Detail Screens)
  - [profile_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/profile_screen.dart): Main profile menu hub.
  - [personal_information_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/personal_information_screen.dart): Edit Full Name, Email, Phone Number, and Date of Birth.
  - [my_bookings_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/my_bookings_screen.dart): "Upcoming" vs "Past" text tabs, event details sheet, and **Booking Cancellation**.
  - [payment_methods_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/payment_methods_screen.dart): Saved credit cards, default card badge, and Add New Card modal sheet.
  - [app_settings_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/app_settings_screen.dart): Notifications toggle switch, Language & Theme pickers, Privacy & Security settings.
  - [support_screen.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/screens/profile/support_screen.dart): Minimal top search bar, real-time topic search, FAQs, Live Chat, Bug Report.

---

### 6. `lib/widgets/` — Reusable Components & Layout
Modular widgets ensuring visual consistency and adherence to the app's design system.

- 🖼️ **`widgets/booking/`**
  - `booking_stepper.dart`: Top progress indicator for the 4-step booking workflow.
  - `color_picker.dart`: Interactive palette picker for customizing photo booth frame colors.
  - `live_frame_preview.dart`: Real-time rendering of customized photo booth frame design.
- 🧱 **`widgets/common/`**
  - `app_avatar.dart`: User profile avatar with initials fallback.
  - `app_button.dart`: Styled primary, secondary, and outlined buttons.
  - `app_card.dart`: Container card with rounded corners, subtle shadows, and clean borders.
  - `app_text_field.dart`: Standardized text input fields with icons and validation.
- 🎪 **`widgets/home/`**
  - `hero_banner.dart`, `featured_packages_carousel.dart`, `trending_designs_grid.dart`, `home_search_bar.dart`.
- 📐 **`widgets/layout/`**
  - [app_top_bar.dart](file:///c:/Users/user/Desktop/alpha_memoria/lib/widgets/layout/app_top_bar.dart): Standardized app top bar with title, back button, and actions.
  - `bottom_nav_bar.dart`: Bottom tab bar navigating between Home, Booking, Alerts, and Profile.
