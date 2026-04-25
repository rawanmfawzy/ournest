abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

// Profile states
class ProfileLoaded extends SettingsState {
  final Map<String, dynamic> profile;
  ProfileLoaded(this.profile);
}

class ProfileUpdated extends SettingsState {
  final Map<String, dynamic> profile;
  ProfileUpdated(this.profile);
}

class ProfilePictureUpdated extends SettingsState {
  final String url;
  ProfilePictureUpdated(this.url);
}

// User settings states
class UserSettingsLoaded extends SettingsState {
  final Map<String, dynamic> settings;
  UserSettingsLoaded(this.settings);
}

class UserSettingsUpdated extends SettingsState {
  final Map<String, dynamic> settings;
  UserSettingsUpdated(this.settings);
}

// Password
class PasswordChanged extends SettingsState {}

// Error
class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}
