import 'package:flutter/material.dart';
import 'package:grocery/models/history_order.dart';
import 'package:grocery/shared/components/custom_card.dart';
import 'package:grocery/shared/styles/colors.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  List<HistoryOrder> order = [
    HistoryOrder(
      name: 'Order #345',
      state: 'Delivered',
      date: 'October 20,2015',
      price: 700,
    ),
    HistoryOrder(
      name: 'Order #345',
      state: 'Cancelled',
      date: 'October 14,2016',
      price: 452,
    ),
    HistoryOrder(
      name: 'Order #345',
      state: 'Delivered',
      date: 'July 26,2017',
      price: 281,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: const Text(
            'Orders',
            style: TextStyle(
              color: semiBlack,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: semiBlack,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Ongoing',
              ),
              Tab(
                text: 'History',
              )
            ],
            indicatorColor: green,
            labelColor: green,
            unselectedLabelColor: semiBlack,
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Image(
                  image: AssetImage('assets/images/no_orders.jpg'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'There is n ongoing order right now.\n You can order from home',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: order.length,
              itemBuilder: (context, index) => CustomCard(order: order[index]),
            )
          ],
        ),
      ),
    );
  }
}
