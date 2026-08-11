import '../repositories/booking_repository.dart';
import '../../models/booking_model.dart';

class MockBookingRepository implements BookingRepository {
  final List<BookingModel> _mockBookings = [
    BookingModel(
      id: 'bk_1001',
      referenceCode: '#AM-89412',
      packageId: 'pkg_starter',
      packageName: 'Starter Celebration',
      date: DateTime.now().add(const Duration(days: 12)),
      timeSlot: '02:00 PM',
      venueLocation: 'The Grand Plaza, Central Hall',
      guestCount: 80,
      eventType: "Sarah's Wedding",
      specialRequests: 'Please place the photo booth near the entrance.',
      frameTheme: 'Minimalist',
      primaryColorHex: '0xFF0066FF',
      customHeadingText: 'Happy 30th Birthday Juanita!',
      fontStyle: 'Elegant Script',
      receiptFileName: 'receipt_transfer_bank.pdf',
      totalAmount: 199,
      status: 'Pending',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Future<List<BookingModel>> getBookings() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockBookings;
  }

  @override
  Future<BookingModel?> getUpcomingBooking() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (_mockBookings.isEmpty) return null;
    return _mockBookings.first;
  }

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _mockBookings.insert(0, booking);
    return booking;
  }

  @override
  Future<BookingModel> updateBookingStatus(String bookingId, String status) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _mockBookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      final old = _mockBookings[index];
      final updated = BookingModel(
        id: old.id,
        referenceCode: old.referenceCode,
        packageId: old.packageId,
        packageName: old.packageName,
        date: old.date,
        timeSlot: old.timeSlot,
        venueLocation: old.venueLocation,
        guestCount: old.guestCount,
        eventType: old.eventType,
        specialRequests: old.specialRequests,
        frameTheme: old.frameTheme,
        primaryColorHex: old.primaryColorHex,
        customHeadingText: old.customHeadingText,
        fontStyle: old.fontStyle,
        receiptFileName: old.receiptFileName,
        totalAmount: old.totalAmount,
        status: status,
        createdAt: old.createdAt,
      );
      _mockBookings[index] = updated;
      return updated;
    }
    throw Exception('Booking not found');
  }
}
