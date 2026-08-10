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
    // 🟢 Пуленепробиваемый сборщик объекта из Map
  factory CatMarker.fromMap(Map<String, dynamic> map) {
    return CatMarker(
      id: map['id'] ?? '',
      latitude: (map['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (map['longitude'] as num?)?.toDouble() ?? 0.0,
      title: map['title'] ?? 'Без названия',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'],
      status: CatStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => CatStatus.healthy, // Фолбэк, если статус не совпал
      ),
      riskLevel: RiskLevel.values.firstWhere(
        (e) => e.name == map['riskLevel'],
        orElse: () => RiskLevel.safe, // Фолбэк, если риск не совпал
      ),
      gender: CatGender.values.firstWhere(
        (e) => e.name == map['gender'],
        orElse: () => CatGender.unknown, // Фолбэк, если пол не совпал
      ),
      isChipped: map['isChipped'] ?? false,
      isSterilized: map['isSterilized'] ?? false,
      authorId: map['authorId'] ?? '',
      createdAt: map['createdAt'] != null 
          ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }



}

   
