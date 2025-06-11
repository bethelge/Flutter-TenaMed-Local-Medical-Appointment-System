import '../../domain/entities/doctor.dart';

class DoctorModel {
  final String email;
  final String password;

  DoctorModel({
    required this.email,
    required this.password,
  });

  factory DoctorModel.fromEntity(Doctor doctor) {
    return DoctorModel(
      email: doctor.email,
      password: doctor.password,
    );
  }

  Map<String, dynamic> toJson(String confirmPassword) {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
