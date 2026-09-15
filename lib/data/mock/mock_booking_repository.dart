import '../repositories/booking_repository.dart';
import '../../models/booking_model.dart';

class MockBookingRepository implements BookingRepository {
  final List<BookingModel> _mockBookings = [
    BookingModel(
      id: 'bk_1001',
      referenceCode: '#LM-8926',
      packageId: 'pkg_2',
      packageName: 'Premium 3-Hour Unlimited',
      date: DateTime(2026, 10, 24),
      timeSlot: '4:00 PM - 6:00 PM',
      venueLocation: 'The Grand Plaza Ballroom (Central Hall)',
      guestCount: 50,
      eventType: "Matteo's 18th Celebration",
      specialRequests: 'Early Setup arrives at 2:30 PM',
      frameTheme: 'Minimalist',
      primaryColorHex: '0xFF0A3B72',
      customHeadingText: "Matteo's 18th Birthday",
      fontStyle: 'Modern Sans',
      receiptFileName: 'receipt_gcash_20261024.jpg',
      totalAmount: 12500,
      status: 'Pending',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    BookingModel(
      id: 'bk_1002',
      referenceCode: '#AM-89412',
      packageId: 'pkg_1',
      packageName: 'Package 1 (2-Hour Rent)',
      date: DateTime(2026, 11, 15),
      timeSlot: '2:00 PM - 4:00 PM',
      venueLocation: 'The Manor Glass Pavilion',
      guestCount: 100,
      eventType: "Sarah & Mark's Wedding",
      specialRequests: 'Please place the photo booth near the entrance.',
      frameTheme: 'Elegant Floral',
      primaryColorHex: '0xFF0A3B72',
      customHeadingText: 'Sarah & Mark Forever',
      fontStyle: 'Elegant Script',
      receiptFileName: 'receipt_transfer_bdo.pdf',
      totalAmount: 9500,
      status: 'Approved',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    BookingModel(
      id: 'bk_1003',
      referenceCode: '#NX-55201',
      packageId: 'pkg_3',
      packageName: 'Deluxe Celebration Package',
      date: DateTime(2026, 12, 10),
      timeSlot: '6:00 PM - 10:00 PM',
      venueLocation: 'Grand Hyatt Grand Ballroom',
      guestCount: 150,
      eventType: 'NexTech Year-End Gala',
      specialRequests: 'Custom corporate branding overlay needed.',
      frameTheme: 'Glam Gold',
      primaryColorHex: '0xFF0A3B72',
      customHeadingText: 'NexTech 2026 Excellence',
      fontStyle: 'Modern Sans',
      receiptFileName: 'corporate_po_transfer.pdf',
      totalAmount: 18000,
      status: 'Pending',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
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
