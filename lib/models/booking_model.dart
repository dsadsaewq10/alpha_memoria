class BookingModel {
  final String id;
  final String referenceCode;
  final String packageId;
  final String packageName;
  final DateTime date;
  final String timeSlot;
  final String venueLocation;
  final int guestCount;
  final String eventType;
  final String? specialRequests;
  final String frameTheme;
  final String primaryColorHex;
  final String customHeadingText;
  final String fontStyle;
  final String? receiptFileName;
  final double totalAmount;
  final String status; // Pending, Confirmed, Completed, Cancelled
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.referenceCode,
    required this.packageId,
    required this.packageName,
    required this.date,
    required this.timeSlot,
    required this.venueLocation,
    required this.guestCount,
    required this.eventType,
    this.specialRequests,
    required this.frameTheme,
    required this.primaryColorHex,
    required this.customHeadingText,
    required this.fontStyle,
    this.receiptFileName,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      referenceCode: json['reference_code'] as String,
      packageId: json['package_id'] as String,
      packageName: json['package_name'] as String,
      date: DateTime.parse(json['date'] as String),
      timeSlot: json['time_slot'] as String,
      venueLocation: json['venue_location'] as String,
      guestCount: json['guest_count'] as int,
      eventType: json['event_type'] as String,
      specialRequests: json['special_requests'] as String?,
      frameTheme: json['frame_theme'] as String,
      primaryColorHex: json['primary_color_hex'] as String,
      customHeadingText: json['custom_heading_text'] as String,
      fontStyle: json['font_style'] as String,
      receiptFileName: json['receipt_file_name'] as String?,
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference_code': referenceCode,
      'package_id': packageId,
      'package_name': packageName,
      'date': date.toIso8601String(),
      'time_slot': timeSlot,
      'venue_location': venueLocation,
      'guest_count': guestCount,
      'event_type': eventType,
      'special_requests': specialRequests,
      'frame_theme': frameTheme,
      'primary_color_hex': primaryColorHex,
      'custom_heading_text': customHeadingText,
      'font_style': fontStyle,
      'receipt_file_name': receiptFileName,
      'total_amount': totalAmount,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
