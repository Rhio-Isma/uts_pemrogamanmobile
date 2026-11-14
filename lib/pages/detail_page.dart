import 'package:flutter/material.dart';
import '../models/facility.dart';
import '../models/campus_event.dart';
import '../widgets/custom_button.dart';

class DetailArguments {
  final Facility? facility;
  final CampusEvent? event;
  const DetailArguments({this.facility, this.event}) : assert(facility != null || event != null);
}

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  final DetailArguments arguments;
  const DetailPage({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    final facility = arguments.facility;
    final event = arguments.event;
    final title = facility?.name ?? event!.title;
    final category = facility?.category ?? event!.category;
    final description = facility?.description ?? event!.description;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Informasi')),
      body: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 28), children: [
        Container(height: 165, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF142B4A), Color(0xFF2864D8)]), borderRadius: BorderRadius.circular(22)), child: Icon(facility != null ? Icons.apartment_rounded : Icons.event_available_rounded, color: Colors.white, size: 72)),
        const SizedBox(height: 22),
        Text(category.toUpperCase(), style: const TextStyle(color: Color(0xFF2864D8), fontWeight: FontWeight.w800, letterSpacing: 1)),
        const SizedBox(height: 7), Text(title, style: const TextStyle(color: Color(0xFF142B4A), fontSize: 25, fontWeight: FontWeight.w900)),
        const SizedBox(height: 20),
        if (facility != null) ...[
          _info(Icons.location_on_outlined, 'Lokasi', facility.location),
          _info(Icons.access_time, 'Jam Operasional', facility.operatingHours),
          _info(Icons.verified_outlined, 'Status', facility.status),
        ],
        if (event != null) ...[
          _info(Icons.location_on_outlined, 'Lokasi', event.location),
          _info(Icons.calendar_month, 'Tanggal', event.date),
          _info(Icons.schedule, 'Waktu', event.time),
          _info(Icons.groups_outlined, 'Penyelenggara', event.organizer),
          _info(Icons.info_outline, 'Status', event.status),
        ],
        const SizedBox(height: 14), const Text('Deskripsi', style: TextStyle(color: Color(0xFF142B4A), fontSize: 17, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8), Text(description, style: const TextStyle(color: Color(0xFF667386), height: 1.7)),
        const SizedBox(height: 25), CustomButton(label: 'Kembali', icon: Icons.arrow_back, onPressed: () => Navigator.pop(context)),
      ]),
    );
  }

  Widget _info(IconData icon, String label, String value) => Padding(padding: const EdgeInsets.only(bottom: 14), child: Row(children: [
    Icon(icon, color: const Color(0xFF2864D8), size: 20), const SizedBox(width: 10), SizedBox(width: 112, child: Text(label, style: const TextStyle(color: Color(0xFF8793A3), fontSize: 12))),
    Expanded(child: Text(value, style: const TextStyle(color: Color(0xFF142B4A), fontSize: 12, fontWeight: FontWeight.w700))),
  ]));
}
