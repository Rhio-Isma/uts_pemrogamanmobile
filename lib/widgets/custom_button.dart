import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const CustomButton({super.key, required this.label, required this.icon, required this.onPressed});
  @override
  Widget build(BuildContext context) => SizedBox(width: double.infinity, child: FilledButton.icon(
    onPressed: onPressed, icon: Icon(icon), label: Text(label),
    style: FilledButton.styleFrom(backgroundColor: const Color(0xFF2864D8), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))),
  ));
}
