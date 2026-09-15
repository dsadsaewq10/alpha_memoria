import 'package:flutter/foundation.dart';
import '../data/repositories/booking_repository.dart';
import '../models/booking_model.dart';
import '../models/package_model.dart';

class BookingProvider extends ChangeNotifier {
  final BookingRepository _bookingRepository;

  List<BookingModel> _bookings = [];
  BookingModel? _upcomingBooking;
  bool _isLoading = false;

  // Draft booking state during stepper customization
  PackageModel? _draftPackage;
  DateTime _draftDate = DateTime.now().add(const Duration(days: 14));
  String _draftTimeSlot = '02:00 PM';
  String _draftVenueLocation = '';
  int _draftGuestCount = 50;
  String _draftEventType = 'Wedding';
  String _draftSpecialRequests = '';
  String _draftFrameTheme = 'Minimalist';
  String _draftPrimaryColorHex = '0xFF0066FF';
  String _draftCustomHeadingText = 'Happy Celebration!';
  String _draftFontStyle = 'Elegant Script';
  String? _draftReceiptFileName;
  BookingModel? _lastConfirmedBooking;

  BookingProvider({required BookingRepository bookingRepository})
      : _bookingRepository = bookingRepository {
    loadBookings();
  }

  List<BookingModel> get bookings => _bookings;
  BookingModel? get upcomingBooking => _upcomingBooking;
  bool get isLoading => _isLoading;
  BookingModel? get lastConfirmedBooking => _lastConfirmedBooking;

  // Draft getters
  PackageModel? get draftPackage => _draftPackage;
  DateTime get draftDate => _draftDate;
  String get draftTimeSlot => _draftTimeSlot;
  String get draftVenueLocation => _draftVenueLocation;
  int get draftGuestCount => _draftGuestCount;
  String get draftEventType => _draftEventType;
  String get draftSpecialRequests => _draftSpecialRequests;
  String get draftFrameTheme => _draftFrameTheme;
  String get draftPrimaryColorHex => _draftPrimaryColorHex;
  String get draftCustomHeadingText => _draftCustomHeadingText;
  String get draftFontStyle => _draftFontStyle;
  String? get draftReceiptFileName => _draftReceiptFileName;

  Future<void> loadBookings() async {
    _isLoading = true;
    notifyListeners();
    try {
      _bookings = await _bookingRepository.getBookings();
      _upcomingBooking = await _bookingRepository.getUpcomingBooking();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void startNewBooking(PackageModel package) {
    _draftPackage = package;
    _draftDate = DateTime.now().add(const Duration(days: 14));
    _draftTimeSlot = '02:00 PM';
    _draftVenueLocation = 'The Grand Plaza, Central Hall';
    _draftGuestCount = 50;
    _draftEventType = 'Wedding';
    _draftSpecialRequests = '';
    _draftFrameTheme = 'Minimalist';
    _draftPrimaryColorHex = '0xFF0066FF';
    _draftCustomHeadingText = 'Happy Celebration!';
    _draftFontStyle = 'Elegant Script';
    _draftReceiptFileName = null;
    notifyListeners();
  }

  void updateDateDetails({
    required DateTime date,
    required String timeSlot,
    required String venueLocation,
    required int guestCount,
    required String eventType,
    String? specialRequests,
  }) {
    _draftDate = date;
    _draftTimeSlot = timeSlot;
    _draftVenueLocation = venueLocation;
    _draftGuestCount = guestCount;
    _draftEventType = eventType;
    _draftSpecialRequests = specialRequests ?? '';
    notifyListeners();
  }

  void updateDesignDetails({
    required String theme,
    required String colorHex,
    required String headingText,
    required String fontStyle,
  }) {
    _draftFrameTheme = theme;
    _draftPrimaryColorHex = colorHex;
    _draftCustomHeadingText = headingText;
    _draftFontStyle = fontStyle;
    notifyListeners();
  }

  void setReceiptFileName(String? fileName) {
    _draftReceiptFileName = fileName;
    notifyListeners();
  }

  Future<BookingModel> submitBookingReceipt(String? receiptFileName) async {
    _draftReceiptFileName = receiptFileName;
    return finalizeBooking();
  }

  Future<BookingModel> finalizeBooking() async {
    _isLoading = true;
    notifyListeners();

    final package = _draftPackage!;
    final refCode = '#AM-${10000 + (DateTime.now().millisecondsSinceEpoch % 89999)}';

    final newBooking = BookingModel(
      id: 'bk_${DateTime.now().millisecondsSinceEpoch}',
      referenceCode: refCode,
      packageId: package.id,
      packageName: package.name,
      date: _draftDate,
      timeSlot: _draftTimeSlot,
      venueLocation: _draftVenueLocation.isEmpty ? 'The Grand Plaza' : _draftVenueLocation,
      guestCount: _draftGuestCount,
      eventType: _draftEventType,
      specialRequests: _draftSpecialRequests,
      frameTheme: _draftFrameTheme,
      primaryColorHex: _draftPrimaryColorHex,
      customHeadingText: _draftCustomHeadingText,
      fontStyle: _draftFontStyle,
      receiptFileName: _draftReceiptFileName ?? 'payment_receipt.png',
      totalAmount: package.price,
      status: 'Pending',
      createdAt: DateTime.now(),
    );

    try {
      final confirmed = await _bookingRepository.createBooking(newBooking);
      _lastConfirmedBooking = confirmed;
      await loadBookings();
      return confirmed;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> cancelBooking(String bookingId) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _bookingRepository.updateBookingStatus(bookingId, 'Cancelled');
      await loadBookings();
      return true;
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
