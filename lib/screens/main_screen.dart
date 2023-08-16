import 'package:flutter/material.dart';
import 'package:storeonline/screens/bnb/bag_screen.dart';
import 'package:storeonline/screens/bnb/favourits_screen.dart';
import 'package:storeonline/screens/bnb/home_page_screen.dart';
import 'package:storeonline/screens/bnb/person_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
int selectedIndex = 0;
class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: [
        HomePageScreen(),
        BagScreen(),
        FavouritsScreen(),
        PersonScreen(),
      ][selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (_) => setState(() => selectedIndex = _),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
