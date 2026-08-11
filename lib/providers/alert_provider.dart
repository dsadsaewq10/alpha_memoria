import 'package:flutter/foundation.dart';
import '../data/repositories/alert_repository.dart';
import '../models/alert_model.dart';

class AlertProvider extends ChangeNotifier {
  final AlertRepository _alertRepository;

  List<AlertModel> _alerts = [];
  bool _isLoading = false;

  AlertProvider({required AlertRepository alertRepository})
      : _alertRepository = alertRepository {
    loadAlerts();
  }

  List<AlertModel> get alerts => _alerts;
  int get unreadCount => _alerts.where((a) => !a.isRead).length;
  bool get isLoading => _isLoading;

  Future<void> loadAlerts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _alerts = await _alertRepository.getAlerts();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead(String alertId) async {
    await _alertRepository.markAsRead(alertId);
    _alerts = _alerts.map((a) {
      if (a.id == alertId) return a.copyWith(isRead: true);
      return a;
    }).toList();
    notifyListeners();
  }
}
