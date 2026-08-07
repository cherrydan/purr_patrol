import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:purr_patrol/l10n/app_localizations.dart';
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
      isChipped: true,
      isSterilized: true,
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
      title: 'Злые собаки!',
      description: 'Местные жители часто выгуливают бойцовских собак без поводка.',
      status: CatStatus.needsFood,
      riskLevel: RiskLevel.urgentDanger, // 🔴 Зона риска
      gender: CatGender.unknown,
      authorId: 'volunteer2',
      createdAt: DateTime.now(),
    ),
  ];

  void _showCatDetailsSheet(CatMarker cat) {
    // 🟢 Получаем l10n прямо здесь, так как контекст доступен внутри builder!
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        Color statusColor = Colors.green;
        String statusText = l10n.catStatusHealthy; // 🟢 Локализовано

        if (cat.riskLevel == RiskLevel.urgentDanger) {
          statusColor = Colors.red;
          statusText = l10n.catStatusDangerDogs; // 🟢 Локализовано
        } else if (cat.status == CatStatus.lostPet) {
          statusColor = Colors.amber;
          statusText = l10n.catStatusLostPet; // 🟢 Локализовано
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Полоска-индикатор для свайпа вниз
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // БЛОК ФОТОГРАФИИ КОТИКА
              Container(
                height: 180,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.shade100),
                ),
                child: cat.imageUrl != null && cat.imageUrl!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          cat.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Icon(Icons.pets_rounded, size: 64, color: Colors.green.withValues(alpha: 0.5)),
                          ),
                        ),
                      )
                    : Center( // 🟢 Локализовано
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.pets_rounded, size: 56, color: Colors.green.withValues(alpha: 0.5)),
                            const SizedBox(height: 8),
                            Text(
                              l10n.photoUnavailable, // 🟢 Локализовано
                              style: const TextStyle(color: Colors.black45, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
              ),

              // Название и статус
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      cat.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 🟢 Блок бейджиков (Чипирован / Стерилизован)
              if (cat.isChipped || cat.isSterilized)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (cat.isChipped)
                      Chip(
                        avatar: const Icon(Icons.qr_code_2_rounded, size: 18, color: Colors.blue),
                        label: Text(
                          l10n.microchipped,
                          style: const TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        backgroundColor: Colors.blue.withValues(alpha: 0.1),
                        side: BorderSide(color: Colors.blue.withValues(alpha: 0.3)),
                      ),
                    if (cat.isSterilized)
                      Chip(
                        avatar: const Icon(Icons.content_cut_rounded, size: 16, color: Colors.purple),
                        label: Text(
                          l10n.sterilized,
                          style: const TextStyle(fontSize: 12, color: Colors.purple),
                        ),
                        backgroundColor: Colors.purple.withValues(alpha: 0.1),
                        side: BorderSide(color: Colors.purple.withValues(alpha: 0.3)),
                      ),
                  ],
                ),

              const SizedBox(height: 20), 


              // Описание
              Text(
                cat.description,
                style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 20),

              // Кнопка помощи
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    logger.i("Нажата кнопка помощи для: ${cat.title}");
                  },
                  icon: const Icon(Icons.favorite_rounded),
                  label: Text(l10n.helpTheCatButton), // 🟢 Локализовано
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2ECC71),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
    
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
          urlTemplate: 'https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
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
                    _showCatDetailsSheet(cat);
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
