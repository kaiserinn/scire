class User {
  User({required this.username, required this.email, required this.token});

  final String username;
  final String email;
  final String token;

  User.fromJson(Map<String, dynamic> json)
    : username = json["username"] as String,
      email = json["email"] as String,
      token = json["token"] as String;
}

class AuthResponse {
  AuthResponse({required this.user});

  final User user;

  AuthResponse.fromJson(Map<String, dynamic> json)
    : user = User.fromJson(json["user"]);
}
