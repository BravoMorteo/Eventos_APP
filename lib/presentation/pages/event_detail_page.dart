import 'package:flutter/material.dart';
import '../../../data/models/event_model.dart';
import '../../../data/datasources/favorite_service.dart';


class EventDetailPage extends StatefulWidget{
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  final _favoriteService = FavoriteService();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final isFav = await _favoriteService.isFavorite(widget.event.id);
    setState(() {
      _isFavorite = isFav;
    });
  }

  Future<void> _toggleFavorite() async {
    await _favoriteService.toggleFavorite(widget.event.id);
    _loadFavoriteStatus(); // Recargar estado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.event.imageUrl, width: double.infinity, height: 200, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.event.name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(widget.event.location, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Fecha: ${widget.event.date.toLocal().toString().split(' ')[0]}'),
                  const SizedBox(height: 16),
                  Text(widget.event.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
