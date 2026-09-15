import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/booking/booking_stepper.dart';
import '../../widgets/layout/app_top_bar.dart';
import '../../widgets/layout/bottom_nav_bar.dart';

class SecureDateScreen extends StatefulWidget {
  const SecureDateScreen({super.key});

  @override
  State<SecureDateScreen> createState() => _SecureDateScreenState();
}

class _SecureDateScreenState extends State<SecureDateScreen> {
  late DateTime _selectedDate;
  late DateTime _displayedMonth;

  String _startTime = '01:00';
  String _endTime = '03:00';
  String _startPeriod = 'AM';
  String _endPeriod = 'AM';

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static const List<String> _shortMonthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  @override
  void initState() {
    super.initState();
    final bookingProvider = context.read<BookingProvider>();
    _selectedDate = bookingProvider.draftDate;
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
  }

  void _prevMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 1);
    });
  }

  Future<void> _pickStartTime() async {
    final parts = _startTime.split(':');
    int hour = int.tryParse(parts[0]) ?? 1;
    final minute = int.tryParse(parts[1]) ?? 0;
    if (_startPeriod == 'PM' && hour < 12) hour += 12;
    if (_startPeriod == 'AM' && hour == 12) hour = 0;

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
    );

    if (picked != null) {
      setState(() {
        final hour12 = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
        _startTime = '${hour12.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
        _startPeriod = picked.period == DayPeriod.am ? 'AM' : 'PM';
      });
    }
  }

  Future<void> _pickEndTime() async {
    final parts = _endTime.split(':');
    int hour = int.tryParse(parts[0]) ?? 3;
    final minute = int.tryParse(parts[1]) ?? 0;
    if (_endPeriod == 'PM' && hour < 12) hour += 12;
    if (_endPeriod == 'AM' && hour == 12) hour = 0;

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
    );

    if (picked != null) {
      setState(() {
        final hour12 = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
        _endTime = '${hour12.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
        _endPeriod = picked.period == DayPeriod.am ? 'AM' : 'PM';
      });
    }
  }

  void _showMonthYearPicker(BuildContext context) {
    int pickerYear = _displayedMonth.year;
    int pickerMonth = _displayedMonth.month;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (modalContext, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Select Month & Year',
                          style: TextStyle(
                            color: AppColors.primaryNavy,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Year Selector with arrows
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left_rounded, color: AppColors.primaryNavy),
                            onPressed: () {
                              setModalState(() {
                                pickerYear--;
                              });
                            },
                          ),
                          InkWell(
                            onTap: () async {
                              final currentYear = pickerYear;
                              final chosenYear = await showDialog<int>(
                                context: modalContext,
                                builder: (dlgCtx) {
                                  return SimpleDialog(
                                    title: const Text('Select Year'),
                                    children: List.generate(21, (i) {
                                      final y = currentYear - 10 + i;
                                      return SimpleDialogOption(
                                        onPressed: () => Navigator.pop(dlgCtx, y),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          child: Text(
                                            '$y',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: y == currentYear
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: y == currentYear
                                                  ? AppColors.primaryNavy
                                                  : AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              );
                              if (chosenYear != null) {
                                setModalState(() {
                                  pickerYear = chosenYear;
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '$pickerYear',
                                    style: const TextStyle(
                                      color: AppColors.primaryNavy,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    size: 18,
                                    color: AppColors.primaryNavy,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right_rounded, color: AppColors.primaryNavy),
                            onPressed: () {
                              setModalState(() {
                                pickerYear++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 12 Months Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.8,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        final monthNum = index + 1;
                        final isSelected = pickerMonth == monthNum;
                        return InkWell(
                          onTap: () {
                            setModalState(() {
                              pickerMonth = monthNum;
                            });
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryNavy : const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected ? AppColors.primaryNavy : const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                _shortMonthNames[index],
                                style: TextStyle(
                                  color: isSelected ? Colors.white : AppColors.textPrimary,
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 22),

                    // Apply Button
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _displayedMonth = DateTime(pickerYear, pickerMonth, 1);
                            // Adjust selected day if it exceeds the new month's days
                            final daysInNewMonth = DateTime(pickerYear, pickerMonth + 1, 0).day;
                            final newDay = _selectedDate.day > daysInNewMonth
                                ? daysInNewMonth
                                : _selectedDate.day;
                            _selectedDate = DateTime(pickerYear, pickerMonth, newDay);
                          });
                          Navigator.pop(ctx);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryNavy,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Apply Selection',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
            // STEP 2 OF 4: Securing Date
            const BookingStepper(
              currentStep: 2,
              totalSteps: 4,
              stepTitle: 'Securing Date',
            ),

            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Secure Your Date',
                          style: TextStyle(
                            color: AppColors.primaryNavy,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Secure your date by selecting the date and time slot for the event.',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Calendar Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.02),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top header row with SELECT DATE and Month/Year controls
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'SELECT DATE',
                                    style: TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.chevron_left_rounded,
                                          size: 20,
                                          color: AppColors.primaryNavy,
                                        ),
                                        visualDensity: VisualDensity.compact,
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                                        onPressed: _prevMonth,
                                      ),
                                      InkWell(
                                        onTap: () => _showMonthYearPicker(context),
                                        borderRadius: BorderRadius.circular(6),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${_monthNames[_displayedMonth.month - 1]} ${_displayedMonth.year}',
                                                style: const TextStyle(
                                                  color: AppColors.primaryNavy,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              const Icon(
                                                Icons.arrow_drop_down,
                                                size: 16,
                                                color: AppColors.primaryNavy,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.chevron_right_rounded,
                                          size: 20,
                                          color: AppColors.primaryNavy,
                                        ),
                                        visualDensity: VisualDensity.compact,
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                                        onPressed: _nextMonth,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Days of week header: S M T W T F S
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: const [
                                  _CalendarHeaderCell('S'),
                                  _CalendarHeaderCell('M'),
                                  _CalendarHeaderCell('T'),
                                  _CalendarHeaderCell('W'),
                                  _CalendarHeaderCell('T'),
                                  _CalendarHeaderCell('F'),
                                  _CalendarHeaderCell('S'),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Dynamic Calendar Weeks Grid
                              _buildCalendarGrid(),

                              const SizedBox(height: 12),
                              const Divider(height: 1, color: Color(0xFFEDF2F7)),
                              const SizedBox(height: 12),

                              // Selected date text and Change option
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${_monthNames[_selectedDate.month - 1]} ${_selectedDate.day}, ${_selectedDate.year}',
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => _showMonthYearPicker(context),
                                    child: Row(
                                      children: const [
                                        Text(
                                          'Change',
                                          style: TextStyle(
                                            color: AppColors.primaryNavy,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          size: 13,
                                          color: AppColors.primaryNavy,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),

                        // SET YOUR EVENT TIME Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SET YOUR EVENT TIME',
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                ),
                              ),
                              const SizedBox(height: 14),

                              Row(
                                children: [
                                  // Start Time Field
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'START TIME',
                                          style: TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF8FAFC),
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: const Color(0xFFE2E8F0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: _pickStartTime,
                                                borderRadius: BorderRadius.circular(4),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        _startTime,
                                                        style: const TextStyle(
                                                          color: AppColors.textPrimary,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Icon(
                                                        Icons.access_time_rounded,
                                                        size: 13,
                                                        color: AppColors.textSecondary,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _startPeriod = _startPeriod == 'AM' ? 'PM' : 'AM';
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFEDF2F7),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    _startPeriod,
                                                    style: const TextStyle(
                                                      color: AppColors.primaryNavy,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),

                                  // End Time Field
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'END TIME',
                                          style: TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF8FAFC),
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: const Color(0xFFE2E8F0)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: _pickEndTime,
                                                borderRadius: BorderRadius.circular(4),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        _endTime,
                                                        style: const TextStyle(
                                                          color: AppColors.textPrimary,
                                                          fontSize: 13,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Icon(
                                                        Icons.access_time_rounded,
                                                        size: 13,
                                                        color: AppColors.textSecondary,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _endPeriod = _endPeriod == 'AM' ? 'PM' : 'AM';
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFFEDF2F7),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    _endPeriod,
                                                    style: const TextStyle(
                                                      color: AppColors.primaryNavy,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                                      date: _selectedDate,
                                      timeSlot: '$_startTime $_startPeriod - $_endTime $_endPeriod',
                                      venueLocation: bookingProvider.draftVenueLocation,
                                      guestCount: bookingProvider.draftGuestCount,
                                      eventType: bookingProvider.draftEventType,
                                    );
                                    Navigator.pushNamed(context, AppRoutes.eventsDetail);
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
                        const SizedBox(height: 20),
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

  Widget _buildCalendarGrid() {
    final int daysInMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0).day;
    final int prevMonthDays = DateTime(_displayedMonth.year, _displayedMonth.month, 0).day;
    final int firstWeekday = DateTime(_displayedMonth.year, _displayedMonth.month, 1).weekday % 7; // Sunday = 0

    List<Widget> weekRows = [];
    List<Widget> currentWeek = [];

    // Trailing days from previous month
    for (int i = 0; i < firstWeekday; i++) {
      final day = prevMonthDays - firstWeekday + 1 + i;
      currentWeek.add(_buildDayCell(
        day: day,
        isCurrentMonth: false,
        date: DateTime(_displayedMonth.year, _displayedMonth.month - 1, day),
      ));
    }

    // Days of current month
    for (int day = 1; day <= daysInMonth; day++) {
      currentWeek.add(_buildDayCell(
        day: day,
        isCurrentMonth: true,
        date: DateTime(_displayedMonth.year, _displayedMonth.month, day),
      ));
      if (currentWeek.length == 7) {
        weekRows.add(Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: currentWeek,
          ),
        ));
        currentWeek = [];
      }
    }

    // Leading days of next month to complete the row
    if (currentWeek.isNotEmpty) {
      int nextDay = 1;
      while (currentWeek.length < 7) {
        currentWeek.add(_buildDayCell(
          day: nextDay,
          isCurrentMonth: false,
          date: DateTime(_displayedMonth.year, _displayedMonth.month + 1, nextDay),
        ));
        nextDay++;
      }
      weekRows.add(Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: currentWeek,
        ),
      ));
    }

    return Column(children: weekRows);
  }

  Widget _buildDayCell({
    required int day,
    required bool isCurrentMonth,
    required DateTime date,
  }) {
    final isSelected = date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = date;
          if (!isCurrentMonth) {
            _displayedMonth = DateTime(date.year, date.month, 1);
          }
        });
      },
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryNavy : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '$day',
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (isCurrentMonth ? AppColors.textPrimary : const Color(0xFFCBD5E1)),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _CalendarHeaderCell extends StatelessWidget {
  final String text;
  const _CalendarHeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
