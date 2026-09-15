import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/booking/booking_stepper.dart';
import '../../widgets/layout/app_top_bar.dart';
import '../../widgets/layout/bottom_nav_bar.dart';

class EventsDetailScreen extends StatefulWidget {
  const EventsDetailScreen({super.key});

  @override
  State<EventsDetailScreen> createState() => _EventsDetailScreenState();
}

class _EventsDetailScreenState extends State<EventsDetailScreen> {
  String _eventType = 'Wedding';
  final TextEditingController _eventNameController =
      TextEditingController(text: "Matteo's 18th Birthday");
  final TextEditingController _eventThemeController =
      TextEditingController(text: 'SAFARI');
  final TextEditingController _locationController =
      TextEditingController(text: 'The Grand Plaza, Central Hall');
  final TextEditingController _venueController =
      TextEditingController(text: 'The Grand Plaza Ballroom');
  int _guestCount = 50;

  final TextEditingController _fullNameController =
      TextEditingController(text: 'Jonathan Santos');
  final TextEditingController _contactController =
      TextEditingController(text: '0917 123 4567');
  final TextEditingController _emailController =
      TextEditingController(text: 'jonathan@example.com');
  final TextEditingController _notesController = TextEditingController();

  final List<String> _eventTypes = [
    'Wedding',
    'Birthday',
    'Debut',
    'Corporate',
    'Anniversary',
    'Reunion',
  ];

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventThemeController.dispose();
    _locationController.dispose();
    _venueController.dispose();
    _fullNameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.read<BookingProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(
        title: 'Alpha Memoria',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // STEP 3 OF 4: Events Detail
            const BookingStepper(
              currentStep: 3,
              totalSteps: 4,
              stepTitle: 'Events Detail',
            ),

            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 620),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tell us about your event',
                      style: TextStyle(
                        color: AppColors.primaryNavy,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'This helps us tailor everything exactly what you need.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // EVENT TYPE DROPDOWN
                    _buildFieldLabel('EVENT TYPE'),
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _eventType,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          items: _eventTypes
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _eventType = val);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // EVENT NAME
                    _buildFieldLabel('EVENT NAME'),
                    _buildTextField(
                      controller: _eventNameController,
                      hintText: "e.g. Matteo's 18th Birthday",
                    ),
                    const SizedBox(height: 14),

                    // EVENT THEME
                    _buildFieldLabel('EVENT THEME'),
                    _buildTextField(
                      controller: _eventThemeController,
                      hintText: 'e.g. SAFARI',
                    ),
                    const SizedBox(height: 14),

                    // EVENT LOCATION
                    _buildFieldLabel('EVENT LOCATION'),
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: AppColors.textSecondary,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _locationController,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'The Grand Plaza, Central Hall',
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // EVENT VENUE
                    _buildFieldLabel('EVENT VENUE'),
                    _buildTextField(
                      controller: _venueController,
                      hintText: 'The Grand Plaza Ballroom',
                    ),
                    const SizedBox(height: 14),

                    // GUEST COUNT STEPPER
                    _buildFieldLabel('GUEST COUNT'),
                    Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (_guestCount > 10) {
                                setState(() => _guestCount -= 10);
                              }
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          Text(
                            '$_guestCount',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() => _guestCount += 10);
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),

                    // CLIENT INFORMATION Section
                    const Text(
                      'CLIENT INFORMATION',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _buildTextField(
                      controller: _fullNameController,
                      hintText: 'Full name',
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _contactController,
                            hintText: 'Contact number',
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildTextField(
                            controller: _emailController,
                            hintText: 'Email address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // NOTES FOR THE CREW (OPTIONAL)
                    const Text(
                      'NOTES FOR THE CREW (OPTIONAL)',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: TextField(
                        controller: _notesController,
                        maxLines: 3,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Access codes, setup preferences, anything we should know...',
                          hintStyle: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 11,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Back & Continue Buttons Row
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 44,
                            child: OutlinedButton(
                              onPressed: () => Navigator.maybePop(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primaryNavy,
                                side: const BorderSide(color: AppColors.primaryNavy, width: 1.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {
                                bookingProvider.updateDateDetails(
                                  date: bookingProvider.draftDate,
                                  timeSlot: bookingProvider.draftTimeSlot,
                                  venueLocation: _locationController.text.trim(),
                                  guestCount: _guestCount,
                                  eventType: _eventNameController.text.trim().isNotEmpty
                                      ? _eventNameController.text.trim()
                                      : _eventType,
                                  specialRequests: _notesController.text.trim(),
                                );
                                Navigator.pushNamed(context, AppRoutes.payment);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryNavy,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Continue',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(Icons.arrow_forward_rounded, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
  bottomNavigationBar: BottomNavBar(
    currentIndex: 1,
    onTap: (index) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.mainNav,
        (route) => false,
        arguments: index,
      );
    },
  ),
);
}

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textMuted,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
