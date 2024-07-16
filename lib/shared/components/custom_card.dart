import 'package:flutter/material.dart';
import 'package:grocery/models/history_order.dart';
import 'package:grocery/shared/styles/colors.dart';

class CustomCard extends StatelessWidget {
  CustomCard({super.key, required this.order});

  HistoryOrder order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 44,
                width: 44,
                child: CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent,
                  child: Icon(
                    Icons.shopping_basket_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 19,
              ),
              Column(
                children: [
                  Text(
                    order.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: semiBlack,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    order.state,
                    style: TextStyle(
                      fontSize: 12,
                      color: (order.state == 'Delivered') ? green : Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    order.date,
                    style: TextStyle(
                      fontSize: 12,
                      color: semiBlack,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                '\$ ${order.price}',
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
