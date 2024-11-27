class TrainingUser {
  String userName;
  String email;
  String token;
  DateTime lastLogin;
  String companyName;
  String phoneNumber;
  String role; // Role field to differentiate user roles
  String? profilePictureUrl; // Optional field for profile picture

  TrainingUser({
    required this.userName,
    required this.email,
    required this.token,
    required this.lastLogin,
    required this.companyName,
    required this.phoneNumber,
    this.role = 'student', // Default role if not provided
    this.profilePictureUrl,
  });

  // Method to update login time
  void updateLogin(DateTime newLoginTime) {
    lastLogin = newLoginTime;
  }

  // Method to update user role
  void updateRole(String newRole) {
    role = newRole;
  }

  // Convert TrainingUser to JSON for Firebase storage
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'token': token,
      'lastLogin': lastLogin.toIso8601String(),
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'role': role,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  // Create TrainingUser from JSON retrieved from Firebase
  factory TrainingUser.fromJson(Map<String, dynamic> json) {
    return TrainingUser(
      userName: json['userName'] ?? 'Unknown', // Default value if missing
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      lastLogin: json['lastLogin'] != null
          ? DateTime.parse(json['lastLogin'])
          : DateTime.now(), // Use current time if lastLogin is missing
      companyName: json['companyName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? 'student', // Default role to 'student'
      profilePictureUrl: json['profilePictureUrl'], // Nullable field
    );
  }
}
