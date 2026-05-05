import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/baby_care_service.dart';
import 'baby_care_state.dart';

class BabyCareCubit extends Cubit<BabyCareState> {
  BabyCareCubit() : super(BabyCareInitial());

  /// Load feeding tips for given baby age
  Future<void> loadFeeding({String? age}) async {
    emit(BabyCareLoading());
    try {
      final data = await BabyCareService.getFeedingTips(age: age);
      emit(BabyCareLoaded(data: data, type: 'feeding'));
    } catch (e) {
      emit(BabyCareError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Load vitamin recommendations for given baby age
  Future<void> loadVitamins({String? age}) async {
    emit(BabyCareLoading());
    try {
      final data = await BabyCareService.getVitamins(age: age);
      emit(BabyCareLoaded(data: data, type: 'vitamins'));
    } catch (e) {
      emit(BabyCareError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Load vaccination schedule for given baby age
  Future<void> loadVaccinations({String? age}) async {
    emit(BabyCareLoading());
    try {
      final data = await BabyCareService.getVaccinations(age: age);
      emit(BabyCareLoaded(data: data, type: 'vaccinations'));
    } catch (e) {
      emit(BabyCareError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Load by type string — convenience method used by detail page
  Future<void> loadByType(String type, {String? age}) async {
    switch (type) {
      case 'feeding':
        await loadFeeding(age: age);
        break;
      case 'vitamins':
        await loadVitamins(age: age);
        break;
      case 'vaccinations':
        await loadVaccinations(age: age);
        break;
      default:
        emit(BabyCareLoading());
        try {
          final data = await BabyCareService.getAll(age: age);
          emit(BabyCareLoaded(data: data, type: 'all'));
        } catch (e) {
          emit(BabyCareError(e.toString().replaceFirst('Exception: ', '')));
        }
    }
  }
}
