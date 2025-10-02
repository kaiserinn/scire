import "package:scire/data/repositories/auth/auth_repository.dart";
import "package:scire/utils/command.dart";
import "package:scire/utils/result.dart";

class AuthViewModel {
  AuthViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    login = Command1<void, (String email, String password)>(_login);
    register = Command1<void, (String username, String email, String password)>(
      _register,
    );
  }

  final AuthRepository _authRepository;

  late Command1 login;
  late Command1 register;

  Future<Result<void>> _login(
    (String email, String password) credentials,
  ) async {
    final (email, password) = credentials;
    return await _authRepository.login(email, password);
  }

  Future<Result<void>> _register(
    (String username, String email, String password) credentials,
  ) async {
    final (username, email, password) = credentials;
    return await _authRepository.register(username, email, password);
  }
}
