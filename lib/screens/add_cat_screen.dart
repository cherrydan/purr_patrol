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
                  prefixIcon: const Icon(Icons.description_rounded),
                ),
              // keyboardType: const TextInputType.numberWithOptions(decimal: true), 
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
                  prefixIcon: const Icon(Icons.description_rounded),
                ),
                //keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                 status: CatStatus.healthy, riskLevel: RiskLevel.safe, 
                 gender: CatGender.male, isChipped: isChipped, isSterilized: isSterilized,
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
