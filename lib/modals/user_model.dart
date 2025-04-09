class User {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  User({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'phoneNumber': phoneNumber,
    'password': password,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    fullName: json['fullName'] ?? '',
    email: json['email'] ?? '',
    phoneNumber: json['phoneNumber'] ?? '',
    password: json['password'] ?? '',
  );
}
