import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cat_marker.dart';
import 'app_logger.dart';

class CatService {
  // Название коллекции в Firestore
  final CollectionReference _markersCollection =
      FirebaseFirestore.instance.collection('cat_markers');

  // 🟢 1. Сохраняем новую метку котика в Firestore
  Future<void> addCatMarker(CatMarker marker) async {
    try {
      // Превращаем объект CatMarker в Map через метод toMap()
      await _markersCollection.doc(marker.id).set(marker.toMap());
      logger.i("Метка котика успешно сохранена в Firestore: ${marker.title}");
    } catch (e) {
      logger.e("Ошибка при сохранении метки котика: $e");
      rethrow;
    }
  }

  // 🟢 2. Получаем поток (Stream) всех меток котиков из Firestore в реальном времени
  Stream<List<CatMarker>> getCatMarkersStream() {
    return _markersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CatMarker.fromMap(data);
      }).toList();
    });
  }
}
