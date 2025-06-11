import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/providers/message_provider.dart';
import '../../appointment/data/datasources/auth_providers.dart';
import '../../appointment/domain/entities/doctor.dart';
import '../../appointment/domain/repositories/auth_repository.dart';

final doctorAuthViewModelProvider =
StateNotifierProvider<DoctorAuthViewModel, AsyncValue<void>>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  final setMessage = ref.read(messageProvider.notifier);
  return DoctorAuthViewModel(authRepo, setMessage);
});

class DoctorAuthViewModel extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepo;
  final StateController<String> _setMessage;

  DoctorAuthViewModel(this._authRepo, this._setMessage)
      : super(const AsyncData(null));

  Future<bool> registerDoctor(Map<String, String> data) async {
    state = const AsyncLoading();
    try {
      final doctor = Doctor(
        email: data['email']!,
        password: data['password']!,
        confirmPassword: '',
      );
      final confirmPassword = data['confirmPassword'] ?? '';
      await _authRepo.signUpDoctor(doctor, confirmPassword);
      _setMessage.state = '';
      state = const AsyncData(null);
      return true;
    } catch (e) {
      _setMessage.state = e.toString();
      state = AsyncError(e, StackTrace.current);
      return false;
    }
  }

  Future<bool> loginDoctor(String email, String password) async {
    state = const AsyncLoading();
    try {
      await _authRepo.loginDoctor(email, password);
      _setMessage.state = '';
      state = const AsyncData(null);
      return true;
    } catch (e) {
      _setMessage.state = e.toString();
      state = AsyncError(e, StackTrace.current);
      return false;
    }
  }

}

