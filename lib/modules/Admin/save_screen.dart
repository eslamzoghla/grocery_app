import 'package:flutter/material.dart';
import 'package:grocery/models/helperClass.dart';
import 'package:grocery/shared/components/custom_button.dart';
import 'package:grocery/shared/styles/colors.dart';

class SaveScreen extends StatelessWidget {
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Get data from the previous page
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          bottom: 47,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 24.0,
                left: 24,
                top: 35,
                bottom: 12,
              ),
              child: ClipRRect(
                child: Image.memory(
                  arg['product_images'][0],
                  height: 300,
                  width: 300,
                ),
              ),
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
              arg['prod_amount'],
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Icon(
                  Icons.sort,
                  color: semiBlack,
                ),
                SizedBox(
                  width: 9,
                ),
                Text(
                  arg['prod_brand'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Spacer(),
            CustomButtom(
              text: 'Save',
              icon: const Icon(Icons.save_outlined),
              onTap: () async {
                int respone1 = await Helper.addProduct(
                    prodName: arg['prod_name'],
                    prodAmount: int.parse(arg['prod_amount']),
                    prodOldPrice: double.parse(arg['prod_old_price']),
                    prodNewPrice: double.parse(arg['prod_new_price']),
                    catId: arg['cat_id'],
                    prodBrand: arg['prod_brand']);

                if (respone1 > 0) {
                  int response2 = await Helper.addProductImage(
                      prodId: respone1, prodImage: arg['product_images']);
                  if (response2 > 0) {
                    Navigator.pushNamed(context, 'AdminMainPage');
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
