import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:purr_patrol/models/cat_enums.dart';
import 'package:purr_patrol/models/cat_marker.dart';
import '../services/app_logger.dart';
   


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Стартовые координаты: Мадрид, Испания (Центр Южной Европы)
  final LatLng _initialCenter = const LatLng(40.416775, -3.703790);

  // 🟢 Тестовые метки в центре Мадрида
  final List<CatMarker> _catMarkers = [
    CatMarker(
      id: '1',
      latitude: 40.418,
      longitude: -3.702,
      title: 'Мадридский Усач',
      description: 'Здоровый сытый кот, живет у пекарни.',
      status: CatStatus.healthy,
      riskLevel: RiskLevel.safe,
      gender: CatGender.male,
      authorId: 'admin',
      createdAt: DateTime.now(),
    ),
    CatMarker(
      id: '2',
      latitude: 40.415,
      longitude: -3.706,
      title: 'Потеряшка Мигель',
      description: 'Домашний рыжий кот, пугливый, ищут хозяева.',
      status: CatStatus.lostPet,
      riskLevel: RiskLevel.safe,
      gender: CatGender.male,
      authorId: 'volunteer1',
      createdAt: DateTime.now(),
    ),
    CatMarker(
      id: '3',
      latitude: 40.419,
      longitude: -3.708,
      title: 'Осторожно: собаки!',
      description: 'Местные жители часто выгуливают бойцовских собак без поводка.',
      status: CatStatus.needsFood,
      riskLevel: RiskLevel.urgentDanger, // 🔴 Зона риска
      gender: CatGender.unknown,
      authorId: 'volunteer2',
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _initialCenter,
          initialZoom: 14.0,
        ),
        children: [
          // 1. Слой плиток карты (улицы)
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.purrpatrol.purr_patrol',
          ),
          
          // 2. 🟢 Слой наших меток с котиками
          MarkerLayer(
            markers: _catMarkers.map((cat) {
              // Выбираем цвет маркера в зависимости от уровня опасности или статуса
              Color markerColor = Colors.green;
              if (cat.riskLevel == RiskLevel.urgentDanger) {
                markerColor = Colors.red; // Опасно!
              } else if (cat.status == CatStatus.lostPet) {
                markerColor = Colors.amber; // Потеряшка
              }

              return Marker(
                point: LatLng(cat.latitude, cat.longitude),
                width: 40,
                height: 40,
                child: GestureDetector(
                  onTap: () {
                    // Пока просто выводим название в консоль по клику
                    logger.i("Кликнули на кота: ${cat.title}");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: markerColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.pets_rounded, // Иконка лапки
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
