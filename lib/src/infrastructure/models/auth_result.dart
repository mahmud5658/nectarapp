import 'package:supabase_flutter/supabase_flutter.dart';

class AuthResult {
  final bool isSuccess;
  final User? user;
  final String? message;

  AuthResult._({required this.isSuccess, this.user, this.message});

  factory AuthResult.success({User? user}) {
    return AuthResult._(isSuccess: true, user: user);
  }

  factory AuthResult.failure({required String message}) {
    return AuthResult._(isSuccess: false, message: message);
  }
}
