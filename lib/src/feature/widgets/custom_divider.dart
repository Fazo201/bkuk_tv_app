import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  static const Color _gold = Color(0xFFD4A842);

  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            _gold.withValues(alpha: 0.5),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}