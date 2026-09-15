import 'package:flutter/material.dart';
import '../../models/booking_model.dart';
import '../../screens/welcome/welcome_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/main_navigation_screen.dart';
import '../../screens/package/package_detail_screen.dart';
import '../../screens/booking/select_package_screen.dart';
import '../../screens/booking/secure_date_screen.dart';
import '../../screens/booking/events_detail_screen.dart';
import '../../screens/booking/payment_screen.dart';
import '../../screens/booking/customize_design_screen.dart';
import '../../screens/booking/checkout_screen.dart';
import '../../screens/booking_confirmed/booking_confirmed_screen.dart';
import '../../screens/appointment/appointment_screen.dart';
import '../../screens/alerts/alerts_screen.dart';
import '../../screens/profile/profile_screen.dart';

import '../../screens/profile/personal_information_screen.dart';
import '../../screens/profile/my_bookings_screen.dart';
import '../../screens/profile/payment_methods_screen.dart';
import '../../screens/profile/app_settings_screen.dart';
import '../../screens/profile/support_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String mainNav = '/main-nav';
  static const String selectPackage = '/select-package';
  static const String packageDetail = '/package-detail';
  static const String secureDate = '/secure-date';
  static const String eventsDetail = '/events-detail';
  static const String payment = '/payment';
  static const String customizeDesign = '/customize-design';
  static const String checkout = '/checkout';
  static const String bookingConfirmed = '/booking-confirmed';
  static const String appointment = '/appointment';
  static const String alerts = '/alerts';
  static const String profile = '/profile';
  static const String personalInfo = '/personal-info';
  static const String myBookings = '/my-bookings';
  static const String paymentMethods = '/payment-methods';
  static const String appSettings = '/app-settings';
  static const String support = '/support';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case mainNav:
        final initialTab = settings.arguments as int? ?? 0;
        return MaterialPageRoute(
          builder: (_) => MainNavigationScreen(initialTab: initialTab),
        );
      case selectPackage:
        return MaterialPageRoute(
          builder: (_) => const SelectPackageScreen(showBackButton: true),
        );
      case packageDetail:
        return MaterialPageRoute(builder: (_) => const PackageDetailScreen());
      case secureDate:
        return MaterialPageRoute(builder: (_) => const SecureDateScreen());
      case eventsDetail:
        return MaterialPageRoute(builder: (_) => const EventsDetailScreen());
      case payment:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case customizeDesign:
        return MaterialPageRoute(builder: (_) => const CustomizeDesignScreen());
      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case bookingConfirmed:
        final booking = settings.arguments as BookingModel?;
        return MaterialPageRoute(
          builder: (_) => BookingConfirmedScreen(booking: booking),
        );
      case appointment:
        return MaterialPageRoute(builder: (_) => const AppointmentScreen());
      case alerts:
        return MaterialPageRoute(builder: (_) => const AlertsScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case personalInfo:
        return MaterialPageRoute(builder: (_) => const PersonalInformationScreen());
      case myBookings:
        return MaterialPageRoute(builder: (_) => const MyBookingsScreen());
      case paymentMethods:
        return MaterialPageRoute(builder: (_) => const PaymentMethodsScreen());
      case appSettings:
        return MaterialPageRoute(builder: (_) => const AppSettingsScreen());
      case support:
        return MaterialPageRoute(builder: (_) => const SupportScreen());
      default:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
    }
  }
}
