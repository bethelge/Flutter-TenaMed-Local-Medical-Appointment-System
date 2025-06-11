import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tena_med_flutter/features/appointment/data/services/appointment_service.dart';
import '../../appointment/data/repository_impl/appointment_repository_impl.dart';
import '../../appointment/domain/entities/appointment.dart';
import '../../appointment/domain/repositories/appointment_repository.dart';
import '../../../core/common/providers/message_provider.dart';

/// Provides the appointment repository instance using the AppointmentService.
final appointmentRepositoryProvider = Provider<AppointmentRepository>((ref) {
  return AppointmentRepositoryImpl(AppointmentService());
});

/// ViewModel using Riverpod's StateNotifier to manage appointments.
final appointmentViewModelProvider = StateNotifierProvider<AppointmentViewModel, AsyncValue<List<Appointment>>>((ref) {
  final repo = ref.read(appointmentRepositoryProvider);
  final msg = ref.read(messageProvider.notifier);
  return AppointmentViewModel(repo, msg);
});

class AppointmentViewModel extends StateNotifier<AsyncValue<List<Appointment>>> {
  final AppointmentRepository _repo;
  final StateController<String> _msg;

  AppointmentViewModel(this._repo, this._msg) : super(const AsyncValue.data([]));

  Future<void> fetchAppointments(String patientId) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repo.getAppointments(patientId);
      state = AsyncValue.data(result);
    } catch (e, st) {
      _msg.state = e.toString();
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> create(Appointment appointment) async {
    try {
      await _repo.createAppointment(appointment);
      _msg.state = 'Appointment created';
      await fetchAppointments(appointment.patientId.toString());
    } catch (e) {
      _msg.state = e.toString();
    }
  }

  Future<void> delete(String id, String patientId) async {
    try {
      await _repo.deleteAppointment(id);
      _msg.state = 'Appointment deleted';
      await fetchAppointments(patientId);
    } catch (e) {
      _msg.state = e.toString();
    }
  }

  Future<void> update(Appointment appointment) async {
    try {
      await _repo.updateAppointment(appointment);
      _msg.state = 'Appointment updated';
      await fetchAppointments(appointment.patientId.toString());
    } catch (e) {
      _msg.state = e.toString();
    }
  }

  /// Optional: Only keep this if booking has special business logic
  Future<void> bookAppointment(Appointment appointment) async {
    try {
      await _repo.bookAppointment(appointment);
      _msg.state = 'Appointment booked';
      await fetchAppointments(appointment.patientId.toString());
    } catch (e) {
      _msg.state = e.toString();
    }
  }
}
