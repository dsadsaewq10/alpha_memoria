import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/layout/app_top_bar.dart';

class SupportItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String category;

  SupportItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.category,
  });
}

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<SupportItem> _allSupportItems = [
    SupportItem(
      icon: Icons.help_outline_rounded,
      title: 'FAQs',
      subtitle: 'Frequently asked questions & answers',
      category: 'faq',
    ),
    SupportItem(
      icon: Icons.headset_mic_outlined,
      title: 'Contact Support',
      subtitle: '24/7 customer care team via email or phone',
      category: 'contact',
    ),
    SupportItem(
      icon: Icons.chat_bubble_outline_rounded,
      title: 'Live Chat',
      subtitle: 'Chat directly with a representative',
      category: 'chat',
    ),
    SupportItem(
      icon: Icons.report_problem_outlined,
      title: 'Report a Problem',
      subtitle: 'Let us know about technical issues or app bugs',
      category: 'report',
    ),
    SupportItem(
      icon: Icons.article_outlined,
      title: 'Terms & Privacy Policy',
      subtitle: 'Read terms of service & privacy guidelines',
      category: 'terms',
    ),
  ];

  List<SupportItem> get _filteredItems {
    if (_searchQuery.trim().isEmpty) {
      return _allSupportItems;
    }
    final q = _searchQuery.toLowerCase();
    return _allSupportItems
        .where((item) =>
            item.title.toLowerCase().contains(q) || item.subtitle.toLowerCase().contains(q))
        .toList();
  }

  void _onItemTap(SupportItem item) {
    switch (item.category) {
      case 'faq':
        _showFaqModal();
        break;
      case 'contact':
        _showContactModal();
        break;
      case 'chat':
        _showLiveChatModal();
        break;
      case 'report':
        _showReportProblemModal();
        break;
      case 'terms':
        _showTermsModal();
        break;
    }
  }

  void _showFaqModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Container(
        height: MediaQuery.of(ctx).size.height * 0.7,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Frequently Asked Questions', style: AppTextStyles.headingSmall),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  ExpansionTile(
                    title: Text('How do I book a photo booth package?', style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text('Browse packages on the home screen, select your date, customize your design template, and proceed to checkout!'),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('What is the cancellation policy?', style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text('Full refunds are available up to 48 hours prior to your event time slot.'),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Can I request a custom photo template design?', style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text('Yes! Use the "Customize Design" step during booking or message support after placing an order.'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContactModal() {
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
            Text('Contact Support', style: AppTextStyles.headingSmall),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email_outlined, color: AppColors.primary),
              title: const Text('Email Support'),
              subtitle: const Text('support@alphamemoria.com'),
              onTap: () => Navigator.pop(ctx),
            ),
            const Divider(height: 1, color: AppColors.border),
            ListTile(
              leading: const Icon(Icons.phone_outlined, color: AppColors.primary),
              title: const Text('Hotline Call'),
              subtitle: const Text('+63 (02) 8123 4567'),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }

  void _showLiveChatModal() {
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
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chat_bubble_rounded, color: AppColors.primary, size: 36),
            ),
            const SizedBox(height: 16),
            Text('Start Live Chat', style: AppTextStyles.headingSmall),
            const SizedBox(height: 8),
            Text(
              'An Alpha Memoria support agent is online and ready to assist you.',
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
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
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Connected to live support chat representative!')),
                  );
                },
                child: Text('Connect Now', style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReportProblemModal() {
    final reportController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
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
            Text('Report a Problem', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            TextField(
              controller: reportController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Describe the issue you encountered...',
                filled: true,
                fillColor: AppColors.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thank you! Your issue report has been submitted.')),
                  );
                },
                child: Text('Submit Report', style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTermsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Container(
        height: MediaQuery.of(ctx).size.height * 0.7,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Terms & Privacy Policy', style: AppTextStyles.headingSmall),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  '1. Acceptance of Terms\nBy accessing and using Alpha Memoria services, you accept and agree to be bound by the terms and provisions of this agreement.\n\n'
                  '2. Event Booking & Payment\nBookings are confirmed upon receipt of valid payment details. Prices are subject to applicable taxes.\n\n'
                  '3. Data Protection\nWe prioritize your privacy. All payment transactions and personal details are encrypted using SSL technology.',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                child: Text('I Understand', style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(title: 'Support'),
      body: SafeArea(
        child: Column(
          children: [
            // Top minimal search bar with light-gray background & rounded corners
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                style: AppTextStyles.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Search help topics...',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted, size: 22),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, color: AppColors.textMuted, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
            ),

            // List of Support Rows
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search_off_rounded, size: 40, color: AppColors.textMuted),
                          const SizedBox(height: 12),
                          Text('No results found for "$_searchQuery"', style: AppTextStyles.bodyLarge),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        indent: 68,
                        endIndent: 20,
                        color: AppColors.border,
                      ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return InkWell(
                          onTap: () => _onItemTap(item),
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
                                  child: Icon(
                                    item.icon,
                                    color: AppColors.primary,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: AppTextStyles.bodyLarge.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.subtitle,
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
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
