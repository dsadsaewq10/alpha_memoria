import '../repositories/alert_repository.dart';
import '../../models/alert_model.dart';

class MockAlertRepository implements AlertRepository {
  List<AlertModel> _alerts = [
    AlertModel(
      id: 'alt_1',
      title: 'Booking Confirmed!',
      message: 'Your photo booth for the Summer Gala has been confirmed.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: AlertType.success,
      isRead: false,
    ),
    AlertModel(
      id: 'alt_2',
      title: 'New Frame Design Available',
      message: 'Check out the new "Vintage Glow" frame added to our collection.',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      type: AlertType.info,
      isRead: false,
    ),
    AlertModel(
      id: 'alt_3',
      title: 'Reminder: Upload Payment Proof',
      message: 'Please upload your transfer receipt for Booking #89412 to finalize.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      type: AlertType.reminder,
      isRead: false,
      actionLabel: 'Upload Now',
      actionRoute: '/checkout',
    ),
    AlertModel(
      id: 'alt_4',
      title: 'Your Event is 3 Days Away!',
      message: 'Get ready for your Birthday Bash! Review your final checklist.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      type: AlertType.warning,
      isRead: true,
    ),
  ];

  @override
  Future<List<AlertModel>> getAlerts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_alerts);
  }

  @override
  Future<void> markAsRead(String alertId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _alerts = _alerts.map((a) {
      if (a.id == alertId) return a.copyWith(isRead: true);
      return a;
    }).toList();
  }
}
