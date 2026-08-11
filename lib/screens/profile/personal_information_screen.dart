import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/layout/app_top_bar.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late String _fullName;
  late String _email;
  late String _phone;
  late String _dob;

  @override
  void initState() {
    super.initState();
    final auth = context.read<AuthProvider>();
    final u = auth.user;
    _fullName = u?.fullName ?? 'Juanita Dela Cruz';
    _email = u?.email ?? 'juanita@example.com';
    _phone = u?.phone ?? '+63 917 123 4567';
    _dob = u?.birthday ?? '10/15/1996';
  }

  void _editField(String fieldName, String currentValue, ValueChanged<String> onSaved) {
    final controller = TextEditingController(text: currentValue);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Edit $fieldName', style: AppTextStyles.headingSmall),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                autofocus: true,
                style: AppTextStyles.bodyLarge,
                decoration: InputDecoration(
                  labelText: fieldName,
                  labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  onPressed: () {
                    final newValue = controller.text.trim();
                    if (newValue.isNotEmpty) {
                      onSaved(newValue);
                    }
                    Navigator.pop(ctx);
                  },
                  child: Text('Update', style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 12),
            Text('Personal information updated successfully!'),
          ],
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(title: 'Personal Information'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      icon: Icons.person_outline_rounded,
                      label: 'Full Name',
                      value: _fullName,
                      onTap: () => _editField('Full Name', _fullName, (val) => setState(() => _fullName = val)),
                    ),
                    const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),
                    _buildInfoRow(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: _email,
                      onTap: () => _editField('Email', _email, (val) => setState(() => _email = val)),
                    ),
                    const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),
                    _buildInfoRow(
                      icon: Icons.phone_outlined,
                      label: 'Phone Number',
                      value: _phone,
                      onTap: () => _editField('Phone Number', _phone, (val) => setState(() => _phone = val)),
                    ),
                    const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),
                    _buildInfoRow(
                      icon: Icons.cake_outlined,
                      label: 'Date of Birth',
                      value: _dob,
                      onTap: () => _editField('Date of Birth', _dob, (val) => setState(() => _dob = val)),
                    ),
                    const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.primaryLight,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                  ),
                  onPressed: _saveChanges,
                  child: Text(
                    'Save Changes',
                    style: AppTextStyles.button.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      highlightColor: AppColors.primarySubtle,
      splashColor: AppColors.primaryLight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
