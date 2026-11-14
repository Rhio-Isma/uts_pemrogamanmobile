import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/facility.dart';

class FacilityService {
  Future<List<Facility>> getFacilities() async {
    try {
      final source = await rootBundle.loadString('assets/data/facilities.json');
      final data = jsonDecode(source) as List<dynamic>;
      return data.map((item) => Facility.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      throw Exception('Gagal membaca data fasilitas: $error');
    }
  }
}
