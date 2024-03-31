import 'package:flutter/material.dart';

class Links extends StatefulWidget {
  const Links({super.key});

  @override
  State<Links> createState() => _LinksState();
}

class _LinksState extends State<Links> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'links',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ),
    );
  }
}
