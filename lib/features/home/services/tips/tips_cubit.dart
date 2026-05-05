import 'package:flutter_bloc/flutter_bloc.dart';
import 'tips_state.dart';
import 'tips_service.dart';

class TipsCubit extends Cubit<TipsState> {
  final TipsService service;

  TipsCubit(this.service) : super(TipsLoading());

  Future<void> loadTips(int week) async {
    emit(TipsLoading());

    try {
      final tips = await service.getDailyTips(week: week);
      emit(TipsLoaded(tips));
    } catch (e) {
      emit(TipsError(e.toString()));
    }
  }
}