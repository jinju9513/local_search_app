import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHistoryRepository {
  final _collection = FirebaseFirestore.instance.collection('search_history');

  Future<void> saveKeyword(String keyword) async {
    final existing =
        await _collection.where('keyword', isEqualTo: keyword).get();

    // 1. 중복 있으면 삭제
    for (final doc in existing.docs) {
      await doc.reference.delete();
    }
    // 2. 새로 저장
    await _collection.add({
      'keyword': keyword,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // 3. 전체가 6개 초과면 오래된 것 삭제
    final all = await _collection.orderBy('timestamp', descending: true).get();

    if (all.docs.length > 6) {
      final overflow = all.docs.sublist(6); // 7번째부터 잘라냄
      for (final doc in overflow) {
        await doc.reference.delete();
      }
    }
  }

  Stream<List<String>> getRecentKeywords() {
    return _collection
        .orderBy('timestamp', descending: true)
        .limit(6)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc['keyword'] as String).toList());
  }
}
