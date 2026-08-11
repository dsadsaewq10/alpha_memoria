import '../../models/booking_model.dart';

abstract class BookingRepository {
  Future<List<BookingModel>> getBookings();
  Future<BookingModel?> getUpcomingBooking();
  Future<BookingModel> createBooking(BookingModel booking);
  Future<BookingModel> updateBookingStatus(String bookingId, String status);
}
