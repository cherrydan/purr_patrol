import 'package:flutter/material.dart';
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
  bool isChipped = false;
  bool isSterilized = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
                 CatMarker newCat = CatMarker(id: DateTime.now().millisecondsSinceEpoch.toString(), 
                 latitude: widget.latitude, longitude: widget.longitude, 
                 title: _titleController.text, description: _descriptionController.text, 
                 status: CatStatus.healthy, riskLevel: RiskLevel.safe, 
                 gender: CatGender.male, isChipped: isChipped, isSterilized: isSterilized,
                 authorId: 'current_user', createdAt: DateTime.now()); // Собрали CatMarker

                 await CatService().addCatMarker(newCat); // сохранили в Firestore

                 
                 if (!context.mounted) return;
                  Navigator.pop(context); 
          
              })
            ],
          ),
        ),
      ),
    );
  }
}
