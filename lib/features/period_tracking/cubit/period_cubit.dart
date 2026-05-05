import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/period_service.dart';
import 'period_state.dart';

class PeriodCubit extends Cubit<PeriodState> {
  PeriodCubit() : super(PeriodInitial());

  List<Map<String, dynamic>> _periods = [];
  Map<String, dynamic>? _prediction;

  /// Load period history and predictions together
  Future<void> loadData() async {
    emit(PeriodLoading());
    try {
      final results = await Future.wait([
        PeriodService.getPeriods(),
        PeriodService.getPredictions().catchError((_) => <String, dynamic>{}),
      ]);

      _periods = results[0] as List<Map<String, dynamic>>;
      _prediction = results[1] as Map<String, dynamic>?;

      emit(PeriodLoaded(periods: _periods, prediction: _prediction));
    } catch (e) {
      emit(PeriodError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Log a new period start date
  Future<void> logPeriod({
    required String startDate,
    String? endDate,
    int? cycleLengthDays,
    int? periodLengthDays,
    String? flowIntensity,
    String? symptoms,
    String? notes,
  }) async {
    emit(PeriodAdding());
    try {
      final entry = await PeriodService.addPeriod(
        startDate: startDate,
        endDate: endDate,
        cycleLengthDays: cycleLengthDays,
        periodLengthDays: periodLengthDays,
        flowIntensity: flowIntensity,
        symptoms: symptoms,
        notes: notes,
      );
      emit(PeriodAdded(entry));
      // Reload data to get updated list and predictions
      await loadData();
    } catch (e) {
      emit(PeriodAddError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
