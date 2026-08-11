import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/layout/app_top_bar.dart';

class PaymentMethodItem {
  final String id;
  final String brand;
  final String last4;
  final String expiry;
  bool isDefault;

  PaymentMethodItem({
    required this.id,
    required this.brand,
    required this.last4,
    required this.expiry,
    this.isDefault = false,
  });
}

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<PaymentMethodItem> _cards = [
    PaymentMethodItem(id: '1', brand: 'Visa', last4: '4242', expiry: '12/28', isDefault: true),
    PaymentMethodItem(id: '2', brand: 'Mastercard', last4: '8891', expiry: '09/27', isDefault: false),
    PaymentMethodItem(id: '3', brand: 'American Express', last4: '1043', expiry: '04/26', isDefault: false),
  ];

  void _showAddCardSheet() {
    final cardNumberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();
    final nameController = TextEditingController();

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
                  Text('Add New Card', style: AppTextStyles.headingSmall),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: _inputDecoration('Cardholder Name', Icons.person_outline_rounded),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                maxLength: 16,
                decoration: _inputDecoration('Card Number', Icons.credit_card_rounded).copyWith(counterText: ''),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: expiryController,
                      keyboardType: TextInputType.datetime,
                      decoration: _inputDecoration('MM/YY', Icons.calendar_month_outlined),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: cvvController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      maxLength: 4,
                      decoration: _inputDecoration('CVV', Icons.lock_outline_rounded).copyWith(counterText: ''),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () {
                    final rawNum = cardNumberController.text.trim();
                    final last4 = rawNum.length >= 4 ? rawNum.substring(rawNum.length - 4) : '9999';
                    final exp = expiryController.text.trim().isEmpty ? '12/29' : expiryController.text.trim();
                    setState(() {
                      _cards.add(PaymentMethodItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        brand: 'Visa',
                        last4: last4,
                        expiry: exp,
                      ));
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Card ending in $last4 added successfully!'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                  child: Text('Add Card', style: AppTextStyles.button.copyWith(fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration(String label, IconData prefixIcon) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
      prefixIcon: Icon(prefixIcon, color: AppColors.primary, size: 20),
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
    );
  }

  void _manageCard(PaymentMethodItem card) {
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
            Text('${card.brand} ending in ${card.last4}', style: AppTextStyles.headingSmall),
            const SizedBox(height: 4),
            Text('Expires ${card.expiry}', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 20),
            if (!card.isDefault) ...[
              ListTile(
                leading: const Icon(Icons.check_circle_outline_rounded, color: AppColors.primary),
                title: const Text('Set as Default Payment Method'),
                onTap: () {
                  setState(() {
                    for (var c in _cards) {
                      c.isDefault = (c.id == card.id);
                    }
                  });
                  Navigator.pop(ctx);
                },
              ),
              const Divider(height: 1, color: AppColors.border),
            ],
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
              title: const Text('Remove Card', style: TextStyle(color: AppColors.error)),
              onTap: () {
                setState(() {
                  _cards.removeWhere((c) => c.id == card.id);
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment card removed.')),
                );
              },
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
      appBar: const AppTopBar(title: 'Payment Methods'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Saved Card Rows
              ..._cards.map((card) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () => _manageCard(card),
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
                              child: const Icon(
                                Icons.credit_card_rounded,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${card.brand} •••• ${card.last4}',
                                        style: AppTextStyles.bodyLarge.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      if (card.isDefault) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryLight,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            'Default',
                                            style: AppTextStyles.caption.copyWith(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Expires ${card.expiry}',
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
                    ),
                    const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),
                  ],
                );
              }),

              // Add New Card Row at Bottom
              InkWell(
                onTap: _showAddCardSheet,
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
                        child: const Icon(
                          Icons.add_rounded,
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
                              'Add New Card',
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Save credit or debit card for instant checkout',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1, indent: 68, endIndent: 20, color: AppColors.border),
            ],
          ),
        ),
      ),
    );
  }
}
