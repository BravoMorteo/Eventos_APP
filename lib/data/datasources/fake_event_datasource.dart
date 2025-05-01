import '../models/event_model.dart';

class FakeEventDatasource {
  Future<List<EventModel>> getEvents() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simula delay de red

    return [
      EventModel(
        id: '1',
        name: 'Festival de Música',
        description: 'Un evento con bandas en vivo y comida.',
        date: DateTime.now().add(const Duration(days: 3)),
        location: 'Parque Central',
        imageUrl: 'https://picsum.photos/id/1015/600/400',
        latitude: 19.4326,
        longitude: -99.1332,
      ),
      EventModel(
        id: '2',
        name: 'Feria del Libro',
        description: 'Encuentra editoriales y autores independientes.',
        date: DateTime.now().add(const Duration(days: 7)),
        location: 'Centro Cultural',
        imageUrl: 'https://picsum.photos/id/1020/600/400',
        latitude: 19.4270,
        longitude: -99.1677,
      ),
      EventModel(
        id: '3',
        name: 'Carrera 10K',
        description: 'Participa en la carrera anual por el centro.',
        date: DateTime.now().add(const Duration(days: 14)),
        location: 'Avenida Reforma',
        imageUrl: 'https://picsum.photos/id/1025/600/400',
        latitude: 19.4300,
        longitude: -99.1400,
      ),
    ];
  }
}
