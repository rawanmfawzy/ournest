import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ournest/features/lists/services/reminder/remindermodel.dart';
import 'package:ournest/features/lists/services/reminder/reminderservice.dart';

class ReminderCubit extends Cubit<List<ReminderModel>> {
  final ReminderService service;

  ReminderCubit(this.service) : super([]);

  Future<void> loadReminders() async {
    final data = await service.getReminders();

    data.sort((a, b) =>
        b.reminderDateTime.compareTo(a.reminderDateTime));

    emit(data);
  }

  Future<void> addReminder(String title, DateTime date) async {
    final newReminder =
    await service.createReminder(title: title, date: date);

    final updated = [...state, newReminder];

    updated.sort((a, b) =>
        b.reminderDateTime.compareTo(a.reminderDateTime));

    emit(updated);
  }
  Future<void> deleteReminder(String id) async {
    await service.deleteReminder(id);
    emit(state.where((e) => e.id != id).toList());
  }

  Future<void> completeReminder(String id) async {
    await service.completeReminder(id);

    final updated = state.map((e) {
      if (e.id == id) {
        return ReminderModel(
          id: e.id,
          title: e.title,
          description: e.description,
          reminderDateTime: e.reminderDateTime,
          isCompleted: true,
        );
      }
      return e;
    }).toList();

    emit(updated);
  }
}