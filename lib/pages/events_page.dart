import 'package:flutter/material.dart';
import '../models/campus_event.dart';
import '../services/event_service.dart';
import '../widgets/event_card.dart';
import 'detail_page.dart';

class EventsPage extends StatefulWidget {
  static const routeName = '/events';
  const EventsPage({super.key});
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final _service = EventService();
  late Future<List<CampusEvent>> _future;
  String _query = '';
  @override
  void initState() { super.initState(); _future = _service.getEvents(); }
  void _retry() => setState(() => _future = _service.getEvents());

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Event & Agenda Kampus')),
    body: Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(20, 4, 20, 14), child: TextField(onChanged: (value) => setState(() => _query = value), decoration: InputDecoration(hintText: 'Cari event atau kategori...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)))),
      Expanded(child: FutureBuilder<List<CampusEvent>>(future: _future, builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return _error(snapshot.error.toString());
        final list = (snapshot.data ?? []).where((item) => '${item.title} ${item.category} ${item.location}'.toLowerCase().contains(_query.toLowerCase())).toList();
        if (list.isEmpty) return const Center(child: Text('Event tidak ditemukan.'));
        return ListView.builder(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), itemCount: list.length, itemBuilder: (context, index) {
          final item = list[index];
          return EventCard(event: item, onTap: () => Navigator.pushNamed(context, DetailPage.routeName, arguments: DetailArguments(event: item)));
        });
      })),
    ]),
  );

  Widget _error(String message) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.error_outline, color: Colors.red, size: 38), const Text('Gagal memuat agenda'), Text(message, textAlign: TextAlign.center), TextButton(onPressed: _retry, child: const Text('Coba lagi'))]));
}
