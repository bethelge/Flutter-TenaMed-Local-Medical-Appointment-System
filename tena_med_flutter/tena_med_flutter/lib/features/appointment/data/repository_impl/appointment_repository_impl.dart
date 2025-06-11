import '../../domain/entities/appointment.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../services/appointment_service.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentService service;

  AppointmentRepositoryImpl(this.service);

  @override
  Future<List<Appointment>> getAppointments(String patientId) async {
    final rawList = await service.getAppointments(patientId);

    return rawList.map((json) => Appointment.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> createAppointment(Appointment appointment) {
    return service.createAppointment(appointment.toJson() as Appointment);
  }

  @override
  Future<void> updateAppointment(Appointment appointment) {
    return service.updateAppointment(appointment.id! as Appointment, appointment.toJson());
  }

  @override
  Future<void> deleteAppointment(String id) {
    return service.deleteAppointment(id);
  }
  @override
  Future<void> bookAppointment(Appointment appointment) {
    return service.bookAppointment(appointment); // assuming this method exists in AppointmentService
  }

}
