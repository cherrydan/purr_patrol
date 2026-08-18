import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/cat_marker.dart';
import '../models/cat_enums.dart';
import '../services/cat_service.dart';
import '../services/app_logger.dart';
import '../l10n/app_localizations.dart';
import 'add_cat_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Стартовые координаты: Мадрид
  final LatLng _initialCenter = const LatLng(40.416775, -3.703790);
  final CatService _catService = CatService();
  final MapController _mapController = MapController();

  // 🟢 Переменная текущего фильтра (null = "Все")
  CatStatus? _selectedFilterStatus = CatStatus.injured;

  // 🟢 Получение текущей геолокации (GPS)
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );

    _mapController.move(LatLng(position.latitude, position.longitude), 14.0);
  }

  // 🟢 Выезжающая карточка с деталями котика
  void _showCatDetailsSheet(CatMarker cat) {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        Color statusColor = Colors.green;
        String statusText = l10n.catStatusHealthy;

        if (cat.riskLevel == RiskLevel.urgentDanger) {
          statusColor = Colors.red;
          statusText = l10n.catStatusDangerDogs;
        } else if (cat.status == CatStatus.lostPet) {
          statusColor = Colors.amber;
          statusText = l10n.catStatusLostPet;
        }

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Полоска для свайпа вниз
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

              // Блок фото с кэшированием
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
                        child: CachedNetworkImage(
                          imageUrl: cat.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(Icons.pets_rounded,
                                size: 64,
                                color: Colors.green.withValues(alpha: 0.5)),
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.pets_rounded,
                                size: 56,
                                color: Colors.green.withValues(alpha: 0.5)),
                            const SizedBox(height: 8),
                            Text(
                              l10n.photoUnavailable,
                              style: const TextStyle(
                                  color: Colors.black45, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
              ),

              // Заголовок + Иконка пола + Плашка статуса
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            cat.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        cat.gender == CatGender.male
                            ? const Icon(Icons.male_rounded, color: Colors.blue)
                            : cat.gender == CatGender.female
                                ? const Icon(Icons.female_rounded,
                                    color: Colors.pink)
                                : const Icon(Icons.help_outline_rounded,
                                    color: Colors.grey),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
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
              const SizedBox(height: 8),

              // Время создания
              Text(
                '${l10n.addedOn} ${cat.createdAt.day}.${cat.createdAt.month}.${cat.createdAt.year} '
                '${cat.createdAt.hour}:${cat.createdAt.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),

              // Бейджики чипирования и стерилизации
              if (cat.isChipped || cat.isSterilized)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (cat.isChipped)
                      Chip(
                        avatar: const Icon(Icons.qr_code_2_rounded,
                            size: 18, color: Colors.blue),
                        label: Text(
                          l10n.microchipped,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                        backgroundColor: Colors.blue.withValues(alpha: 0.1),
                        side: BorderSide(
                            color: Colors.blue.withValues(alpha: 0.3)),
                      ),
                    if (cat.isSterilized)
                      Chip(
                        avatar: const Icon(Icons.content_cut_rounded,
                            size: 16, color: Colors.purple),
                        label: Text(
                          l10n.sterilized,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.purple),
                        ),
                        backgroundColor: Colors.purple.withValues(alpha: 0.1),
                        side: BorderSide(
                            color: Colors.purple.withValues(alpha: 0.3)),
                      ),
                  ],
                ),
              const SizedBox(height: 12),

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
                  label: Text(l10n.helpTheCatButton),
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Карта
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _initialCenter,
              initialZoom: 14.0,
              onTap: (tapPosition, point) {
                logger.i("Кликнули по карте в точку: ${point.latitude}, ${point.longitude}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCatScreen(
                      latitude: point.latitude,
                      longitude: point.longitude,
                    ),
                  ),
                );
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://a.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.purrpatrol.purr_patrol',
              ),
              StreamBuilder<List<CatMarker>>(
                stream: _catService.getCatMarkersStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const MarkerLayer(markers: <Marker>[]);
                  }

                  final markersFromCloud = snapshot.data ?? [];

                  // 🟢 Фильтрация меток по фильтру
                  final displayedMarkers = _selectedFilterStatus == null
                      ? markersFromCloud
                      : markersFromCloud
                          .where((cat) => cat.status == _selectedFilterStatus)
                          .toList();

                  return MarkerLayer(
                    markers: displayedMarkers.map((cat) {
                      Color markerColor = Colors.green;
                      if (cat.riskLevel == RiskLevel.urgentDanger) {
                        markerColor = Colors.red;
                      } else if (cat.status == CatStatus.lostPet) {
                        markerColor = Colors.amber;
                      }

                      return Marker(
                        point: LatLng(cat.latitude, cat.longitude),
                        width: 40,
                        height: 40,
                        child: GestureDetector(
                          onTap: () {
                            logger.i("Кликнули на кота: ${cat.title}");
                            _showCatDetailsSheet(cat);
                          },
                          onDoubleTap: () {
                            logger.i("Двойной клик для редактирования: ${cat.title}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddCatScreen(
                                  latitude: cat.latitude,
                                  longitude: cat.longitude,
                                  catToEdit: cat,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: markerColor,
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 2),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.pets_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),

          // 2. Верхняя лента чипов-фильтров
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Чип "Все"
                    ChoiceChip(
                      label: const Text('Все 🐾'),
                      selected: _selectedFilterStatus == null,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedFilterStatus = null;
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    // Чип "Травмирован"
                    ChoiceChip(
                      label: Text(l10n.catStatusInjured),
                      selected: _selectedFilterStatus == CatStatus.injured,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilterStatus =
                              selected ? CatStatus.injured : null;
                        });
                      },
                    ),
                    // Чип "Здоров"
                    ChoiceChip(
                      label: Text(l10n.catStatusHealthy),
                      selected: _selectedFilterStatus == CatStatus.healthy,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilterStatus =
                              selected ? CatStatus.healthy : null;
                        });
                      },
                    ),
                    const SizedBox(width: 8),

                    // Чип "Нужен корм"
                    ChoiceChip(
                      label: Text(l10n.catStatusNeedsFood),
                      selected: _selectedFilterStatus == CatStatus.needsFood,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilterStatus =
                              selected ? CatStatus.needsFood : null;
                        });
                      },
                    ),
                    const SizedBox(width: 8),

                    // Чип "Потеряшка"
                    ChoiceChip(
                      label: Text(l10n.catStatusLostPet),
                      selected: _selectedFilterStatus == CatStatus.lostPet,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilterStatus =
                              selected ? CatStatus.lostPet : null;
                        });
                      },
                    ),
                    const SizedBox(width: 8),

                   
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Кнопка GPS
      floatingActionButton: FloatingActionButton(
        heroTag: 'btnLocation',
        onPressed: _getCurrentLocation,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        child: const Icon(Icons.my_location_rounded),
      ),
    );
  }
}