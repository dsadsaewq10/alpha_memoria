import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/booking_provider.dart';
import '../../widgets/booking/booking_stepper.dart';
import '../../widgets/booking/color_picker.dart';
import '../../widgets/booking/live_frame_preview.dart';
import '../../widgets/booking/theme_selector.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';
import '../../widgets/layout/app_top_bar.dart';

class CustomizeDesignScreen extends StatefulWidget {
  const CustomizeDesignScreen({super.key});

  @override
  State<CustomizeDesignScreen> createState() => _CustomizeDesignScreenState();
}

class _CustomizeDesignScreenState extends State<CustomizeDesignScreen> {
  late String _selectedTheme;
  late Color _selectedColor;
  late String _fontStyle;
  late TextEditingController _headingController;

  @override
  void initState() {
    super.initState();
    final bookingProvider = context.read<BookingProvider>();
    _selectedTheme = bookingProvider.draftFrameTheme;
    _selectedColor = AppColors.themeSwatches.first;
    _fontStyle = bookingProvider.draftFontStyle;
    _headingController = TextEditingController(text: bookingProvider.draftCustomHeadingText);
  }

  @override
  void dispose() {
    _headingController.dispose();
    super.dispose();
  }

  void _proceedToCheckout() {
    final bookingProvider = context.read<BookingProvider>();
    bookingProvider.updateDesignDetails(
      theme: _selectedTheme,
      colorHex: '0x${_selectedColor.value.toRadixString(16).toUpperCase()}',
      headingText: _headingController.text.trim(),
      fontStyle: _fontStyle,
    );
    Navigator.pushNamed(context, AppRoutes.checkout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(title: 'Alpha Memoria'),
      body: SafeArea(
        child: Column(
          children: [
            const BookingStepper(currentStep: 4, stepTitle: 'Customize Your Memory'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose a theme and add your personal touch to photo prints.',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 16),

                    // Live Interactive Preview Box
                    LiveFramePreview(
                      theme: _selectedTheme,
                      primaryColor: _selectedColor,
                      customText: _headingController.text,
                      fontStyle: _fontStyle,
                    ),
                    const SizedBox(height: 24),

                    // Step 1: Choose Theme
                    Text(
                      '1. Choose a Theme',
                      style: AppTextStyles.headingSmall,
                    ),
                    const SizedBox(height: 10),
                    ThemeSelectorWidget(
                      themes: AppConstants.frameThemes,
                      selectedTheme: _selectedTheme,
                      onThemeSelected: (theme) {
                        setState(() {
                          _selectedTheme = theme;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Step 2: Select Primary Color
                    Text(
                      '2. Select Primary Color',
                      style: AppTextStyles.headingSmall,
                    ),
                    const SizedBox(height: 12),
                    ColorPickerWidget(
                      colors: AppColors.themeSwatches,
                      selectedColor: _selectedColor,
                      onColorSelected: (color) {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Step 3: Add Your Text
                    Text(
                      '3. Add Your Text',
                      style: AppTextStyles.headingSmall,
                    ),
                    const SizedBox(height: 12),
                    AppTextField(
                      label: 'Main Heading',
                      hint: 'e.g. Happy Birthday Sarah!',
                      controller: _headingController,
                      onChanged: (val) => setState(() {}),
                    ),
                    const SizedBox(height: 14),

                    Text(
                      'Font Style',
                      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _fontStyle,
                          isExpanded: true,
                          items: AppConstants.fontStyles.map((style) {
                            return DropdownMenuItem(
                              value: style,
                              child: Text(style, style: AppTextStyles.bodyMedium),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _fontStyle = val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    AppButton(
                      text: 'Confirm Design',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: _proceedToCheckout,
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
