import 'package:supabase_flutter/supabase_flutter.dart';

/// Service responsible for authenticating users using Supabase.
class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Creates a new user using [email] and [password].
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
    );
  }

  /// Logs in a user using [email] and [password].
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Signs out the currently authenticated user.
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}
