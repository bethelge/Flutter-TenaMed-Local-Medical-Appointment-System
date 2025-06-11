import '../../domain/entities/appointment.dart';
import '../../domain/repositories/appointment_repository.dart';

class AppointmentViewModel {
  final AppointmentRepository repository;

  AppointmentViewModel(this.repository);

  Future<void> bookAppointment(Appointment appointment) async {
    await repository.bookAppointment(appointment);
  }
}
