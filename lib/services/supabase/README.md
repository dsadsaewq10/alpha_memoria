# Supabase Backend Integration Guide for Alpha Memoria

This project uses an abstract repository pattern (`lib/data/repositories/`) with initial mock implementations (`lib/data/mock/`).

## How to Plug in Supabase:

1. **Add Dependency**:
   In `pubspec.yaml`, add:
   ```yaml
   dependencies:
     supabase_flutter: ^2.0.0
   ```

2. **Initialize Supabase**:
   In `lib/main.dart` or `lib/services/supabase/supabase_client.dart`:
   ```dart
   await Supabase.initialize(
     url: 'https://xyzcompany.supabase.co',
     anonKey: 'public-anon-key',
   );
   ```

3. **Create Supabase Repositories**:
   Create real repository classes in `lib/data/supabase/`:
   - `supabase_auth_repository.dart` implementing `AuthRepository`
   - `supabase_package_repository.dart` implementing `PackageRepository`
   - `supabase_booking_repository.dart` implementing `BookingRepository`
   - `supabase_alert_repository.dart` implementing `AlertRepository`

4. **Swap Providers in `lib/main.dart`**:
   Replace:
   ```dart
   AuthRepository authRepo = MockAuthRepository();
   ```
   with:
   ```dart
   AuthRepository authRepo = SupabaseAuthRepository();
   ```

**Zero UI Changes Required**: None of the Flutter screens or UI components (`lib/screens/`, `lib/widgets/`) need to be touched during the backend migration!
