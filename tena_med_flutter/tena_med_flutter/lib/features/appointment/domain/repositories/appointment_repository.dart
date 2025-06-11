import '../entities/appointment.dart';

abstract class AppointmentRepository {
  Future<List<Appointment>> getAppointments(String patientId);
  Future<void> createAppointment(Appointment appointment);
  Future<void> updateAppointment(Appointment appointment);
  Future<void> deleteAppointment(String id);
  Future<void> bookAppointment(Appointment appointment);



}
