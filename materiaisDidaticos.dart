import 'package:flutter/material.dart';

class MateriaisDidaticos extends StatefulWidget {
  const MateriaisDidaticos({super.key});

  @override
  State<MateriaisDidaticos> createState() => _MateriaisDidaticosState();
}

class _MateriaisDidaticosState extends State<MateriaisDidaticos> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Materiais Didáticos',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ),
    );
  }
}
