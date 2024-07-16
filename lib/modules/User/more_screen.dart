// MoreScreen.dart

import 'package:flutter/material.dart';
import 'package:grocery/cubit/grocery_cubit.dart';
import 'package:grocery/shared/styles/colors.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  int index = 3;

  @override
  Widget build(BuildContext context) {
    var cubit = GroceryCubit.get(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'More',
          style: TextStyle(
            color: semiBlack,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (cubit.imageBytes != null)
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(cubit.imageBytes!),
                      ),
                    ),
                  )
                else
                  CircleAvatar(radius: 87, backgroundColor: Colors.green),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.fullName.text,
                      style: TextStyle(
                        color: semiBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      cubit.phone.text,
                      style: TextStyle(
                        color: semiBlack,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 67,
            child: ListTile(
              leading: Icon(Icons.edit_outlined),
              title: Text('Edit Profile'),
              shape: UnderlineInputBorder(),
              onTap: () {
                Navigator.pushNamed(context, 'EditProfile');
              },
            ),
          ),
          SizedBox(
            height: 67,
            child: ListTile(
              leading: Icon(Icons.place_outlined),
              title: Text('My Address'),
              shape: UnderlineInputBorder(),
              onTap: () => Navigator.pushNamed(context, 'AddressesScreen'),
            ),
          ),
          SizedBox(
            height: 67,
            child: ListTile(
              leading: Icon(Icons.shopping_basket_outlined),
              title: Text('My Orders'),
              shape: UnderlineInputBorder(),
              onTap: () => Navigator.pushNamed(context, 'OrdersScreen'),
            ),
          ),
          SizedBox(
            height: 67,
            child: ListTile(
              onTap: () => Navigator.pushNamed(context, 'AuthPage'),
              leading: Icon(
                Icons.power_settings_new_outlined,
                color: Colors.red,
              ),
              title: Text('Log out'),
              shape: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
