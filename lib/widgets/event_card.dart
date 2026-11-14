import 'package:flutter/material.dart';
import '../models/campus_event.dart';

class EventCard extends StatelessWidget {
  final CampusEvent event;
  final VoidCallback onTap;
  const EventCard({super.key, required this.event, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
    child: InkWell(borderRadius: BorderRadius.circular(17), onTap: onTap, child: Padding(padding: const EdgeInsets.all(14), child: Row(children: [
      Container(width: 54, height: 60, decoration: BoxDecoration(color: const Color(0xFFEAF1FF), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.event_available_rounded, color: Color(0xFF2864D8), size: 27)),
      const SizedBox(width: 13), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(event.category.toUpperCase(), style: const TextStyle(color: Color(0xFF2864D8), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: .5)),
        const SizedBox(height: 4), Text(event.title, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF142B4A))),
        const SizedBox(height: 4), Text('${event.date} • ${event.time}', style: const TextStyle(color: Color(0xFF8793A3), fontSize: 11)),
      ])), const Icon(Icons.chevron_right, color: Color(0xFF9AA5B3)),
    ]))),
  );
}
