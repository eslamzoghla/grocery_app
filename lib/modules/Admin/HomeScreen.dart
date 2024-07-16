import 'package:flutter/material.dart';
import 'package:grocery/modules/Admin/SearchBar.dart';
import 'package:grocery/shared/components/components.dart';

import '../../models/helperClass.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class AdminHomeScreen extends StatefulWidget {
  AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  Map images_with_names = {};

  List products = [];
  List prod_ids = [];
  List product_img = [];

  Future readProducts() async {
    List response = await Helper.getAllProducts();
    products.addAll(response);

    for (int i = 0; i < products.length; i++) {
      prod_ids.add(products[i]['prod_id']);
      print(prod_ids);
    }

    for (int i = 0; i < prod_ids.length; i++) {
      List response2 = await Helper.fetchProductImages(prod_id: prod_ids[i]);
      if (response2.isEmpty) {
        product_img.add([]);
      } else {
        product_img.add(response2);
      }
    }

    for (int i = 0; i < products.length; i++) {
      if (product_img[i].isNotEmpty) {
        images_with_names[products[i]['prod_name']] = [
          product_img[i][0],
          products[i]['prod_old_price'],
          products[i]['prod_new_price'],
        ];
      } else {
        images_with_names[products[i]['prod_name']] = [
          null,
          products[i]['prod_old_price'],
          products[i]['prod_new_price'],
        ];
      }
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var image_data = images_with_names.entries.toList();
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          width: widthScreen,
          padding: EdgeInsets.only(
            left: widthScreen / 50,
            right: widthScreen / 50,
            bottom: widthScreen / 50.0,
          ),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                title: Text(
                  'Grocery',
                  style: TextStyle(
                    color: semiBlack,
                    fontSize: textFontSize,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: heightScreen / 15,
                padding: EdgeInsets.only(
                  left: widthScreen / 50,
                  right: widthScreen / 50,
                ),
                margin: EdgeInsets.symmetric(horizontal: widthScreen / 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: primaryColor.withOpacity(0.23),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          onTap: () => showSearch(
                              context: context,
                              delegate: AdminCustomSearchDelegate()),
                          // Navigator.pushNamed(context, 'SearchBar'),
                          onChanged: (value) {},
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.search_outlined,
                              color: primaryColor,
                            ),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: primaryColor,
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) => HomeHotItem(
              widthScreen: widthScreen,
              heightScreen: heightScreen / 1.5,
              image: image_data[index].value[0],
              imageText: image_data[index].key,
              oldPrice: image_data[index].value[1],
              newPrice: image_data[index].value[2],
              onpress: () async {
                Map data = {
                  'prod_id': prod_ids[index],
                  'prod_imgs': product_img[index],
                  'prod_name': products[index]['prod_name'],
                  'prod_amount': products[index]['prod_amount'],
                  'prod_new_price': products[index]['prod_new_price'],
                  'prod_brand': products[index]['prod_brand'],
                };

                print(data);

                Navigator.pushNamed(context, 'ProductDetailAdminScreen',
                    arguments: data);
              },
            ),
            itemCount: images_with_names.length,
          ),
        )
      ],
    );
  }
}
