import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:alpha_memoria/app.dart';
import 'package:alpha_memoria/data/mock/mock_alert_repository.dart';
import 'package:alpha_memoria/data/mock/mock_auth_repository.dart';
import 'package:alpha_memoria/data/mock/mock_booking_repository.dart';
import 'package:alpha_memoria/data/mock/mock_package_repository.dart';
import 'package:alpha_memoria/providers/alert_provider.dart';
import 'package:alpha_memoria/providers/auth_provider.dart';
import 'package:alpha_memoria/providers/booking_provider.dart';
import 'package:alpha_memoria/providers/package_provider.dart';

void main() {
  testWidgets('Alpha Memoria App loads welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider(authRepository: MockAuthRepository())),
          ChangeNotifierProvider(create: (_) => PackageProvider(packageRepository: MockPackageRepository())),
          ChangeNotifierProvider(create: (_) => BookingProvider(bookingRepository: MockBookingRepository())),
          ChangeNotifierProvider(create: (_) => AlertProvider(alertRepository: MockAlertRepository())),
        ],
        child: const AlphaMemoriaApp(),
      ),
    );

    expect(find.text('Alpha Memoria'), findsWidgets);
  });
}
