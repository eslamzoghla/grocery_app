import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grocery/shared/components/constants.dart';

import '../styles/colors.dart';

Widget itemField({
  TextEditingController? control,
  Function(String)? submitted,
  Function(String?)? onsave,
  Function(String)? change,
  String? hint,
  validate,
  TextInputType? keyboard,
  IconData? prefix,
  IconData? suffix,
  bool isobscure = false,
  Function()? pressed,
  bool clickable = false,
  String? label,
  void Function()? onTappped,
}) {
  return TextFormField(
    onTap: onTappped,
    readOnly: clickable,
    controller: control,
    onSaved: onsave,
    onFieldSubmitted: submitted,
    onChanged: change,
    keyboardType: keyboard,
    obscureText: isobscure,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: IconButton(
        icon: Icon(suffix),
        onPressed: pressed,
      ),
      hintText: hint,
      prefixIcon: Icon(prefix),
      border: OutlineInputBorder(),
    ),
    validator: validate,
  );
}

// button register
Widget Button1(
    {String? text,
    required Function() pressButton,
    IconData? icon,
    Color color1 = green}) {
  return Container(
    width: double.infinity,
    height: 60,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: color1),
    child: MaterialButton(
      onPressed: pressButton,
      // if( formKey.currentState!.validate()){
      //   print("done");
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>home()))
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          Center(
            child: Text(
              '$text',
              style: TextStyle(color: white, fontSize: 16, fontWeight: Medium),
            ),
          ),
          Spacer(),
          Icon(
            icon,
            color: white,
          ),
        ],
      ),
    ),
  );
}

/////////////category////////
Widget buildRow({
  required var width,
  required String category_name,
  required void Function() function,
  required void Function() function2,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: width / 1.7,
        child: Text(
          "$category_name",
          style: TextStyle(
            fontSize: 17,
            fontWeight: Medium,
          ),
          softWrap: true,
          maxLines: 2,
        ),
      ),
      Spacer(
        flex: 5,
      ),
      CircleAvatar(
          backgroundColor: orange,
          radius: 23,
          child: IconButton(
              onPressed: function2,
              icon: Icon(
                Icons.edit,
                color: white,
              ))),
      Spacer(
        flex: 15,
      ),
      CircleAvatar(
          backgroundColor: red,
          radius: 23,
          child: IconButton(
              onPressed: function,
              icon: Icon(
                Icons.delete,
                color: white,
              ))),
      Spacer(
        flex: 5,
      ),
    ],
  );
}

Widget HomeHotItem2(
        {required double widthScreen,
        required double heightScreen,
        Uint8List? image,
        required String imageText,
        required void Function() onpress,
        double? newPrice,
        double? oldPrice}) =>
    Container(
      height: 300,
      margin: EdgeInsets.only(
        left: widthScreen / 25,
        right: widthScreen / 50,
        top: heightScreen / 40,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.50),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.27),
            offset: Offset(0, 10),
            blurRadius: 50.0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onpress,
        child: Column(
          children: [
            if (image != null)
              Container(
                width: widthScreen / 4,
                height: heightScreen / 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(image),
                  ),
                ),
              )
            else
              CircleAvatar(radius: 50, backgroundColor: Colors.green),
            Container(
              padding: EdgeInsets.all(widthScreen / 800),
              child: Text(
                imageText,
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            newPrice == 0
                ? Text('')
                : Text(
                    'EGP $newPrice',
                    style: TextStyle(
                      color: newPriceColor,
                      fontSize: newPriceSize,
                    ),
                  ),
            Text(
              'EGP ${oldPrice!}',
              style: TextStyle(
                color: oldPriceColor,
                fontSize: oldPriceSize,
                decoration: newPrice == 0
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
              ),
            ),
            SizedBox(width: 5.0),
          ],
        ),
      ),
    );

Widget HomeHotItem(
        {required double widthScreen,
        required double heightScreen,
        Uint8List? image,
        required String imageText,
        required void Function() onpress,
        double? newPrice,
        double? oldPrice}) =>
    Container(
      height: 300,
      margin: EdgeInsets.only(
        left: widthScreen / 25,
        right: widthScreen / 50,
        top: heightScreen / 40,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.50),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.27),
            offset: Offset(0, 10),
            blurRadius: 50.0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onpress,
        child: Column(
          children: [
            /*
            if (cubit.imageBytes != null || imageBytes != null)
                          Container(
                            width: 175,
                            height: 175,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(
                                    imageBytes ??= cubit.imageBytes!),
                              ),
                            ),
                          )
                        else
                          CircleAvatar(
                              radius: 87, backgroundColor: Colors.green),

            Image.memory(
              image!,
              width: widthScreen / 3,
              height: heightScreen / 7,
            ),
            */
            if (image != null)
              Container(
                width: widthScreen / 4,
                height: heightScreen / 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(image),
                  ),
                ),
              )
            else
              CircleAvatar(radius: 50, backgroundColor: Colors.green),
            Container(
              padding: EdgeInsets.all(widthScreen / 800),
              child: Text(
                imageText,
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            newPrice == 0
                ? Text('')
                : Text(
                    'EGP $newPrice',
                    style: TextStyle(
                      color: newPriceColor,
                      fontSize: newPriceSize,
                    ),
                  ),
            Text(
              'EGP ${oldPrice!}',
              style: TextStyle(
                color: oldPriceColor,
                fontSize: oldPriceSize,
                decoration: newPrice == 0
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
              ),
            ),
            SizedBox(width: 5.0),
          ],
        ),
      ),
    );
