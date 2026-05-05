import 'tipmodel.dart';

abstract class TipsState {}

class TipsLoading extends TipsState {}

class TipsLoaded extends TipsState {
  final List<TipModel> tips;
  TipsLoaded(this.tips);
}

class TipsError extends TipsState {
  final String message;
  TipsError(this.message);
}