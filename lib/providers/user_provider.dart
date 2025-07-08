import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/data/mock%20data/user/user_data.dart';


class UserNotifier extends StateNotifier<Map<String, dynamic>> {
  UserNotifier() : super(currentUserData);

  // Method to update a specific field in user data
  void updateUserData(String key, dynamic value) {
    state = {
      ...state,
      key: value,
    };
    print('User data updated: $key = $value');
    currentUserData[key] = value; // For mock data persistence
  }
}

// Create the StateNotifierProvider
final userProvider = StateNotifierProvider<UserNotifier, Map<String, dynamic>>((ref) {
  return UserNotifier();
});