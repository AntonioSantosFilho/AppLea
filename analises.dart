import 'package:flutter/material.dart';

class Analises extends StatefulWidget {
  const Analises({super.key});

  @override
  State<Analises> createState() => _AnalisesState();
}

class _AnalisesState extends State<Analises> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Analises em Andamento',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ),
    );
  }
}
