import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/location.dart';
import 'package:local_search_app/data/repository/location_repository.dart';

final locationProvider = StateNotifierProvider<HomePageViewModel, List<Location>>((ref) {
  return HomePageViewModel();
});

class HomePageViewModel extends StateNotifier<List<Location>> {
  HomePageViewModel() : super([]);

  final repo = LocationRepository();

  Future<void> search(String keyword) async {
    final result = await repo.search(keyword);
    state = result;
  }
}
