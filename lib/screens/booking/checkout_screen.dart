import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/booking/booking_stepper.dart';
import '../../widgets/checkout/order_summary_card.dart';
import '../../widgets/checkout/payment_upload_field.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/layout/app_top_bar.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? _uploadedFileName;

  void _simulateUploadReceipt() {
    setState(() {
      _uploadedFileName = 'receipt_bank_transfer_${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}.png';
    });
    context.read<BookingProvider>().setReceiptFileName(_uploadedFileName);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment proof uploaded successfully!')),
    );
  }

  void _confirmAndPay() async {
    final bookingProvider = context.read<BookingProvider>();
    if (bookingProvider.draftPackage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a package first.')),
      );
      return;
    }

    final confirmedBooking = await bookingProvider.finalizeBooking();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.bookingConfirmed,
        (route) => route.isFirst,
        arguments: confirmedBooking,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final package = bookingProvider.draftPackage;

    if (package == null) {
      return Scaffold(
        appBar: const AppTopBar(title: 'Checkout'),
        body: const Center(child: Text('No package selected for checkout.')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(title: 'Complete Your Booking'),
      body: SafeArea(
        child: Column(
          children: [
            const BookingStepper(currentStep: 5, stepTitle: 'Payment & Checkout'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Order Summary Card
                    OrderSummaryCard(
                      package: package,
                      date: bookingProvider.draftDate,
                      timeSlot: bookingProvider.draftTimeSlot,
                      venueLocation: bookingProvider.draftVenueLocation,
                      eventType: bookingProvider.draftEventType,
                      guestCount: bookingProvider.draftGuestCount,
                      frameTheme: bookingProvider.draftFrameTheme,
                      status: 'Pending',
                    ),
                    const SizedBox(height: 20),

                    // Payment Proof Upload Field
                    PaymentUploadField(
                      fileName: _uploadedFileName ?? bookingProvider.draftReceiptFileName,
                      onUploadTap: _simulateUploadReceipt,
                      onRemoveTap: () {
                        setState(() {
                          _uploadedFileName = null;
                        });
                        context.read<BookingProvider>().setReceiptFileName(null);
                      },
                    ),
                    const SizedBox(height: 24),

                    // Confirm & Pay CTA
                    AppButton(
                      text: 'Confirm & Pay',
                      icon: Icons.lock_outline_rounded,
                      isLoading: bookingProvider.isLoading,
                      onPressed: _confirmAndPay,
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'By clicking "Confirm & Pay", you agree to our Terms of Service & Cancellation Policy.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
