import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';

import '../../providers/alert_provider.dart';
import '../../widgets/alerts/alert_tile.dart';
import '../../widgets/layout/app_top_bar.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alertProvider = context.watch<AlertProvider>();
    final alerts = alertProvider.alerts;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(title: 'Your Alerts', showBackButton: false),
      body: SafeArea(
        child: alertProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : alerts.isEmpty
                ? const Center(child: Text('No alerts yet'))
                : ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: alerts.length,
                    separatorBuilder: (ctx, i) => const SizedBox(height: 12),
                    itemBuilder: (ctx, index) {
                      final alert = alerts[index];
                      return AlertTile(
                        alert: alert,
                        onTap: () {
                          alertProvider.markAsRead(alert.id);
                        },
                        onActionTap: () {
                          alertProvider.markAsRead(alert.id);
                          if (alert.actionRoute != null) {
                            Navigator.pushNamed(context, AppRoutes.checkout);
                          }
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
