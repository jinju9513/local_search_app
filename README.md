# 📍 Flutter Location Search App

Flutter + Riverpod + 네이버 API + VWorld API로 구현한
실시간 위치 기반 장소 검색 앱입니다.

사용자의 현재 위치를 기반으로 주변 장소를 검색하고,
상세 정보를 InAppWebView로 확인할 수 있습니다.

---

## 📦 프로젝트 구조

```bash
lib/
├── data/
│   ├── model/
│   │   └── location.dart                 # 장소 정보를 담는 모델
│   └── repository/
│       └── location_repository.dart      # 네이버 검색 API 요청
│
├── ui/
│   ├── detail/
│   │   └── detail_page.dart              # 웹뷰 상세 페이지
│   └── home/
│       ├── home_page.dart                # 메인 화면
│       ├── home_page_view_model.dart     # 상태 관리 로직 (with Riverpod)
│       └── widgets/
│           ├── home_clean_text.dart          # 검색 결과 텍스트 전처리
│           ├── home_get_current_position.dart# 위치 정보 받아오기
│           ├── home_get_address_from_latlng.dart # 위경도 → 주소 변환 (VWorld)
│           └── test.dart
│
└── main.dart                            # 앱 진입점
```

---

## 🧩 주요 기능

- ✅ 위치 권한 요청 및 예외 처리
- ✅ 현재 위치 가져오기 (`Geolocator`)
- ✅ 위경도 → 주소 변환 (`VWorld API`)
- ✅ 주소 기반 장소 검색 (`네이버 지역 검색 API`)
- ✅ 검색 결과 리스트 출력
- ✅ 웹뷰 상세 페이지 이동 (`flutter_inappwebview`)
- ✅ MVVM 패턴 적용 with `flutter_riverpod`

---

## 🚀 실행 방법

```bash
flutter pub get
flutter run
```

> iOS 시뮬레이터를 사용하는 경우:
> - Features → Location → Custom Location에서 한국 좌표 설정 필요
>   예: `37.5665`, `126.9780` (서울시청)

---

## 🔑 API 키 설정

### 📌 VWorld API

- [VWorld](https://www.vworld.kr/dev/v4api.do) 개발자 센터에서 API Key 발급
- 활용 API: `주소 검색 API`

```dart
final response = await dio.get(
  'https://api.vworld.kr/req/address',
  queryParameters: {
    'service': 'address',
    'request': 'getAddress',
    'crs': 'EPSG:4326',
    'point': '$lon,$lat',
    'format': 'json',
    'type': 'BOTH',
    'key': '💡 YOUR_VWORLD_API_KEY',
  },
);
```

### 📌 네이버 지역 검색 API

- [네이버 개발자 센터](https://developers.naver.com/)에서 애플리케이션 등록
- Client ID, Client Secret 설정 필요

```dart
final headers = {
  'X-Naver-Client-Id': '💡 YOUR_CLIENT_ID',
  'X-Naver-Client-Secret': '💡 YOUR_CLIENT_SECRET',
};
```

---

## 🛠 사용한 패키지

```yaml
dependencies:
  flutter:
  flutter_riverpod:
  dio:
  geolocator:
  flutter_inappwebview:
```

---

## 👋 개발자 메모

- 처음 Flutter 위치 기반 기능을 구현해보며 실제 디버깅을 경험할 수 있었던 좋은 프로젝트였습니다.
- 실제 앱 배포를 위해선 위치 캐시, 즐겨찾기, 검색 기록 저장 기능도 확장 가능성이 있습니다.

---

## 🔗 관련 링크

- [VWorld API 문서](https://www.vworld.kr/dev/v4dv_address2d.do)
- [네이버 지역 검색 API 문서](https://developers.naver.com/docs/search/local/)
