import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cat_marker.dart';
import 'app_logger.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http; // Make sure to add this import!



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

  // ... остальные импорты ...

  Future<String?> uploadCatImage(File imageFile) async {
  try {
    final cloudName = 'jrw66nr0';
    final uploadPreset = 'purr_patrol';
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonData = json.decode(responseData);
      final imageUrl = jsonData['secure_url'];
      logger.i("Photo uploaded to Cloudinary: $imageUrl");
      return imageUrl;
    } else {
      logger.e("Failed to upload to Cloudinary. Status: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    logger.e("Error uploading to Cloudinary: $e");
    return null;
  }
}


}

