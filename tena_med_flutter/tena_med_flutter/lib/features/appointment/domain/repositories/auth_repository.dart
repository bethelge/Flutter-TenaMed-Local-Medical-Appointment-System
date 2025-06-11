import '../entities/doctor.dart';
import '../entities/patient.dart';

abstract class AuthRepository {
  Future<void> signUpPatient(Patient patient, String confirmPassword);
  Future<void> signUpDoctor(Doctor doctor, String confirmPassword);
  Future<void> loginPatient(String email, String password);
  Future<void> loginDoctor(String email, String password);
}
