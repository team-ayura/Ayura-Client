enum BasicUserData {
  userId,
  email,
  firstName,
  lastName,
  profileImage,
  token,
}

extension BasicUserDataExtension on BasicUserData {
  String get label {
    return toString().split('.').last[0].toUpperCase() +
        toString().split('.').last.substring(1);
  }
}
