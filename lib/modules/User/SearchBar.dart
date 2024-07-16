// import 'package:flutter/material.dart';
// import 'package:grocery/shared/styles/colors.dart';

// class CustomSearchDelegate extends SearchDelegate<String> {
//   List<Map<String, dynamic>> results2 = [];
//   List<String> suggestions = [
//     'Apple',
//     'app',
//     'Banana',
//     'Cherry',
//     'Cherry',
//     'Cherry',
//     'Cherry',
//     'Cherry',
//     'Cherry',
//     'Cherry',
//     'Cherry',
//     'Cherry',
//     'Cherry',
//   ]; // to test suggestions (without typing any string)

//   final List<Map<String, dynamic>> products = [
//     {
//       'Name': 'Apple',
//       'image': 'assets/images/fruit.png',
//       'description': 'Fresh Apple',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'app',
//       'image': 'assets/images/fruit.png',
//       'description': 'app',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'Banana',
//       'image': 'assets/images/fruit.png',
//       'description': 'tomato',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'Cherry',
//       'image': 'assets/images/fruit.png',
//       'description': 'Cherry',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'Apple',
//       'image': 'assets/images/fruit.png',
//       'description': 'Fresh Apple',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'Apple',
//       'image': 'assets/images/fruit.png',
//       'description': 'Fresh Apple',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'Apple',
//       'image': 'assets/images/fruit.png',
//       'description': 'Fresh Apple',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'Apple',
//       'image': 'assets/images/fruit.png',
//       'description': 'Fresh Apple',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'Apple',
//       'image': 'assets/images/fruit.png',
//       'description': 'Fresh Apple',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'Apple',
//       'image': 'assets/images/fruit.png',
//       'description': 'Fresh Apple',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'Apple',
//       'image': 'assets/images/fruit.png',
//       'description': 'Fresh Apple',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },
//     {
//       'Name': 'Apple',
//       'image': 'assets/images/fruit.png',
//       'description': 'Fresh Apple',
//       'oldPrice': 5.99,
//       'newPrice': 4.99,
//     },

//     // Add more products as needed
//   ]; //to test search result (when typing a string)

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           results2 = [];
//           buildResults(context);
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     if (query == "") {
//       return buildSuggestions(context);

//       //return Container();
//     }
//     double widthScreen = MediaQuery.of(context).size.width;
//     double heightScreen = MediaQuery.of(context).size.height;

//     results2 = products
//         .where((product) =>
//             product['Name'].toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     if (results2.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/searchnotfound.jpg',
//               width: widthScreen / 2, // Adjust the width as needed
//               height: heightScreen / 2, // Adjust the height as needed
//             ),
//             SizedBox(height: 16), // Add some space between the image and text
//             Text(
//               'opps! we can\'t find your product!\n    But you can add it to wishlist',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       itemCount: results2.length,
//       itemBuilder: (context, index) {
//         return Column(
//           children: [
//             buildProductItem(
//                 results2[index], widthScreen, heightScreen, context),
//             Divider(
//               color: Colors.black,
//               thickness: 1,
//               indent: 16, // Adjust the indent as needed
//               endIndent: 16, // Adjust the end indent as needed
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget buildProductItem(Map<String, dynamic> product, double width,
//       double height, BuildContext context) {
//     return ListTile(
//       leading: Image.asset(
//         product['image'],
//         width: width / 4,
//         height: height / 2,
//         fit: BoxFit.fill,
//       ),
//       title: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(product['description']),
//                 Text(
//                   '\$${product['oldPrice']}',
//                   style: TextStyle(
//                     color: oldPriceColor,
//                     decoration: TextDecoration.lineThrough,
//                   ),
//                 ),
//                 Stack(
//                   children: [
//                     Text(
//                       '\$${product['newPrice']}',
//                       style: TextStyle(color: newPriceColor),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(width: 8), // Add spacing between text and button
//           ElevatedButton.icon(
//             onPressed: () => Navigator.pushNamed(context, 'CardScreen'),
//             icon: Icon(Icons.shopping_bag, color: Colors.white),
//             label: Text('Add', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(
//               primary: primaryColor, // Button background color
//             ),
//           ),
//         ],
//       ),
//       onTap: () {
//         // Handle item tap
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> suggestionList = suggestions
//         .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     return ListView.builder(
//       itemCount: suggestionList.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: Icon(Icons.search),
//           title: Text(suggestionList[index]),
//           onTap: () {
//             query = suggestionList[index];
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:grocery/shared/styles/colors.dart';
import 'package:grocery/models/helperClass.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  List results = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
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
    // Use the searchProducts function to get results from the database
    Helper.searchProducts(query).then((value) {
      results = value;
      showResults(context);
    });

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/searchnotfound.jpg',
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
            ),
            SizedBox(height: 16),
            Text(
              'Oops! We can\'t find your product!\nYou can add it to your wishlist.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return buildProductItem(results[index], context);
      },
    );
  }

  Widget buildProductItem(Map<String, dynamic> product, BuildContext context) {
    return ListTile(
      leading: Image.asset(
        product['image'],
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height / 2,
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
          SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, 'CardScreen'),
            icon: Icon(Icons.shopping_bag, color: Colors.white),
            label: Text('Add', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              primary: primaryColor,
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
    // You can implement suggestions here if needed
    return Container();
  }
}
