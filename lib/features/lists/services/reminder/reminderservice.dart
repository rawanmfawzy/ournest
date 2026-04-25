import 'package:dio/dio.dart';
import 'package:ournest/features/lists/services/reminder/remindermodel.dart';

class ReminderService {
  final Dio dio;

  ReminderService(this.dio);

  Future<List<ReminderModel>> getReminders() async {
    final res = await dio.get('/reminders');

    return (res.data as List)
        .map((e) => ReminderModel.fromJson(e))
        .toList();
  }

  Future<ReminderModel> createReminder({
    required String title,
    required DateTime date,
  }) async {
    final res = await dio.post(
      '/reminders',
      data: {
        "title": title,
        "description": "",
        "reminderDateTime": date.toIso8601String(),
        "recurrencePattern": "None",
        "category": "General"
      },
    );

    return ReminderModel.fromJson(res.data);
  }

  Future<void> deleteReminder(String id) async {
    await dio.delete('/reminders/$id');
  }

  Future<void> completeReminder(String id) async {
    await dio.patch('/reminders/$id/complete');
  }
  Future<ReminderModel> shareReminder({
    required String id,
    required bool sharedWithPartner,
  }) async {
    final res = await dio.patch(
      '/reminders/$id/share',
      data: {
        "sharedWithPartner": sharedWithPartner,
      },
    );

    return ReminderModel.fromJson(res.data);
  }
}