import 'package:flutter/material.dart';
import '../../../data/models/event_model.dart';
import '../../../data/datasources/fake_event_datasource.dart';
import '../../../data/datasources/favorite_service.dart';
import 'event_detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _datasource = FakeEventDatasource();
  final _favoriteService = FavoriteService();

  late Future<List<EventModel>> _favoriteEventsFuture;

  @override
  void initState() {
    super.initState();
    _favoriteEventsFuture = _loadFavoriteEvents();
  }

  Future<List<EventModel>> _loadFavoriteEvents() async {
    final allEvents = await _datasource.getEvents();
    final favoriteIds = await _favoriteService.getFavoriteIds();
    return allEvents.where((event) => favoriteIds.contains(event.id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eventos Favoritos')),
      body: FutureBuilder<List<EventModel>>(
        future: _favoriteEventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data ?? [];

          if (events.isEmpty) {
            return const Center(child: Text('No tienes eventos favoritos'));
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(event.imageUrl, width: 80, fit: BoxFit.cover),
                  title: Text(event.name),
                  subtitle: Text('${event.location} - ${event.date.toLocal().toString().split(' ')[0]}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventDetailPage(event: event),
                      ),
                    ).then((_) {
                      // Refrescar al volver
                      setState(() {
                        _favoriteEventsFuture = _loadFavoriteEvents();
                      });
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
