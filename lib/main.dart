import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/facilities_page.dart';
import 'pages/events_page.dart';
import 'pages/detail_page.dart';

void main() => runApp(const CampusIdealApp());

class CampusIdealApp extends StatelessWidget {
  const CampusIdealApp({super.key});
  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF2864D8);
    return MaterialApp(
      title: 'Campus Ideal', debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: blue, primary: blue),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF5F7FB), foregroundColor: Color(0xFF142B4A), elevation: 0),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        FacilitiesPage.routeName: (_) => const FacilitiesPage(),
        EventsPage.routeName: (_) => const EventsPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == DetailPage.routeName) {
          final args = settings.arguments;
          if (args is DetailArguments) {
            return MaterialPageRoute<void>(builder: (_) => DetailPage(arguments: args), settings: settings);
          }
        }
        return null;
      },
    );
  }
}
