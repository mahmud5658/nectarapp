import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {

 static  Future<AuthResponse?> signUp({
    required String email,
    required String password,
  }) async {
    SupabaseClient _client = Supabase.instance.client;
    try {
      final response = await _client.auth.signUp(email: email, password: password);
      return response;
    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }
  static  Future<AuthResponse?> signIn({

    required String email,
    required String password,
  }) async {
     SupabaseClient _client = Supabase.instance.client;
    try {
      final response = await _client.auth.signInWithPassword(email: email, password: password);
      return response;
    } catch (e) {
      print("Sign In Error: $e");
      return null;
    }
  }

  static Future<void> signOut() async {
     SupabaseClient _client = Supabase.instance.client;
    try {
      await _client.auth.signOut();
    } catch (e) {
      print("Sign Out Error: $e");
    }
  }

  User? getCurrentUser() {
     SupabaseClient _client = Supabase.instance.client;
    try {
      return _client.auth.currentUser;
    } catch (e) {
      print("Get User Error: $e");
      return null;
    }
  }

  static Future<void> sendPasswordResetEmail(String email) async {
     SupabaseClient _client = Supabase.instance.client;
    try {
      await _client.auth.resetPasswordForEmail(email);
    } catch (e) {
      print("Reset Password Error: $e");
    }
  }

static 
  bool isLoggedIn() {
     SupabaseClient _client = Supabase.instance.client;
    return _client.auth.currentUser != null;
  }
}
