import 'package:newapplea/onboardingFirstScreen.dart';

import '../analises.dart';
import '../grupoPesquisa.dart';
import '../links.dart';
import '../materiaisDidaticos.dart';
import '../menu.dart';
import '../almoxarifado.dart';
import '../metodologias.dart';
import '../singleton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

indexPage meuIndexPage = indexPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isFirstTime ? OnboardingScreen() : MainPage(),

      //home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pages = [
    Analises(),
    Metodologias(),
    GrupoPesquisa(),
    MateriaisDidaticos(),
    Almoxarifado(),
    Links(),
    MenuPage(),
  ];

  void changePage(int index) {
    setState(() {
      meuIndexPage.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color.fromARGB(127, 205, 248, 255),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
          ),
          child: Container(
            height: 60, // Set the height of the image
            width: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/logo_lea.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
      body: _pages[meuIndexPage.currentIndex],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                changePage(6);
                naoEscolheuAlmoxarifado = true;
                isMaterial = false;
                isReagente = false;
                isControle = false;
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => changePage(5),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => changePage(3),
            ),
          ],
        ),
      ),
    );
  }
}
