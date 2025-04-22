import 'package:dio/dio.dart';

Future<String> getAddressFromLatLng(double lat, double lon) async {
  final dio = Dio();
  final response = await dio.get(
    'https://api.vworld.kr/req/address',
    queryParameters: {
      'service': 'address',
      'request': 'getAddress',
      'crs': 'EPSG:4326',
      'point': '$lon,$lat',
      'format': 'json',
      'type': 'BOTH',//도로명 주소가 존재하지 않을경우를 대비해서 BOTH
      'key': 'AFFAA4C2-BBE3-34D7-BABF-90BD603FA15D',
    },
  );

   print('VWorld 응답: ${response.data}');

  final result = response.data['response']['result'];
  if (result != null && result.isNotEmpty) {
    return result[0]['text'];
  } else {
    throw Exception('주소를 찾을 수 없습니다(좌표: $lat, $lon)');
  }
}
