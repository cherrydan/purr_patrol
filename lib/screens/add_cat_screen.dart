import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purr_patrol/models/cat_enums.dart';
import 'package:purr_patrol/models/cat_marker.dart';
import 'package:purr_patrol/services/cat_service.dart';
import '../l10n/app_localizations.dart';

class AddCatScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const AddCatScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<AddCatScreen> createState() => _AddCatScreenState();
}

class _AddCatScreenState extends State<AddCatScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  bool isChipped = false;
  bool isSterilized = false;

  CatGender _selectedGender = CatGender.unknown; // По умолчанию 'Неизвестно'
  CatStatus _selectedStatus = CatStatus.healthy; // По умолчанию 'Здоров'
  RiskLevel _selectedRiskLevel = RiskLevel.safe; // По умолчанию 'Безопасно'
   

   


  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addCatTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Текстовое поле Названия
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: l10n.catTitleInput,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.pets_rounded),
                ),
              ),
              const SizedBox(height: 16),

              // Текстовое поле Описания
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: l10n.catDescriptionInput,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.description_rounded),
                ),
              ),
              const SizedBox(height: 16),

              // Текстовое поле Широта
              TextFormField(controller: _latitudeController,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: l10n.catLatCoord,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.language_rounded),
                ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true), 
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*[.,]?\d*')),
                ],

                // Валидация 
                validator: (value) {
                if (value == null || value.isEmpty) {
                 return l10n.enterPrompt;
                }
    
                // Заменяем запятую на точку для корректного парсинга в Dart
                final normalizedValue = value.replaceAll(',', '.');
                final parsedValue = double.tryParse(normalizedValue);
    
                if (parsedValue == null) {
                return l10n.valueError;
                }

                 // Проверка диапазона широты
                if (parsedValue < -90.0 || parsedValue > 90.0) {

                  return l10n.latRangeError;
                }

                return null; // Ошибок нет
                }, // Конец валидации              
              
              ),
              // Текстовое поле Долгота
              TextFormField(controller: _longitudeController,
              maxLines: 1, decoration: InputDecoration(
                  labelText: l10n.catLongCoord,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.language_rounded),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d*[.,]?\d*')),
                ],
                 // Валидация 
                validator: (value) {
                if (value == null || value.isEmpty) {
                 return l10n.enterPrompt;
                }
    
                // Заменяем запятую на точку для корректного парсинга в Dart
                final normalizedValue = value.replaceAll(',', '.');
                final parsedValue = double.tryParse(normalizedValue);
    
                if (parsedValue == null) {
                return l10n.valueError;
                }

                 if (parsedValue < -180.0 || parsedValue > 180.0) {
                  return l10n.longRangeError;
                }
                return null; // Ошибок нет
                }, // Конец валидации   
              ),

              Text(l10n.genderLabel, style: const TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 8),
              // ChoiceChip для выбора пола кота
              Wrap(spacing: 8,children: [
                ChoiceChip(
                label: Text(l10n.genderMale),
                selected: _selectedGender == CatGender.male, // Подсвечен, если выбран
                onSelected: (bool selected) {
                if (selected) {
                setState(() {
                _selectedGender = CatGender.male; // Обновляем состояние
                });
              }
            },
            selectedColor: Colors.blue.shade100, // Красивый цвет при выборе
            ),
            ChoiceChip(
                label: Text(l10n.genderFemale),
                selected: _selectedGender == CatGender.female, // Подсвечен, если выбран
                onSelected: (bool selected) {
                if (selected) {
                setState(() {
                _selectedGender = CatGender.female; // Обновляем состояние
                });
              }
            },
            selectedColor: Colors.pink.shade100, // Красивый цвет при выборе
            ),
            ChoiceChip(
                label: Text(l10n.genderUnknown),
                selected: _selectedGender == CatGender.unknown, // Подсвечен, если выбран
                onSelected: (bool selected) {
                if (selected) {
                setState(() {
                _selectedGender = CatGender.unknown; // Обновляем состояние
                });
              }
            },
            selectedColor: Colors.grey.shade100, // Красивый цвет при выборе
            )
          ]),
          // выпадающий список для выбора статуса кота
          Text(
                l10n.catStatusLabel, // "Статус котика:"
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          const SizedBox(height: 8),
      
          DropdownButtonFormField<CatStatus>(
          initialValue: _selectedStatus,
            decoration: InputDecoration(
              labelText: l10n.catStatusLabel, // Например: "Статус котика"
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.info_outline_rounded),
            ),
            items: [
              DropdownMenuItem(
                value: CatStatus.healthy,
                child: Text(l10n.catStatusHealthy), // "Здоров 🟢"
              ),
              DropdownMenuItem(
                value: CatStatus.needsFood,
                child: Text(l10n.catStatusNeedsFood), // "Нужен корм 🍲"
              ),
              DropdownMenuItem(
                value: CatStatus.injured,
                child: Text(l10n.catStatusInjured), // "Травмирован 🩹"
              ),
              DropdownMenuItem(
                value: CatStatus.lostPet,
                child: Text(l10n.catStatusLostPet), // "Потеряшка 🔍"
              ),
            ],
            onChanged: (CatStatus? newStatus) {
              if (newStatus != null) {
                setState(() {
                  _selectedStatus = newStatus;
                });
              }
            },
          ),
          
          Text(l10n.riskLabel,  style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          const SizedBox(height: 8),
          
          DropdownButtonFormField<RiskLevel>(
          initialValue: _selectedRiskLevel,
            decoration: InputDecoration(
              labelText: l10n.riskLabel, // Например: "Уровень риска"
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.info_outline_rounded),
            ),
            items: [
              DropdownMenuItem(
                value: RiskLevel.safe,
                child: Text(l10n.riskSafe), // "Безопасно 🟢"
              ),
              DropdownMenuItem(
                value: RiskLevel.dogsNearby,
                child: Text(l10n.riskDogsNearby), // "Псы рядом 🐕"
              ),
              
              DropdownMenuItem(
                value: RiskLevel.urgentDanger,
                child: Text(l10n.riskUrgentDanger), // "Срочный риск 🔴"
              ),
            ],
            onChanged: (RiskLevel? newLevel) {
              if (newLevel != null) {
                setState(() {
                  _selectedRiskLevel = newLevel;
                });
              }
            },
          ),
      
              // Чекбокс для Чипированного
              SwitchListTile(
                title: Text(l10n.microchipped),
                value: isChipped,
                onChanged: (value) {
                  setState(() {
                    isChipped = value;
                  });
                },
              ),
              // Чекбокс для Стерилизованного
              SwitchListTile(
                title: Text(l10n.sterilized),
                value: isSterilized,
                onChanged: (value) {
                  setState(() {
                    isSterilized = value;
                  });
                },
              ),
              
              ElevatedButton(
                child: Text(l10n.saveCatButton),
                onPressed: () async {
                 if (_formKey.currentState!.validate()) { 
                 CatMarker newCat = CatMarker(id: DateTime.now().millisecondsSinceEpoch.toString(), 
                 latitude: double.parse(_latitudeController.text.replaceAll(',', '.')), 
                 longitude: double.parse(_longitudeController.text.replaceAll(',', '.')), 
                 title: _titleController.text, description: _descriptionController.text, 
                 status: _selectedStatus, riskLevel: _selectedRiskLevel, 
                 gender: _selectedGender, isChipped: isChipped, isSterilized: isSterilized,
                 authorId: 'current_user', createdAt: DateTime.now()); // Собрали CatMarker

                 await CatService().addCatMarker(newCat); // сохранили в Firestore

                 
                 if (!context.mounted) return;
                  Navigator.pop(context); 
                 }
          
              })
            ],
          ),
        ),
      ),
    );
  }
}
