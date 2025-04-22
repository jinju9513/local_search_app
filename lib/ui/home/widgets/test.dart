import 'package:local_search_app/ui/home/widgets/home_get_address_from_latlng.dart';

void testAddressLookup() async {
  double testLat = 37.5665;
  double testLon = 126.9780;

  try {
    final address = await getAddressFromLatLng(testLat, testLon);
    print('✅ 주소 가져오기 성공: $address');
  } catch (e) {
    print('❌ 주소 가져오기 실패: $e');
  }
}
