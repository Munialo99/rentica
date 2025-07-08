import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteBtnProvider = StateNotifierProvider<FavoriteBtnNotifier, Map<String, bool>>(
      (ref) => FavoriteBtnNotifier(),
);

class FavoriteBtnNotifier extends StateNotifier<Map<String, bool>> {
  FavoriteBtnNotifier() : super({});

  void toggle(String id) {
    final current = state[id] ?? false;
    state = {...state, id: !current};
  }

  bool isFavorited(String id) => state[id] ?? false;
}
