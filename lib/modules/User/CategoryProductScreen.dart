import 'package:flutter/material.dart';
import 'package:grocery/shared/components/CategoryProduct.dart';

import '../../shared/styles/colors.dart';

class CategoryProductScreen extends StatefulWidget {
  CategoryProductScreen({super.key});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  // List<CategoryProduct> products = [
  //   CategoryProduct(
  //       onpress: () {},
  //       image: 'assets/images/cheetos.jpg',
  //       desc: 'Radhuni Shemai - 200 gm - 4-2-15-VD-SQ',
  //       newPrice: 150),
  //   CategoryProduct(
  //       onpress: () {},
  //       image: 'assets/images/cheetos.jpg',
  //       desc: 'Radhuni Shemai - 200 gm - 4-2-15-VD-SQ ',
  //       newPrice: 150),
  //   CategoryProduct(
  //       onpress: () {},
  //       image: 'assets/images/cheetos.jpg',
  //       desc: 'Radhuni Shemai - 200 gm - 4-2-15-VD-SQ ',
  //       newPrice: 150),
  //   CategoryProduct(
  //       onpress: () {},
  //       image: 'assets/images/cheetos.jpg',
  //       desc: 'Radhuni Shemai - 200 gm - 4-2-15-VD-SQ',
  //       newPrice: 150),
  //   CategoryProduct(
  //       onpress: () {},
  //       image: 'assets/images/cheetos.jpg',
  //       desc: 'Radhuni Shemai - 200 gm - 4-2-15-VD-SQ ',
  //       newPrice: 150),
  //   CategoryProduct(
  //       onpress: () {},
  //       image: 'assets/images/cheetos.jpg',
  //       desc: 'Radhuni Shemai - 200 gm - 4-2-15-VD-SQ ',
  //       newPrice: 150),
  //   CategoryProduct(
  //       onpress: () {},
  //       image: 'assets/images/cheetos.jpg',
  //       desc: 'Radhuni Shemai - 200 gm - 4-2-15-VD-SQ ',
  //       newPrice: 150),
  //   CategoryProduct(
  //       onpress: () {},
  //       image: 'assets/images/cheetos.jpg',
  //       desc: 'Radhuni Shemai - 200 gm - 4-2-15-VD-SQ ',
  //       newPrice: 150),
  //   CategoryProduct(
  //       onpress: () {},
  //       image: 'assets/images/cheetos.jpg',
  //       desc: 'Radhuni Shemai - 200 gm - 4-2-15-VD-SQ ',
  //       newPrice: 150),
  //   CategoryProduct(
  //       onpress: () {},
  //       image: 'assets/images/cheetos.jpg',
  //       desc: 'Radhuni Shemai - 200 gm - 4-2-15-VD-SQ ',
  //       newPrice: 150),
  // ];

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    print(arg);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Snacks'),
          backgroundColor: primaryColor.withOpacity(0.15),
        ),
        body: GridView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context)
                    .size
                    .height), // Adjust the ratio as needed
          ),
          itemBuilder: (BuildContext context, int index) {
            return CategoryProduct(
              image: arg[index].image,
              desc: arg[index].desc,
              newPrice: arg[index].newPrice,
              onpress: () {
                Navigator.pushNamed(context, 'CardScreen', arguments: {
                  'product': arg[index],
                });
              },
            );
          },
          itemCount: arg.length,
        ),
      ),
    );
  }
}
