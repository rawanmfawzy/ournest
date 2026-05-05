abstract class PeriodState {}

class PeriodInitial extends PeriodState {}

class PeriodLoading extends PeriodState {}

class PeriodLoaded extends PeriodState {
  final List<Map<String, dynamic>> periods;
  final Map<String, dynamic>? prediction;

  PeriodLoaded({required this.periods, this.prediction});
}

class PeriodError extends PeriodState {
  final String message;
  PeriodError(this.message);
}

class PeriodAdding extends PeriodState {}

class PeriodAdded extends PeriodState {
  final Map<String, dynamic> entry;
  PeriodAdded(this.entry);
}

class PeriodAddError extends PeriodState {
  final String message;
  PeriodAddError(this.message);
}
