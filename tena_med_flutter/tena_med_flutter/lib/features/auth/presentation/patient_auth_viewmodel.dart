import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/providers/message_provider.dart';
import '../../appointment/data/datasources/auth_providers.dart';
import '../../appointment/domain/repositories/auth_repository.dart';

final patientAuthViewModelProvider =
StateNotifierProvider<PatientAuthViewModel, AsyncValue<void>>((ref) {
  final authRepo = ref.read(authRepositoryProvider);
  final setMessage = ref.read(messageProvider.notifier);
  return PatientAuthViewModel(authRepo, setMessage);
});

class PatientAuthViewModel extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepo;
  final StateController<String> _setMessage;

  PatientAuthViewModel(this._authRepo, this._setMessage) : super(const AsyncData(null));

  Future<bool> loginPatient(String email, String password) async {
    state = const AsyncLoading();
    try {
      await _authRepo.loginPatient(email, password);
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
