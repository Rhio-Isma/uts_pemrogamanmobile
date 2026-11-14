import 'package:flutter/material.dart';
import '../models/facility.dart';
import '../models/campus_event.dart';
import '../services/facility_service.dart';
import '../services/event_service.dart';
import '../widgets/facility_card.dart';
import '../widgets/event_card.dart';
import '../widgets/section_header.dart';
import 'facilities_page.dart';
import 'events_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _facilityService = FacilityService();
  final _eventService = EventService();
  late Future<List<Facility>> _facilities;
  late Future<List<CampusEvent>> _events;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _facilities = _facilityService.getFacilities();
    _events = _eventService.getEvents();
  }

  void _retry() => setState(_loadData);

  void _openDetail({Facility? facility, CampusEvent? event}) {
    Navigator.pushNamed(context, DetailPage.routeName, arguments: DetailArguments(facility: facility, event: event));
  }

  Widget _stateView(AsyncSnapshot snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const Padding(padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator()));
    }
    if (snapshot.hasError) {
      return Column(children: [const Text('Data gagal dimuat.'), TextButton(onPressed: _retry, child: const Text('Coba lagi'))]);
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(child: RefreshIndicator(onRefresh: () async => _retry(), child: ListView(padding: const EdgeInsets.fromLTRB(20, 16, 20, 30), children: [
      Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: const Color(0xFF142B4A), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.school_rounded, color: Colors.white)),
        const SizedBox(width: 11), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Campus Ideal', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF142B4A))),
          Text('Campus information made easy', style: TextStyle(fontSize: 10, color: Color(0xFF8793A3))),
        ])),
        IconButton(onPressed: () => showAboutDialog(context: context, applicationName: 'CampusGo', applicationVersion: '1.0.0'), icon: const Icon(Icons.info_outline)),
      ]),
      const SizedBox(height: 22),
      Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF142B4A), Color(0xFF2864D8)]), borderRadius: BorderRadius.circular(22)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('YOUR CAMPUS,\nIN ONE PLACE.', style: TextStyle(color: Colors.white, fontSize: 24, height: 1.15, fontWeight: FontWeight.w900)),
        const SizedBox(height: 9), const Text('Temukan fasilitas dan kegiatan kampus dengan lebih mudah.', style: TextStyle(color: Color(0xFFDCE8FF), fontSize: 12)),
        const SizedBox(height: 16), Wrap(spacing: 9, children: [
          OutlinedButton.icon(onPressed: () => Navigator.pushNamed(context, FacilitiesPage.routeName), icon: const Icon(Icons.apartment, size: 17), label: const Text('Fasilitas'), style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white54))),
          OutlinedButton.icon(onPressed: () => Navigator.pushNamed(context, EventsPage.routeName), icon: const Icon(Icons.event, size: 17), label: const Text('Agenda'), style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: const BorderSide(color: Colors.white54))),
        ]),
      ])),
      const SizedBox(height: 25),
      const SectionHeader(title: 'Jelajahi Kampus', subtitle: 'Informasi kampus dalam satu aplikasi'),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: _shortcut('Fasilitas', 'Gedung & ruang', Icons.apartment, () => Navigator.pushNamed(context, FacilitiesPage.routeName))),
        const SizedBox(width: 12),
        Expanded(child: _shortcut('Event', 'Agenda kampus', Icons.event_note, () => Navigator.pushNamed(context, EventsPage.routeName))),
      ]),
      const SizedBox(height: 25),
      SectionHeader(title: 'Fasilitas Kampus', subtitle: 'Temukan tempat yang kamu butuhkan', actionText: 'Lihat semua', onAction: () => Navigator.pushNamed(context, FacilitiesPage.routeName)),
      const SizedBox(height: 10),
      FutureBuilder<List<Facility>>(future: _facilities, builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return _stateView(snapshot);
        if (snapshot.hasError) return _stateView(snapshot);
        final data = snapshot.data ?? [];
        if (data.isEmpty) return const Text('Belum ada data fasilitas.');
        return Column(children: data.take(2).map((item) => FacilityCard(facility: item, onTap: () => _openDetail(facility: item))).toList());
      }),
      const SizedBox(height: 15),
      SectionHeader(title: 'Agenda Kampus', subtitle: 'Jangan lewatkan kegiatan menarik', actionText: 'Lihat semua', onAction: () => Navigator.pushNamed(context, EventsPage.routeName)),
      const SizedBox(height: 10),
      FutureBuilder<List<CampusEvent>>(future: _events, builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return _stateView(snapshot);
        if (snapshot.hasError) return _stateView(snapshot);
        final data = snapshot.data ?? [];
        if (data.isEmpty) return const Text('Belum ada agenda kampus.');
        return Column(children: data.take(2).map((item) => EventCard(event: item, onTap: () => _openDetail(event: item))).toList());
      }),
    ]))),
  );

  Widget _shortcut(String title, String subtitle, IconData icon, VoidCallback action) => Material(
    color: Colors.white, borderRadius: BorderRadius.circular(16), child: InkWell(onTap: action, borderRadius: BorderRadius.circular(16), child: Padding(padding: const EdgeInsets.all(15), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: const Color(0xFF2864D8), size: 26), const SizedBox(height: 12),
      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF142B4A))),
      Text(subtitle, style: const TextStyle(fontSize: 11, color: Color(0xFF8793A3))),
    ]))),
  );
}
