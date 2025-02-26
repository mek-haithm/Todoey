import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:todey/shared/constants/colors.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for todoey.',
          defaultColor: kMainColor,
          ledColor: kBackground,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        ),
      ],
      debug: true,
    );

    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );

    // Automatically schedule a daily notification at 8 AM
    await scheduleDailyNotification();
  }

  // Listener methods
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification created: ${receivedNotification.id}');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('Notification displayed: ${receivedNotification.id}');
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('Notification dismissed: ${receivedAction.id}');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('Notification action received: ${receivedAction.id}');
    final payload = receivedAction.payload ?? {};
    if (payload["navigate"] == "true") {
      // Handle navigation or any other action
      debugPrint('Navigate to a specific screen');
    }
  }

  // Method to schedule a one-time notification
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDateTime,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
        payload: {"navigate": "true"},
      ),
      schedule: NotificationCalendar.fromDate(date: scheduledDateTime),
    );
    debugPrint('Scheduled one-time notification with ID: $id');
  }

  // Method to schedule a daily notification
  static Future<void> scheduleDailyNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1001, // Unique ID for the daily notification
        channelKey: 'high_importance_channel',
        title: 'Daily Reminder',
        body: 'Start planing your day!',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar(
        hour: 8,
        minute: 0,
        second: 0,
        millisecond: 0,
        repeats: true,
      ),
    );
    debugPrint('Scheduled daily notification at 8:00 AM');
  }
}
