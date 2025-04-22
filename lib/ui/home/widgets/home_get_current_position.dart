import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('위치 서비스가 꺼져 있습니다');
  }

  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('위치 권한이 거부되었습니다');
    }
  }

  // 영구 거부된 경우 설정으로 유도
  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openAppSettings(); // 설정 앱으로 이동
    return Future.error('위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
