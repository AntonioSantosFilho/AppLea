import 'package:flutter/material.dart';

class GrupoPesquisa extends StatefulWidget {
  const GrupoPesquisa({super.key});

  @override
  State<GrupoPesquisa> createState() => _GrupoPesquisaState();
}

class _GrupoPesquisaState extends State<GrupoPesquisa> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF6F9FC),
      body: Center(
        child: Text(
          'Grupo de pesquisa',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ),
    );
  }
}
