import '/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    // Lista de caminhos para as imagens
    List<String> imagePaths = [
      'assets/images/1.png',
      'assets/images/2.png',
      'assets/images/3.png',
      'assets/images/4.png',
      'assets/images/5.png',
      'assets/images/6.png',
    ];

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: kIsWeb ? 6 : 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: imagePaths.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  child: Card(
                    color: Color(0xFF03A9F4),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: () {
                    meuIndexPage.currentIndex = index;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );

                    print("Index: " + meuIndexPage.currentIndex.toString());
                  });
            },
          ),
        ),
      ),
    );
  }
}
