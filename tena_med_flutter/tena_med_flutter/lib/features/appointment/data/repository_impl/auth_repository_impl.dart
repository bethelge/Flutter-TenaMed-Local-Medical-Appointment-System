import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/patient.dart' as domain;
import '../../domain/entities/doctor.dart' as domainDoctor;
import '../models/patient_model.dart';
import '../models/doctor_model.dart';
import '../datasources/auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl({required this.authApi});

  @override
  Future<void> signUpPatient(domain.Patient patient, String confirmPassword) async {
    final patientModel = Patient(
      email: patient.email,
      password: patient.password,
    );
    await authApi.signUpPatient(patientModel, confirmPassword);
  }

  @override
  Future<void> signUpDoctor(domainDoctor.Doctor doctor, String confirmPassword) async {
    final doctorModel = DoctorModel(
      email: doctor.email,
      password: doctor.password,
    );
    await authApi.signUpDoctor(doctorModel, confirmPassword);
  }
  @override
  Future<void> loginPatient(String email, String password) async {
    await authApi.loginPatient(email, password);
  }
  @override
  Future<void> loginDoctor(String email, String password) async {
    await authApi.loginDoctor(email, password);
  }

}
