import 'package:flutter/material.dart';
import 'package:purr_patrol/l10n/app_localizations.dart';
import 'package:purr_patrol/models/cat_enums.dart';
import 'package:purr_patrol/models/cat_marker.dart';
import 'package:purr_patrol/services/app_logger.dart';
import 'package:purr_patrol/services/cat_service.dart';
import 'package:cached_network_image/cached_network_image.dart';


class FeedScreen extends StatelessWidget {
  final Function(CatMarker)? onCatSelected;
  

  const FeedScreen({
    this.onCatSelected,
    super.key});
  @override
  Widget build(BuildContext context) {
    
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(appBar: AppBar(title: Text(l10n.feedTab)),
    body: StreamBuilder<List<CatMarker>>(
          stream: CatService().getCatMarkersStream(), // 🟢 Подключаемся к базе
          builder: (context, snapshot) {
            // 1. Если данные еще грузятся - покажи крутилку (CircularProgressIndicator)
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Достаем список котиков из данных snapshot
            final cats = snapshot.data ?? [];

            // 3. Возвращаем список ListView.builder
            return ListView.builder(
              itemCount: cats.length,
              itemBuilder: (context, index) {
                final cat = cats[index];
                String statusText = l10n.catStatusHealthy;
                if (cat.status == CatStatus.needsFood) {
                  statusText = l10n.catStatusNeedsFood;
                } else if (cat.status == CatStatus.injured) {
                  statusText = l10n.catStatusInjured;
                } else if (cat.status == CatStatus.lostPet) {
                  statusText = l10n.catStatusLostPet;
                }
   
                return Card( 
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // 🟢 Отступы вокруг каждой карточки!
                  elevation: 2, // 🟢 Легкая объемная тень
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // 🟢 Красивые скругленные углы
                  ),
                  child: ListTile(

                  title: Text(cat.title),
                  subtitle: Text(cat.description),
                  leading: CircleAvatar(
                    backgroundImage: cat.imageUrl != null && cat.imageUrl!.isNotEmpty ? 
                    CachedNetworkImageProvider(cat.imageUrl!) : null,
                    child:Icon(Icons.pets_rounded, color: Colors.green)
                  ),
                    trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (cat.status == CatStatus.healthy
                          ? Colors.green
                          : cat.status == CatStatus.lostPet
                              ? Colors.amber
                              : Colors.red).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: cat.status == CatStatus.healthy
                            ? Colors.green
                            : cat.status == CatStatus.lostPet
                                ? Colors.amber
                                : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),

                     onTap: () {
                      logger.i("Кликнули на кота в ленте: ${cat.title}");
                      if (onCatSelected != null) {
                        onCatSelected!(cat);
                      }
                    },
   

   

                )
                );  // 🟢 Каждая карточка - это ListTile с названием и описанием котика             
              },
            );
          },
        )
        
    );
  }

}