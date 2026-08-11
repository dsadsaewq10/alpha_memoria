import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/date_formatter.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/booking/booking_stepper.dart';
import '../../widgets/booking/calendar_picker.dart';
import '../../widgets/booking/time_slot_picker.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/layout/app_top_bar.dart';

class SecureDateScreen extends StatefulWidget {
  const SecureDateScreen({super.key});

  @override
  State<SecureDateScreen> createState() => _SecureDateScreenState();
}

class _SecureDateScreenState extends State<SecureDateScreen> {
  late DateTime _selectedDate;
  late String _selectedTimeSlot;
  late String _selectedEventType;
  int _guestCount = 80;

  late TextEditingController _locationController;
  late TextEditingController _specialRequestsController;

  @override
  void initState() {
    super.initState();
    final bookingProvider = context.read<BookingProvider>();
    _selectedDate = bookingProvider.draftDate;
    _selectedTimeSlot = bookingProvider.draftTimeSlot;
    _selectedEventType = bookingProvider.draftEventType;
    _guestCount = bookingProvider.draftGuestCount;

    _locationController =
        TextEditingController(text: bookingProvider.draftVenueLocation.isEmpty
            ? 'The Grand Plaza, Central Hall'
            : bookingProvider.draftVenueLocation);
    _specialRequestsController =
        TextEditingController(text: bookingProvider.draftSpecialRequests);
  }

  @override
  void dispose() {
    _locationController.dispose();
    _specialRequestsController.dispose();
    super.dispose();
  }

  void _proceedToDesign() {
    final bookingProvider = context.read<BookingProvider>();
    bookingProvider.updateDateDetails(
      date: _selectedDate,
      timeSlot: _selectedTimeSlot,
      venueLocation: _locationController.text.trim(),
      guestCount: _guestCount,
      eventType: _selectedEventType,
      specialRequests: _specialRequestsController.text.trim(),
    );
    Navigator.pushNamed(context, AppRoutes.customizeDesign);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(title: 'Alpha Memoria', showBackButton: false),
      body: SafeArea(
        child: Column(
          children: [
            const BookingStepper(currentStep: 3, stepTitle: 'Secure Your Date'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SELECT A DATE', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),

                    // Calendar Widget
                    CalendarPickerWidget(
                      selectedDate: _selectedDate,
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                    const SizedBox(height: 12),

                    // Selected Date Recap
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormatter.formatFullDate(_selectedDate),
                            style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Change', style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text('AVAILABLE TIME SLOTS', style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TimeSlotPickerWidget(
                      slots: AppConstants.availableTimeSlots,
                      selectedSlot: _selectedTimeSlot,
                      onSlotSelected: (slot) {
                        setState(() {
                          _selectedTimeSlot = slot;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    AppTextField(
                      label: 'EVENT LOCATION',
                      hint: 'Enter venue address or location name',
                      controller: _locationController,
                      prefixIcon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        // Guest Count
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('GUEST COUNT', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline, size: 20, color: AppColors.primary),
                                      onPressed: () {
                                        if (_guestCount > 10) setState(() => _guestCount -= 10);
                                      },
                                    ),
                                    Text('$_guestCount', style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline, size: 20, color: AppColors.primary),
                                      onPressed: () => setState(() => _guestCount += 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Event Type Dropdown
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('EVENT TYPE', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: AppConstants.eventTypes.contains(_selectedEventType)
                                        ? _selectedEventType
                                        : AppConstants.eventTypes.first,
                                    isExpanded: true,
                                    items: AppConstants.eventTypes.map((type) {
                                      return DropdownMenuItem(
                                        value: type,
                                        child: Text(type, style: AppTextStyles.bodyMedium),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val != null) setState(() => _selectedEventType = val);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    AppTextField(
                      label: 'SPECIAL REQUESTS',
                      hint: 'Any specific instructions, access codes, or placement notes...',
                      controller: _specialRequestsController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),

                    AppButton(
                      text: 'Next: Design Selection',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: _proceedToDesign,
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
