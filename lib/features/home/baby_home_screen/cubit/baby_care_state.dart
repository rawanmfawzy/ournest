abstract class BabyCareState {}

class BabyCareInitial extends BabyCareState {}

class BabyCareLoading extends BabyCareState {}

class BabyCareLoaded extends BabyCareState {
  final Map<String, dynamic> data;
  final String type; // 'feeding' | 'vitamins' | 'vaccinations' | 'all'
  BabyCareLoaded({required this.data, required this.type});
}

class BabyCareError extends BabyCareState {
  final String message;
  BabyCareError(this.message);
}
