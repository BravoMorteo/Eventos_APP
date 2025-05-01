import 'package:flutter/material.dart';
import '../../../data/datasources/fake_event_datasource.dart';
import '../../../data/models/event_model.dart';
import 'event_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _datasource = FakeEventDatasource();
  final TextEditingController _searchController = TextEditingController();

  late Future<List<EventModel>> _eventsFuture;
  late List<EventModel> _allEvents;
  List<EventModel> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _eventsFuture = _loadEvents();
  }

  Future<List<EventModel>> _loadEvents() async {
    final events = await _datasource.getEvents();
    _allEvents = events;
    _filteredEvents = events;
    return events;
  }

  void _filterEvents(String query) {
    final filtered = _allEvents.where((event) {
      final nameLower = event.name.toLowerCase();
      final descLower = event.description.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower) || descLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredEvents = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eventos')),
      body: FutureBuilder<List<EventModel>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar eventos'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar eventos...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onChanged: _filterEvents,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredEvents.length,
                  itemBuilder: (context, index) {
                    final event = _filteredEvents[index];
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
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
