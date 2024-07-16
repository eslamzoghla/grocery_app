import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery/modules/User/CardScreen.dart';
import 'package:grocery/modules/User/CategoryScreen.dart';
import 'package:grocery/modules/User/HomeScreen.dart';
import 'package:grocery/modules/User/more_screen.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../shared/styles/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selected = 0;
  // PageController controller = PageController();
  Map pages = {
    0: HomeScreen(),
    1: CategoryScreen(),
    2: CardScreen(),
    3: MoreScreen()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: white, systemNavigationBarColor: white),
      ),

      extendBody: true, //to make floating action button notch transparent
      body: pages[selected],
      bottomNavigationBar: StylishBottomBar(
        option: BubbleBarOptions(
          barStyle: BubbleBarStyle.horizotnal,
          bubbleFillStyle: BubbleFillStyle.fill,
          opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home_filled),
            title: const Text('Home'),
            backgroundColor: primaryColor,
            selectedIcon: const Icon(Icons.home_filled),
          ),
          BottomBarItem(
            icon: const Icon(Icons.category_outlined),
            title: const Text('Category '),
            backgroundColor: primaryColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.shopify_outlined),
            title: const Text('Card'),
            backgroundColor: primaryColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.menu_outlined),
            title: const Text('Menu'),
            backgroundColor: primaryColor,
          ),
        ],
        hasNotch: true,
        currentIndex: selected,
        onTap: (index) {
          selected = index;
          setState(() {});
        },
      ),
    );
  }
}
