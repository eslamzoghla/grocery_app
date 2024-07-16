import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/layout/AdminMainPage.dart';
import 'package:grocery/modules/Admin/ProductDetailsScreen.dart';
import 'package:grocery/modules/Admin/add_item.dart';
import 'package:grocery/modules/Admin/categories.dart';
import 'package:grocery/modules/Admin/edit_profile.dart';
import 'package:grocery/modules/Admin/item_category.dart';
import 'package:grocery/modules/Admin/more_screen.dart';
import 'package:grocery/modules/Admin/save_screen.dart';
import 'package:grocery/modules/User/AddressesScreen.dart';
import 'package:grocery/modules/User/Auth_Page.dart';
import 'package:grocery/modules/User/CardScreen.dart';
import 'package:grocery/modules/User/CategoryProductScreen.dart';
import 'package:grocery/modules/User/CategoryScreen.dart';
import 'package:grocery/modules/User/HomeScreen.dart';
import 'package:grocery/modules/User/Login_Screen.dart';
import 'package:grocery/modules/User/ProductDetailsScreen.dart';
import 'package:grocery/modules/User/Splash_Screen.dart';
import 'package:grocery/modules/User/edit_profile.dart';
import 'package:grocery/modules/User/more_screen.dart';
import 'package:grocery/modules/User/onboarding_screen.dart';
import 'package:grocery/modules/User/orders_screen.dart';
import 'package:grocery/modules/User/register.dart';
import 'package:grocery/test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'cubit/grocery_cubit.dart';
import 'layout/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
late SharedPreferences prefs;

void main() async {
  // Initialize FFI
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  // the app doesn't start before taking instance from shared preference
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  // initScreen == Null or 0 => [ Splash-> Onboarding -> Auth ]
  // initScreen == 1 => [ Splash-> Auth ]
  initScreen = prefs.getInt("initScreen");

  runApp(MyApp());
}

//statless and statefull

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroceryCubit(),
      child: MaterialApp(
        title: 'Grocery',
        debugShowCheckedModeBanner: false,
        initialRoute: 'SplashScreen',
        // initialRoute: 'AdminMainPage',
        // initialRoute: 'Test',
        routes: {
          'Test': (context) => Test(),
          'SplashScreen': (context) => SplashScreen(),
          'OnBoarding': (context) => OnBoarding(),
          'AuthPage': (context) => AuthPage(),

          // Admin
          'AddItem': (context) => AddItem(),
          'SaveScreen': (context) => SaveScreen(),
          'ItemCategory': (context) => ItemCategory(),
          'AdminMainPage': (context) => AdminMainPage(),
          'AddNewCategory': (context) => AdminCategory(),
          'AdminMoreScreen': (context) => AdminMoreScreen(),
          'AdminEditProfile': (context) => AdminEditProfile(),
          'ProductDetailAdminScreen': (context) => ProductDetailAdminScreen(),

          // User
          'Register': (context) => Register(),
          'MainPage': (context) => MainPage(),
          'LoginPage': (context) => LoginPage(),
          'SearchBar': (context) => SearchBar(),
          'MoreScreen': (context) => MoreScreen(),
          'HomeScreen': (context) => HomeScreen(),
          'CardScreen': (context) => CardScreen(),
          'EditProfile': (context) => EditProfile(),
          'OrdersScreen': (context) => OrdersScreen(),
          'CatgoryScreen': (context) => CategoryScreen(),
          'AddressesScreen': (context) => AddressesScreen(),
          'ProductDetailScreen': (context) => ProductDetailScreen(),
          'CategoryProductScreen': (context) => CategoryProductScreen(),
        },
      ),
    );
  }
}
