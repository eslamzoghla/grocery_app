import 'package:flutter/material.dart';
import 'package:grocery/shared/styles/colors.dart';

class AdminCustomSearchDelegate extends SearchDelegate<String> {
  List<Map<String, dynamic>> results2 = [];
  List<String> suggestions = [
    'Apple',
    'app',
    'Banana',
    'Cherry',
    'Cherry',
    'Cherry',
    'Cherry',
    'Cherry',
    'Cherry',
    'Cherry',
    'Cherry',
    'Cherry',
    'Cherry',
  ]; // to test suggestions (without typing any string)

  final List<Map<String, dynamic>> products = [
    {
      'Name': 'Apple',
      'image': 'assets/images/fruit.png',
      'description': 'Fresh Apple',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'app',
      'image': 'assets/images/fruit.png',
      'description': 'app',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'Banana',
      'image': 'assets/images/fruit.png',
      'description': 'tomato',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'Cherry',
      'image': 'assets/images/fruit.png',
      'description': 'Cherry',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'Apple',
      'image': 'assets/images/fruit.png',
      'description': 'Fresh Apple',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'Apple',
      'image': 'assets/images/fruit.png',
      'description': 'Fresh Apple',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'Apple',
      'image': 'assets/images/fruit.png',
      'description': 'Fresh Apple',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'Apple',
      'image': 'assets/images/fruit.png',
      'description': 'Fresh Apple',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'Apple',
      'image': 'assets/images/fruit.png',
      'description': 'Fresh Apple',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'Apple',
      'image': 'assets/images/fruit.png',
      'description': 'Fresh Apple',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'Apple',
      'image': 'assets/images/fruit.png',
      'description': 'Fresh Apple',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },
    {
      'Name': 'Apple',
      'image': 'assets/images/fruit.png',
      'description': 'Fresh Apple',
      'oldPrice': 5.99,
      'newPrice': 4.99,
    },

    // Add more products as needed
  ]; //to test search result (when typing a string)

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          results2 = [];
          buildResults(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == "") {
      return buildSuggestions(context);

      //return Container();
    }
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    results2 = products
        .where((product) =>
            product['Name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results2.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/searchnotfound.jpg',
              width: widthScreen / 2, // Adjust the width as needed
              height: heightScreen / 2, // Adjust the height as needed
            ),
            SizedBox(height: 16), // Add some space between the image and text
            Text(
              'opps! we can\'t find your product!\n    But you can add it to wishlist',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results2.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            buildProductItem(
                results2[index], widthScreen, heightScreen, context),
            Divider(
              color: Colors.black,
              thickness: 1,
              indent: 16, // Adjust the indent as needed
              endIndent: 16, // Adjust the end indent as needed
            ),
          ],
        );
      },
    );
  }

  Widget buildProductItem(Map<String, dynamic> product, double width,
      double height, BuildContext context) {
    return ListTile(
      leading: Image.asset(
        product['image'],
        width: width / 4,
        height: height / 2,
        fit: BoxFit.fill,
      ),
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product['description']),
                Text(
                  '\$${product['oldPrice']}',
                  style: TextStyle(
                    color: oldPriceColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Stack(
                  children: [
                    Text(
                      '\$${product['newPrice']}',
                      style: TextStyle(color: newPriceColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8), // Add spacing between text and button
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'AddItem'),
            icon: Icon(Icons.edit, color: Colors.white),
            style: ElevatedButton.styleFrom(
              primary: primaryColor, // Button background color
            ),
          ),
          SizedBox(width: 10.0),
          IconButton(
            onPressed: () {
              print('HIH');
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Please Confirm'),
                  content: const Text('Are you sure to remove the category?'),
                  actions: [
                    // The "Yes" button
                    TextButton(
                        onPressed: () {
                          // Remove the box

                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes')),
                    TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'))
                  ],
                ),
              );
            },
            icon: Icon(Icons.delete, color: Colors.white),
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // Button background color
            ),
          ),
        ],
      ),
      onTap: () {
        // Handle item tap
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = suggestions
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.search),
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
