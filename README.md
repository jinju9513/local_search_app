# 📍 Local Search App

Flutter + Riverpod 기반의 위치 기반 검색 앱입니다.  
VWorld API를 활용하여 사용자의 위치를 주소로 변환하고,  
네이버 지역 검색 API를 통해 장소 정보를 검색합니다.  
Firebase Firestore에 검색 기록을 저장하여 UX를 향상시켰습니다.

---

## 🛠 사용 기술

- **Flutter** 3.24.5
- **Riverpod** (상태관리)
- **Dio** (API 호출)
- **Firebase (Firestore)**
- **Geolocator** (위치)
- **InAppWebView** (상세 페이지)

---

## 📁 프로젝트 구조

```
lib/
├── data/             # 모델 & 리포지토리
│   └── repository/
│       └── search_history_repository.dart
├── ui/
│   ├── detail/
│   │   └── detail_page.dart
│   └── home/
│       ├── home_page.dart
│       └── home_page_view_model.dart
├── firebase_options.dart
└── main.dart
```

---

## ✨ 주요 기능

| 기능 | 설명 |
|------|------|
| 위치 기반 장소 검색 | VWorld → Naver API 연동 |
| 키워드 검색 | TextField로 검색 |
| 검색 기록 저장 | Firestore에 키워드 저장 |
| 중복 제거 + 6개 제한 | 최신 검색어 UX |
| 검색어 클릭 재검색 | Chip 클릭 시 자동 검색 |
| 상세 페이지 열기 | InAppWebView로 연결 |


---

## ⚙️ 실행 방법

```bash
flutter pub get
flutter run
```

- `ios/Podfile` → iOS 13 이상 설정
- `firebase_options.dart` 자동 생성 필요 (`flutterfire configure`)
- 위치 권한 설정 필요 (iOS: Info.plist, Android: Manifest)

---

## 🔍 핵심 코드 예시

### 🔸 Firestore에 검색어 저장

```dart
Future<void> saveKeyword(String keyword) async {
  final existing = await _collection.where('keyword', isEqualTo: keyword).get();
  for (final doc in existing.docs) {
    await doc.reference.delete();
  }
  await _collection.add({'keyword': keyword, 'timestamp': FieldValue.serverTimestamp()});

  final all = await _collection.orderBy('timestamp', descending: true).get();
  if (all.docs.length > 6) {
    final overflow = all.docs.sublist(6);
    for (final doc in overflow) {
      await doc.reference.delete();
    }
  }
}
```

### 🔸 최근 검색어 가로 표시 & 재검색

```dart
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: keywords.map((word) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(
          onTap: () {
            ref.read(locationProvider.notifier).search(word);
          },
          child: Chip(label: Text(word)),
        ),
      );
    }).toList(),
  ),
)
```
## 🧩 향후 개선점

- 즐겨찾기 기능 추가
- Firebase Auth 연동
- 검색 결과 필터링 기능
- 최근 검색어 삭제 기능

---

## 🙋‍♂️ 기여자

- 개발: 전진주
