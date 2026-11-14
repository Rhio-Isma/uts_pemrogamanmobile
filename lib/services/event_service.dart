import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/campus_event.dart';

class EventService {
  Future<List<CampusEvent>> getEvents() async {
    try {
      final source = await rootBundle.loadString('assets/data/events.json');
      final data = jsonDecode(source) as List<dynamic>;
      return data.map((item) => CampusEvent.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      throw Exception('Gagal membaca data agenda: $error');
    }
  }
}
