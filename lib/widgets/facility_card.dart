import 'package:flutter/material.dart';
import '../models/facility.dart';

class FacilityCard extends StatelessWidget {
  final Facility facility;
  final VoidCallback onTap;
  const FacilityCard({super.key, required this.facility, required this.onTap});
  IconData get icon {
    switch (facility.iconName) {
      case 'library': return Icons.local_library_rounded;
      case 'computer': return Icons.computer_rounded;
      case 'science': return Icons.science_rounded;
      case 'sports': return Icons.sports_basketball_rounded;
      case 'restaurant': return Icons.restaurant_rounded;
      default: return Icons.apartment_rounded;
    }
  }
  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white, elevation: 0, margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
    child: InkWell(borderRadius: BorderRadius.circular(17), onTap: onTap, child: Padding(padding: const EdgeInsets.all(14), child: Row(children: [
      Container(width: 54, height: 54, decoration: BoxDecoration(color: const Color(0xFFEAF1FF), borderRadius: BorderRadius.circular(15)), child: Icon(icon, color: const Color(0xFF2864D8), size: 28)),
      const SizedBox(width: 13), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(facility.name, style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF142B4A))),
        Text(facility.category, style: const TextStyle(color: Color(0xFF2864D8), fontSize: 11, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4), Text(facility.location, style: const TextStyle(color: Color(0xFF8793A3), fontSize: 11)),
      ])), const Icon(Icons.chevron_right, color: Color(0xFF9AA5B3)),
    ]))),
  );
}
