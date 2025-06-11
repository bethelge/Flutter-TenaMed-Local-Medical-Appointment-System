class DoctorModel {
  final String email;
  final String password;
  final String confirmPassword;

  DoctorModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
