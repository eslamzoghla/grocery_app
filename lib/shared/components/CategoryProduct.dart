import 'package:flutter/material.dart';
import 'package:grocery/shared/styles/colors.dart';

class CategoryProduct extends StatelessWidget {
  CategoryProduct({
    super.key,
    required this.image,
    required this.desc,
    required this.newPrice,
    this.oldPrice,
    required this.onpress,
  });
  String? image;
  String? desc;
  void Function() onpress;
  double? oldPrice;
  double? newPrice;

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(widthScreen / 90),
      padding: EdgeInsets.all(widthScreen / 70),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(widthScreen / 100),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.8),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.27),
                      offset: Offset(0, 10),
                      blurRadius: 50.0,
                    ),
                  ]),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(widthScreen / 50),
                child: Image.asset(
                  image!,
                  width: widthScreen / 5,
                  height: heightScreen / 6,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  left: widthScreen / 70, bottom: widthScreen / 100),
              child: Text(
                desc!,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: widthScreen / 70,
              top: heightScreen / 100,
            ),
            child: Text(
              '$newPrice LE',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.orange,
              ),
            ),
          ),
          SizedBox(height: 9.0),
          SizedBox(
            width: double.infinity, // Set the width to fill the available space
            child: ElevatedButton.icon(
              onPressed: onpress,
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Set the button color to green
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        10.0), // Adjust the corner radius as needed
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
              ),
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.white,
                size: 20,
              ), // Bag icon
              label: Padding(
                padding: EdgeInsets.all(widthScreen / 60),
                child: Text(
                  'Add To Bag',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16), // Set the text color to white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
