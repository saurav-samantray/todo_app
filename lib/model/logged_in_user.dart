class LoggedInUser {
  static String tag = 'logged-in-user';
  final String token;
  final String refreshToken;
  final String email;
  final String role;

  const LoggedInUser({
    required this.token,
    required this.refreshToken,
    required this.email,
    required this.role,
    //required this.permissions
  });

  factory LoggedInUser.fromJson(Map<String, dynamic> json) {
    return LoggedInUser(
      token: json['token'],
      refreshToken: json['refreshToken'],
      email: json['email'],
      role: json['role'],
    );
  }
}