import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/settings_service.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  Map<String, dynamic>? _profile;
  Map<String, dynamic>? get cachedProfile => _profile;

  /// Load user profile from API
  Future<void> loadProfile() async {
    emit(SettingsLoading());
    try {
      _profile = await SettingsService.getProfile();
      emit(ProfileLoaded(_profile!));
    } catch (e) {
      emit(SettingsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Update profile fields
  Future<void> updateProfile({
    required String fullName,
    String? dateOfBirth,
    String gender = 'Female',
    String? bio,
    String? country,
    String? city,
  }) async {
    emit(SettingsLoading());
    try {
      _profile = await SettingsService.updateProfile(
        fullName: fullName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        bio: bio,
        country: country,
        city: city,
      );
      emit(ProfileUpdated(_profile!));
    } catch (e) {
      emit(SettingsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Upload profile picture
  Future<void> uploadProfilePicture(File image) async {
    emit(SettingsLoading());
    try {
      final url = await SettingsService.uploadProfilePicture(image);
      if (_profile != null) _profile!['profilePictureUrl'] = url;
      emit(ProfilePictureUpdated(url));
    } catch (e) {
      emit(SettingsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Load user app settings
  Future<void> loadSettings() async {
    emit(SettingsLoading());
    try {
      final settings = await SettingsService.getSettings();
      emit(UserSettingsLoaded(settings));
    } catch (e) {
      emit(SettingsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    emit(SettingsLoading());
    try {
      await SettingsService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );
      emit(PasswordChanged());
    } catch (e) {
      emit(SettingsError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
