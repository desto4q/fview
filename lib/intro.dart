import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fview/screens/genereScreen.dart';
import 'package:fview/screens/homepage.dart';
import 'package:fview/screens/searchscreen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  void _onTabChange(int index) {
    // Handle the tab change based on the index
    setState(() {
      _selected_index = index;
    });
  }

  int _selected_index = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    // VideoPage(),
    SearchPage(),
    GenreList(),
    const Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.red,
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [Text("home"), Text("home"), Text("home")],
        ),
      ),
      body: IndexedStack(
        index: _selected_index,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(10),
        child: GNav(
            gap: 2,
            backgroundColor: Colors.black,
            color: Colors.grey.shade200,
            activeColor: Colors.green.shade500,
            padding: const EdgeInsets.all(10),
            tabBackgroundColor: CupertinoColors.darkBackgroundGray,
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: "home",
              ),
              GButton(
                icon: Icons.search_rounded,
                text: "search",
              ),
              GButton(icon: Icons.stacked_bar_chart_rounded, text: "genres"),
              GButton(
                icon: Icons.favorite_rounded,
                text: "favorite",
              ),
            ],
            selectedIndex: _selected_index,
            onTabChange: _onTabChange),
      ),
    );
  }
}
