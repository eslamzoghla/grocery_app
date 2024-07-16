import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery/modules/Admin/HomeScreen.dart';
import 'package:grocery/modules/Admin/add_item.dart';
import 'package:grocery/modules/Admin/categories.dart';
import 'package:grocery/modules/Admin/more_screen.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../shared/styles/colors.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int selected = 0;
  // PageController controller = PageController();
  Map pages = {
    0: AdminHomeScreen(),
    1: AdminCategory(),
    2: AdminMoreScreen(),
    3: AddItem(),
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
            title: const Text('Category'),
            backgroundColor: primaryColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.menu_outlined),
            title: const Text('Menu'),
            backgroundColor: primaryColor,
          ),
          BottomBarItem(
            icon: const Icon(Icons.add_box_outlined),
            title: const Text('Add Item'),
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
