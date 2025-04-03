import '../infrastructure.dart';

class AuthService {
  const AuthService._(this.user);

  /// create diff state and return from stream

  final UserModel? user;

  static Future<AuthService> create() async {
    ///load from app cache if already have logged in
    return AuthService._(null);
  }
}
