import 'package:flutter/material.dart';

import 'package:grocery/models/helperClass.dart';

class ProductDetailAdminScreen extends StatefulWidget {
  ProductDetailAdminScreen({super.key});

  @override
  _ProductDetailAdminScreenState createState() =>
      _ProductDetailAdminScreenState();
}

class _ProductDetailAdminScreenState extends State<ProductDetailAdminScreen> {
  int selectedPhotoIndex = 0;

  List<String> additionalPhotos = [
    // 'assets/images/dano.jpg',
    //'assets/images/cheetos.jpg',
    //'assets/images/fruit.png',
  ];

  /*
  List<Product> recommendedProducts = [
    Product(
      image: 'assets/images/fruit.png',
      description: 'Nestle Nido Full Cream Milk Powder Instant',
      price: '25.99 L.E',
    ),
    Product(
      image: 'assets/images/cheetos.jpg',
      description: 'Nestle Nido Full Cream Milk Powder Instant',
      price: '25.99 L.E',
    ),
    // Add more recommended products as needed
  ];
  */

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    //Get data from the previous page
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    final List additionalPhotos = arg['prod_imgs'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Product Details'),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: .5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      if (additionalPhotos.isNotEmpty)
                        ClipRRect(
                          child: Image.memory(
                            additionalPhotos[selectedPhotoIndex],
                            width: 300,
                            height: 300,
                          ),
                        )
                      else
                        CircleAvatar(radius: 87, backgroundColor: Colors.green),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: additionalPhotos.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedPhotoIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: .5),
                              borderRadius: BorderRadius.circular(12.0),
                              color: selectedPhotoIndex == index
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.memory(
                                  additionalPhotos[index],
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  arg['prod_name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  arg['prod_amount'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  arg['prod_new_price'].toString(),
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // For product deletion
                      //Navigator.pushNamed(context, 'CardScreen');
                      print(arg['prod_id']);
                      int response =
                          await Helper.deleteProduct(prod_id: arg['prod_id']);
                      if (response > 0) {
                        Navigator.pushNamed(context, 'AdminMainPage');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Padding(
                      padding: EdgeInsets.only(
                          left: widthScreen / 5, right: widthScreen / 4),
                      child: Text(
                        'Delete product',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.sort,
                      color: Color(0xff37474F),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Text(
                      arg['prod_brand'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
