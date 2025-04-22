import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/data/model/location.dart';
import 'package:local_search_app/data/repository/location_repository.dart';
import 'package:local_search_app/data/repository/search_history_repository.dart';
import 'package:local_search_app/ui/home/widgets/home_get_address_from_latlng.dart';
import 'package:local_search_app/ui/home/widgets/home_get_current_position.dart';

final locationProvider = StateNotifierProvider<HomePageViewModel, List<Location>>((ref) {
  return HomePageViewModel();
});

class HomePageViewModel extends StateNotifier<List<Location>> {
  HomePageViewModel() : super([]);

  final repo = LocationRepository();
  final _historyRepo = SearchHistoryRepository();

  Future<void> search(String keyword) async {
    final result = await repo.search(keyword);
    print('네이버 검색 결과 : $result');
    state = result;
    //검색어 저장
    await _historyRepo.saveKeyword(keyword);
  }

  Future<void> searchByLocation(WidgetRef ref) async {
     try {
    final position = await getCurrentPosition(); // 현재 위치 가져오기
    final address = await getAddressFromLatLng(
      position.latitude,
      position.longitude,
    ); // 좌표 → 주소

    print('내 주소: $address');
    final keyword = address.split(" ").take(2).join(" "); // 키워드 짧게 추출
    await ref.read(locationProvider.notifier).search(keyword); // ← 네이버 API로 검색 실행

  } catch (e) {
    print('위치 기반 검색 실패: $e');
  }
  }

}
