import 'package:flutter/cupertino.dart';

class NotificationProvider with ChangeNotifier {
  final Map<int, int> _notificationIds = {};  // Store taskId -> notificationId

  // Get notification ID for a given task ID
  int? getNotificationId(int taskId) => _notificationIds[taskId];

  // Set notification ID for a task
  void setNotificationId(int taskId, int notificationId) {
    _notificationIds[taskId] = notificationId;
    notifyListeners();
  }

  // Remove notification ID when a task is deleted
  void removeNotificationId(int taskId) {
    _notificationIds.remove(taskId);
    notifyListeners();
  }
}
