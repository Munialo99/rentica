import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/main.dart';

final carProvider =
    StateNotifierProvider<CarNotifier, List<Map<String, dynamic>>>(
        (ref) => CarNotifier());

class CarNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  CarNotifier() : super([]) {
    fetchCars();
  }

  Future<void> fetchCars() async {
    final response = await supabase.from('cars').select();
    state = response;
  }

  Future<void> fetchFavoriteCars() async {
    final response =
        await supabase.from('cars').select().eq('is_favorite', true);
    state = response;
  }

  Future<void> fetchTrendingCars() async {
    final response =
        await supabase.from('cars').select().eq('is_trending', true);
    state = response;
  }

  Future<void> fetchPopularCars() async {
    final response =
        await supabase.from('cars').select().eq('is_popular', true);
    state = response;
  }
}
