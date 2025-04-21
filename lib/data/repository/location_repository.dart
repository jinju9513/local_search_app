import 'package:dio/dio.dart';
import 'package:local_search_app/data/model/location.dart';

class LocationRepository {
  final dio = Dio();
  final String clientId = 'YOUR_CLIENT_ID';
  final String clientSecret = 'YOUR_CLIENT_SECRET';

  Future<List<Location>> search(String query) async {
    final response = await dio.get(
      'https://openapi.naver.com/v1/search/local.json',
      queryParameters: {
        'query': query,
        'display': 10,
      },
      options: Options(
        headers: {
          'X-Naver-Client-Id': 'zzMorvCkKZVco0di3mnq',
          'X-Naver-Client-Secret': 'JdDVljAuYC',
        },
      ),
    );

    final items = response.data['items'] as List;
    return items.map((json) => Location.fromJson(json)).toList();
  }
}
