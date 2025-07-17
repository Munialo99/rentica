import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/main.dart';
import 'package:rentica/services/auth_service.dart';

final rememberMeProvider = StateProvider<bool>((ref) => false);

final obscurePasswordProvider = StateProvider<bool>((ref) => true);

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(supabase);
});
