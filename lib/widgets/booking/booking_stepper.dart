import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class BookingStepper extends StatelessWidget {
  final int currentStep; // 1 to 4
  final int totalSteps; // 4
  final String stepTitle;

  const BookingStepper({
    super.key,
    required this.currentStep,
    this.totalSteps = 4,
    required this.stepTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'STEP $currentStep OF $totalSteps',
                style: const TextStyle(
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  fontSize: 11,
                ),
              ),
              Text(
                stepTitle,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: currentStep / totalSteps,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryNavy),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}
