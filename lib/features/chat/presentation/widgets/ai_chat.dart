import 'package:flutter/material.dart';

class AiChat extends StatelessWidget {
  final double maxHeight;

  const AiChat({super.key, required this.maxHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: maxHeight,
      color: Colors.red,
    );
  }
}