// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../shared/components/components.dart';
// import '../../shared/components/constants.dart';
// import '../../shared/styles/colors.dart';
// import '../../models/MYbag.dart';

// class CardScreen extends StatefulWidget {
//   const CardScreen({super.key});

//   @override
//   State<CardScreen> createState() => _CardScreenState();
// }

// class _CardScreenState extends State<CardScreen> {
//   var dateControler = TextEditingController();
//   var timeControler = TextEditingController();
//   var timeControler1 = TextEditingController();
//   var formkey = GlobalKey<FormState>();

//   List<Product> product = [
//     Product(
//         title: 'Aria DANO Full Cream Milk Powder instant',
//         count: 8,
//         imagePath: 'assets/images/Rectangle.png',
//         newprice: 182,
//         oldprice: 200),
//     Product(
//         title: 'Aria DANO Full Cream Milk Powder instant',
//         count: 1,
//         imagePath: 'assets/images/Rectangle.png',
//         newprice: 182,
//         oldprice: 200),
//     Product(
//         title: 'Aria DANO Full Cream Milk Powder instant',
//         count: 1,
//         imagePath: 'assets/images/Rectangle.png',
//         newprice: 182,
//         oldprice: 200),
//     Product(
//         title: 'Aria DANO Full Cream Milk Powder instant',
//         count: 1,
//         imagePath: 'assets/images/Rectangle.png',
//         newprice: 182,
//         oldprice: 200),
//     Product(
//         title: 'Aria DANO Full Cream Milk Powder instant',
//         count: 1,
//         imagePath: 'assets/images/Rectangle.png',
//         newprice: 182,
//         oldprice: 200),
//     Product(
//         title: 'Aria DANO Full Cream Milk Powder instant',
//         count: 1,
//         imagePath: 'assets/images/Rectangle.png',
//         newprice: 182,
//         oldprice: 200),
//   ];
//   // int count=1;
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;
//     final height = MediaQuery.sizeOf(context).height;

//     final Map<String, dynamic>? args =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

//     if (args != null && args.containsKey('product')) {
//       Product selectedProduct = args['product'] as Product;

//       // Use the selected product information as needed
//       print('Selected Product: ${selectedProduct}');
//     }
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "My Bag",
//             style: TextStyle(
//                 fontSize: 20, fontWeight: Semi_bold, color: semiBlack),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: SizedBox(
//             width: double.infinity,
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: height / 31,
//                   ),
//                   SizedBox(
//                     height: height / 25,
//                   ),
//                   Text(
//                     "Products",
//                     style: TextStyle(
//                         fontSize: 16, fontWeight: Medium, color: semiBlack),
//                   ),
//                   SizedBox(
//                     height: height / 35,
//                   ),
//                   SingleChildScrollView(
//                     child: SizedBox(
//                       height: height / 2,
//                       child: ListView.separated(
//                           // physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) =>
//                               BagRow(width, height, product[index]),
//                           separatorBuilder: (context, index) => Column(
//                                 children: [
//                                   SizedBox(
//                                     height: height / 40,
//                                   ),
//                                   Divider(
//                                     color: black.withOpacity(0.3),
//                                   ),
//                                   SizedBox(
//                                     height: height / 40,
//                                   ),
//                                 ],
//                               ),
//                           itemCount: product.length),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Button1(
//                       pressButton: () {
//                         print('ffdf');
//                       },
//                       text: 'Add More Product',
//                       color1: bgtn),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Text(
//                     "Expected Date & Time",
//                     style: TextStyle(fontWeight: Medium, fontSize: 16),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Form(
//                     key: formkey,
//                     child: Column(
//                       children: [
//                         itemField(
//                           suffix: Icons.arrow_circle_down,
//                           clickable: true,
//                           control: dateControler,
//                           validate: (value) {
//                             if (value.isEmpty) {
//                               return "date must not be empty";
//                             }
//                             return null;
//                           },
//                           onTappped: () {
//                             showDatePicker(
//                                     context: context,
//                                     initialDate: DateTime.now(),
//                                     firstDate: DateTime(2023),
//                                     lastDate: DateTime(2024))
//                                 .then((value) {
//                               dateControler.text =
//                                   DateFormat.yMMMd().format(value!);
//                               print(DateFormat.yMMMd().format(value));
//                             });
//                           },
//                           // keyboardType: TextInputType.datetime,
//                           label: "Select Date",
//                           hint: 'Select Date',
//                           prefix: Icons.date_range,
//                           keyboard: TextInputType.datetime,
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         itemField(
//                           clickable: true,
//                           control: timeControler,
//                           validate: (value) {
//                             if (value.isEmpty) {
//                               return "time must not be empty";
//                             }
//                             return null;
//                           },
//                           onTappped: () {
//                             showTimePicker(
//                                     context: context,
//                                     initialTime: TimeOfDay.now())
//                                 .then((value) {
//                               timeControler.text =
//                                   value!.format(context).toString();
//                               print(value.format(context));
//                             });
//                           },
//                           keyboard: TextInputType.datetime,
//                           label: "time",
//                           hint: 'time',
//                           prefix: Icons.watch_later_outlined,
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               "Delivery Location",
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: Medium,
//                                   fontSize: 16),
//                             ),
//                             Spacer(),
//                             TextButton(
//                                 onPressed: () {},
//                                 child: Text(
//                                   "Change",
//                                   style: TextStyle(
//                                       color: green,
//                                       fontSize: 16,
//                                       fontWeight: Medium),
//                                 ))
//                           ],
//                         ),
//                         SizedBox(
//                           height: 18,
//                         ),
//                         Row(
//                           children: [
//                             Spacer(
//                               flex: 1,
//                             ),
//                             CircleAvatar(
//                               backgroundColor: green,
//                               radius: 25,
//                               child: Icon(
//                                 Icons.location_on,
//                                 color: white,
//                               ),
//                             ),
//                             Spacer(
//                               flex: 5,
//                             ),
//                             SizedBox(
//                               width: width / 1.5,
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     "egypt elbagour benha benha benha ",
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: Normal,
//                                         overflow: TextOverflow.ellipsis),
//                                     maxLines: 2,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Spacer(
//                               flex: 10,
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 35,
//                         ),
//                         buildRow(text: 'total', val: 30),
//                         SizedBox(
//                           height: 35,
//                         ),
//                         Button1(
//                             pressButton: () {},
//                             text: 'Place Order',
//                             icon: Icons.arrow_forward)
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 70,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }

//   Widget buildRow({String? text, double? val}) {
//     return Row(
//       children: [
//         Text(
//           "$text",
//           style: TextStyle(fontSize: 17, fontWeight: Normal),
//         ),
//         Spacer(),
//         Text(
//           "$val",
//           style: TextStyle(fontSize: 17, fontWeight: Normal),
//         ),
//       ],
//     );
//   }

//   Row BagRow(double width, double height, Product item) {
//     return Row(
//       children: [
//         Container(
//           width: width / 2.7,
//           height: height / 5,
//           decoration: BoxDecoration(
//               color: black, borderRadius: BorderRadius.circular(15)),
//           child: Image(
//             image: AssetImage('${item.imagePath}'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         SizedBox(
//           width: width / 20,
//         ),
//         SizedBox(
//           width: width / 2.1,
//           height: height / 5.5,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Text(
//                 "${item.title}",
//                 style: TextStyle(fontWeight: Medium),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Column(
//                     children: [
//                       Text("${item.oldprice!.round()}",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: Semi_bold,
//                               color: oldPriceColor,
//                               decoration: TextDecoration.lineThrough)),
//                       Text("${item.newprice!.round()}",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: Semi_bold,
//                             color: orange,
//                           ))
//                     ],
//                   ),
//                   SizedBox(
//                     width: 7,
//                   ),
//                   Expanded(
//                     child: Container(
//                         width: 10,
//                         height: 40,
//                         decoration: BoxDecoration(
//                             color: red,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10),
//                                 bottomLeft: Radius.circular(10),
//                                 bottomRight: Radius.circular(10))),
//                         child: MaterialButton(
//                             child: Center(
//                               child: Text(
//                                 '-',
//                                 style: TextStyle(color: white, fontSize: 22),
//                               ),
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 item.count > 0 && item.count <= 9
//                                     ? item.count--
//                                     : item.count = item.count;
//                               });
//                             })),
//                   ),
//                   SizedBox(
//                     width: width / 25,
//                   ),
//                   Text(
//                     "${item.count}",
//                     style: TextStyle(fontSize: 17, fontWeight: Bold),
//                   ),
//                   SizedBox(
//                     width: width / 25,
//                   ),
//                   Expanded(
//                     child: Container(
//                         width: 12,
//                         height: 40,
//                         decoration: BoxDecoration(
//                             color: green,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10),
//                                 bottomLeft: Radius.circular(10),
//                                 bottomRight: Radius.circular(10))),
//                         child: MaterialButton(
//                             child: Text(
//                               '+',
//                               style: TextStyle(color: white, fontSize: 22),
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 item.count >= 0 && item.count < 9
//                                     ? item.count++
//                                     : item.count = item.count;
//                               });
//                             })),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../../models/MYbag.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var dateControler = TextEditingController();
  var timeControler = TextEditingController();
  var timeControler1 = TextEditingController();
  var formkey = GlobalKey<FormState>();

  List<Product> product = [
    Product(
        title: 'Aria DANO Full Cream Milk Powder instant',
        count: 1,
        imagePath: 'assets/images/cheetos.jpg',
        newprice: 182,
        oldprice: 200),
    // Product(
    //     title: 'Aria DANO Full Cream Milk Powder instant',
    //     count: 1,
    //     imagePath: 'assets/images/Rectangle.png',
    //     newprice: 182,
    //     oldprice: 200),
    // Product(
    //     title: 'Aria DANO Full Cream Milk Powder instant',
    //     count: 1,
    //     imagePath: 'assets/images/Rectangle.png',
    //     newprice: 182,
    //     oldprice: 200),
    // Product(
    //     title: 'Aria DANO Full Cream Milk Powder instant',
    //     count: 1,
    //     imagePath: 'assets/images/Rectangle.png',
    //     newprice: 182,
    //     oldprice: 200),
    // Product(
    //     title: 'Aria DANO Full Cream Milk Powder instant',
    //     count: 1,
    //     imagePath: 'assets/images/Rectangle.png',
    //     newprice: 182,
    //     oldprice: 200),
    // Product(
    //     title: 'Aria DANO Full Cream Milk Powder instant',
    //     count: 1,
    //     imagePath: 'assets/images/Rectangle.png',
    //     newprice: 182,
    //     oldprice: 200),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    Product selectedProduct;
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null && args.containsKey('product')) {
      selectedProduct = args['product'] as Product;
      product.add(selectedProduct);

      // Use the selected product information as needed
      print('Selected Product: ${selectedProduct.imagePath}');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Bag",
          style:
              TextStyle(fontSize: 20, fontWeight: Semi_bold, color: semiBlack),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height / 31,
                ),
                SizedBox(
                  height: height / 25,
                ),
                Text(
                  "Products",
                  style: TextStyle(
                      fontSize: 16, fontWeight: Medium, color: semiBlack),
                ),
                SizedBox(
                  height: height / 35,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: height / 2,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          BagRow(width, height, product[index], index),
                      separatorBuilder: (context, index) => Column(
                        children: [
                          SizedBox(
                            height: height / 40,
                          ),
                          Divider(
                            color: black.withOpacity(0.3),
                          ),
                          SizedBox(
                            height: height / 40,
                          ),
                        ],
                      ),
                      itemCount: product.length,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Button1(
                  pressButton: () {
                    print('ffdf');
                  },
                  text: 'Add More Product',
                  color1: bgtn,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Expected Date & Time",
                  style: TextStyle(fontWeight: Medium, fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      itemField(
                        suffix: Icons.arrow_circle_down,
                        clickable: true,
                        control: dateControler,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "date must not be empty";
                          }
                          return null;
                        },
                        onTappped: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2024),
                          ).then((value) {
                            dateControler.text =
                                DateFormat.yMMMd().format(value!);
                            print(DateFormat.yMMMd().format(value));
                          });
                        },
                        label: "Select Date",
                        hint: 'Select Date',
                        prefix: Icons.date_range,
                        keyboard: TextInputType.datetime,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      itemField(
                        clickable: true,
                        control: timeControler,
                        validate: (value) {
                          if (value.isEmpty) {
                            return "time must not be empty";
                          }
                          return null;
                        },
                        onTappped: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            timeControler.text =
                                value!.format(context).toString();
                            print(value.format(context));
                          });
                        },
                        keyboard: TextInputType.datetime,
                        label: "time",
                        hint: 'time',
                        prefix: Icons.watch_later_outlined,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Text(
                            "Delivery Location",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: Medium,
                                fontSize: 16),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Change",
                              style: TextStyle(
                                  color: green,
                                  fontSize: 16,
                                  fontWeight: Medium),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Spacer(
                            flex: 1,
                          ),
                          CircleAvatar(
                            backgroundColor: green,
                            radius: 25,
                            child: Icon(
                              Icons.location_on,
                              color: white,
                            ),
                          ),
                          Spacer(
                            flex: 5,
                          ),
                          SizedBox(
                            width: width / 1.5,
                            child: Column(
                              children: [
                                Text(
                                  "egypt elbagour benha benha benha ",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: Normal,
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      buildRow(text: 'total', val: 30),
                      SizedBox(
                        height: 35,
                      ),
                      Button1(
                        pressButton: () {},
                        text: 'Place Order',
                        icon: Icons.arrow_forward,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow({String? text, double? val}) {
    return Row(
      children: [
        Text(
          "$text",
          style: TextStyle(fontSize: 17, fontWeight: Normal),
        ),
        Spacer(),
        Text(
          "$val",
          style: TextStyle(fontSize: 17, fontWeight: Normal),
        ),
      ],
    );
  }

  Row BagRow(double width, double height, Product item, int index) {
    return Row(
      children: [
        Container(
          width: width / 2.7,
          height: height / 5,
          decoration: BoxDecoration(
              color: black, borderRadius: BorderRadius.circular(15)),
          child: Image(
            image: AssetImage('${item.imagePath}'),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: width / 20,
        ),
        SizedBox(
          width: width / 2.1,
          height: height / 5.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${item.title}",
                style: TextStyle(fontWeight: Medium),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text("${item.oldprice!.round()}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: Semi_bold,
                              color: oldPriceColor,
                              decoration: TextDecoration.lineThrough)),
                      Text("${item.newprice!.round()}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: Semi_bold,
                              color: orange))
                    ],
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Container(
                      width: 10,
                      height: 40,
                      decoration: BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: MaterialButton(
                        child: Center(
                          child: Text(
                            '-',
                            style: TextStyle(color: white, fontSize: 22),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            item.count > 0 && item.count <= 9
                                ? item.count--
                                : item.count = item.count;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width / 25,
                  ),
                  Text(
                    "${item.count}",
                    style: TextStyle(fontSize: 17, fontWeight: Bold),
                  ),
                  SizedBox(
                    width: width / 25,
                  ),
                  Expanded(
                    child: Container(
                      width: 12,
                      height: 40,
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: MaterialButton(
                        child: Text(
                          '+',
                          style: TextStyle(color: white, fontSize: 22),
                        ),
                        onPressed: () {
                          setState(() {
                            item.count >= 0 && item.count < 9
                                ? item.count++
                                : item.count = item.count;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
