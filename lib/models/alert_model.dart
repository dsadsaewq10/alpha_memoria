enum AlertType { info, warning, success, reminder }

class AlertModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final AlertType type;
  final bool isRead;
  final String? actionLabel;
  final String? actionRoute;

  AlertModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.actionLabel,
    this.actionRoute,
  });

  AlertModel copyWith({
    bool? isRead,
  }) {
    return AlertModel(
      id: id,
      title: title,
      message: message,
      timestamp: timestamp,
      type: type,
      isRead: isRead ?? this.isRead,
      actionLabel: actionLabel,
      actionRoute: actionRoute,
    );
  }
}
