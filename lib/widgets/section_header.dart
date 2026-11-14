import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title, subtitle;
  final String? actionText;
  final VoidCallback? onAction;
  const SectionHeader({super.key, required this.title, this.subtitle = '', this.actionText, this.onAction});
  @override
  Widget build(BuildContext context) => Row(children: [
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Color(0xFF142B4A), fontSize: 18, fontWeight: FontWeight.w800)),
      if (subtitle.isNotEmpty) Text(subtitle, style: const TextStyle(color: Color(0xFF8793A3), fontSize: 12)),
    ])),
    if (actionText != null) TextButton(onPressed: onAction, child: Text(actionText!)),
  ]);
}
