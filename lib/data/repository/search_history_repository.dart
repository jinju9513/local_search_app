import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHistoryRepository {
  final _collection = FirebaseFirestore.instance.collection('search_history');

  Future<void> saveKeyword(String keyword) async {
    await _collection.add({
      'keyword': keyword,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<String>> getRecentKeywords() {
    return _collection
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc['keyword'] as String).toList());
  }
}
