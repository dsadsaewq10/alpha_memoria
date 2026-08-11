import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'data/mock/mock_alert_repository.dart';
import 'data/mock/mock_auth_repository.dart';
import 'data/mock/mock_booking_repository.dart';
import 'data/mock/mock_package_repository.dart';
import 'data/repositories/alert_repository.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/booking_repository.dart';
import 'data/repositories/package_repository.dart';
import 'providers/alert_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/booking_provider.dart';
import 'providers/package_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Instantiate Repositories (backend-ready abstraction)
  // When switching to Supabase, swap these lines to Supabase implementations:
  final AuthRepository authRepository = MockAuthRepository();
  final PackageRepository packageRepository = MockPackageRepository();
  final BookingRepository bookingRepository = MockBookingRepository();
  final AlertRepository alertRepository = MockAlertRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authRepository: authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => PackageProvider(packageRepository: packageRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingProvider(bookingRepository: bookingRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => AlertProvider(alertRepository: alertRepository),
        ),
      ],
      child: const AlphaMemoriaApp(),
    ),
  );
}
