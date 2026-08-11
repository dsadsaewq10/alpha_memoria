import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/app_card.dart';
import '../../widgets/common/app_avatar.dart';
import '../../widgets/layout/app_top_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Logout', style: AppTextStyles.headingSmall),
        content: Text('Are you sure you want to log out of Alpha Memoria?', style: AppTextStyles.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: AppTextStyles.caption.copyWith(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              await context.read<AuthProvider>().logout();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.welcome, (route) => false);
              }
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    final name = user?.fullName ?? 'Juanita Dela Cruz';
    final email = user?.email ?? 'juanita@example.com';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(title: 'Profile', showBackButton: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // User Avatar Card
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        AppAvatar(name: name, imageUrl: user?.avatarUrl, radius: 44),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt_rounded, size: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(name, style: AppTextStyles.headingMedium),
                    Text(email, style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Menu Items Card
              AppCard(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.person_outline_rounded,
                      title: 'Personal Information',
                      subtitle: 'Update details & contact info',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.personalInfo);
                      },
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    _buildMenuItem(
                      icon: Icons.calendar_month_outlined,
                      title: 'My Bookings',
                      subtitle: 'View history & upcoming events',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.myBookings);
                      },
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    _buildMenuItem(
                      icon: Icons.payment_rounded,
                      title: 'Payment Methods',
                      subtitle: 'Manage saved cards',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.paymentMethods);
                      },
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    _buildMenuItem(
                      icon: Icons.settings_outlined,
                      title: 'App Settings',
                      subtitle: 'Notifications & preferences',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.appSettings);
                      },
                    ),
                    const Divider(height: 1, color: AppColors.border),
                    _buildMenuItem(
                      icon: Icons.help_outline_rounded,
                      title: 'Support',
                      subtitle: 'Contact support and FAQs',
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.support);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () => _showLogoutDialog(context),
                  icon: const Icon(Icons.logout_rounded, color: AppColors.error, size: 18),
                  label: Text(
                    'Logout',
                    style: AppTextStyles.button.copyWith(color: AppColors.error),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(title, style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: AppTextStyles.caption),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
    );
  }
}
