import 'package:flutter/material.dart';
import '../models/facility.dart';
import '../services/facility_service.dart';
import '../widgets/facility_card.dart';
import 'detail_page.dart';

class FacilitiesPage extends StatefulWidget {
  static const routeName = '/facilities';
  const FacilitiesPage({super.key});
  @override
  State<FacilitiesPage> createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  final _service = FacilityService();
  late Future<List<Facility>> _future;
  String _query = '';
  @override
  void initState() { super.initState(); _future = _service.getFacilities(); }
  void _retry() => setState(() => _future = _service.getFacilities());

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Fasilitas Kampus')),
    body: Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(20, 4, 20, 14), child: TextField(onChanged: (value) => setState(() => _query = value), decoration: InputDecoration(hintText: 'Cari fasilitas kampus...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)))),
      Expanded(child: FutureBuilder<List<Facility>>(future: _future, builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError) return _error(snapshot.error.toString());
        final list = (snapshot.data ?? []).where((item) => '${item.name} ${item.category} ${item.location}'.toLowerCase().contains(_query.toLowerCase())).toList();
        if (list.isEmpty) return const Center(child: Text('Fasilitas tidak ditemukan.'));
        return ListView.builder(padding: const EdgeInsets.fromLTRB(20, 0, 20, 24), itemCount: list.length, itemBuilder: (context, index) {
          final item = list[index];
          return FacilityCard(facility: item, onTap: () => Navigator.pushNamed(context, DetailPage.routeName, arguments: DetailArguments(facility: item)));
        });
      })),
    ]),
  );

  Widget _error(String message) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.error_outline, color: Colors.red, size: 38), const Text('Gagal memuat data fasilitas'), Text(message, textAlign: TextAlign.center), TextButton(onPressed: _retry, child: const Text('Coba lagi'))]));
}
