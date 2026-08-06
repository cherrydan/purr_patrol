import 'cat_enums.dart';


class CatMarker {
  final String id;
  final double latitude;
  final double longitude;
  final String title;
  final String description;
  final String? imageUrl;
  final CatStatus status;
  final RiskLevel riskLevel;
  final CatGender gender;
  final String authorId;
  final DateTime createdAt;
  final bool isChipped;
  final bool isSterilized;

  const CatMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.status,
    required this.riskLevel,
    required this.gender,
    required this.authorId,
    required this.createdAt,
    this.isChipped = false,
    this.isSterilized = false,
  });

    // 🟢 Превращаем объект в Map для сохранения в Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'status': status.name, // Enum -> String
      'riskLevel': riskLevel.name, // Enum -> String
      'gender': gender.name, // Enum -> String
      'authorId': authorId,
      'createdAt': createdAt.toIso8601String(), // DateTime -> String
      'isChipped': isChipped,
      'isSterilized': isSterilized,

    };
  }

  // 🟢 Собираем объект из Map, полученного из Firestore
  factory CatMarker.fromMap(Map<String, dynamic> map) {
    return CatMarker(
      id: map['id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      status: CatStatus.values.byName(map['status']), // String -> Enum
      riskLevel: RiskLevel.values.byName(map['riskLevel']), // String -> Enum
      gender: CatGender.values.byName(map['gender']), // String -> Enum
      authorId: map['authorId'],
      createdAt: DateTime.parse(map['createdAt']), // String -> DateTime,
      isChipped: map['isChipped'] ?? false,
      isSterilized: map['isSterilized'] ?? false,

    );
  }


}

   
