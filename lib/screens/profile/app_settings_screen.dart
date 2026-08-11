import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/layout/app_top_bar.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English (US)';
  String _selectedTheme = 'Light Mode';

  void _showLanguagePicker() {
    final languages = ['English (US)', 'Filipino (Tagalog)', 'Spanish', 'Japanese'];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Language', style: AppTextStyles.headingSmall),
            const SizedBox(height: 16),
            ...languages.map((lang) => ListTile(
                  title: Text(lang, style: AppTextStyles.bodyLarge),
                  trailing: lang == _selectedLanguage
                      ? const Icon(Icons.check_rounded, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() => _selectedLanguage = lang);
                    Navigator.pop(ctx);
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _showThemePicker() {
    final themes = ['Light Mode', 'Dark Mode', 'System Default'];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Theme', style: AppTextStyles.headingSmall),
            const SizedBox(height: 16),
            ...themes.map((theme) => ListTile(
                  title: Text(theme, style: AppTextStyles.bodyLarge),
                  trailing: theme == _selectedTheme
                      ? const Icon(Icons.check_rounded, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() => _selectedTheme = theme);
                    Navigator.pop(ctx);
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _showPrivacyInfo() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Privacy & Data', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            Text(
              'Your privacy is our priority. Alpha Memoria encrypts your personal details and booking history. We never share your sensitive data with third parties.',
              style: AppTextStyles.bodyMedium,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () => Navigator.pop(ctx),
                child: Text('Done', style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSecurityOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Account Security', style: AppTextStyles.headingSmall),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.lock_reset_rounded, color: AppColors.primary),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password reset link sent to your email!')),
                );
              },
            ),
            const Divider(height: 1, color: AppColors.border),
            ListTile(
              leading: const Icon(Icons.security_rounded, color: AppColors.primary),
              title: const Text('Two-Factor Authentication (2FA)'),
              subtitle: const Text('Enabled via SMS / Email'),
              trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(title: 'App Settings'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Notifications row (Switch toggle)
              _buildSettingRow(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                subtitle: 'Manage push & email alerts',
                trailing: Switch.adaptive(
                  value: _notificationsEnabled,
                  activeTrackColor: AppColors.primary,
                  onChanged: (val) {
                    setState(() => _notificationsEnabled = val);
                  },
                ),
                onTap: () => setState(() => _notificationsEnabled = !_notificationsEnabled),
              ),
              const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),

              // Language row
              _buildSettingRow(
                icon: Icons.language_rounded,
                title: 'Language',
                subtitle: _selectedLanguage,
                onTap: _showLanguagePicker,
              ),
              const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),

              // Theme row
              _buildSettingRow(
                icon: Icons.palette_outlined,
                title: 'Theme',
                subtitle: _selectedTheme,
                onTap: _showThemePicker,
              ),
              const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),

              // Privacy row
              _buildSettingRow(
                icon: Icons.lock_outline_rounded,
                title: 'Privacy',
                subtitle: 'Data permissions & visibility',
                onTap: _showPrivacyInfo,
              ),
              const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),

              // Account Security row
              _buildSettingRow(
                icon: Icons.security_rounded,
                title: 'Account Security',
                subtitle: 'Two-factor auth & passwords',
                onTap: _showSecurityOptions,
              ),
              const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
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
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            trailing ??
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
