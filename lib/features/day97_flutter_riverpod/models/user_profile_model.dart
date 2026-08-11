class UserProfile {
  final String name;
  final String email;
  final bool isOnline;

  UserProfile({
    required this.name,
    required this.email,
    required this.isOnline,
  });

  UserProfile copyWith({String? name, String? email, bool? isOnline}) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
