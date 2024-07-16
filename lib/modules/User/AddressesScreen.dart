import 'package:flutter/material.dart';
import 'package:grocery/shared/components/AddressCard.dart';
import 'package:grocery/models/helperClass.dart';
import 'package:grocery/cubit/grocery_cubit.dart';

class AddressesScreen extends StatefulWidget {
  AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  List<AddressCard> addresses = [];

  bool isEditing = false; // Track if in editing mode

  @override
  void initState() {
    super.initState();
    // Fetch addresses when the screen is opened
    fetchAddresses();
  }

  void fetchAddresses() async {
    var cubit = GroceryCubit.get(context);
    List addressesData =
        await Helper.getAddresses(cubit.userNameController.text);

    setState(() {
      addresses = addressesData
          .map((address) => AddressCard(
                addresseslength: addresses.length,
                addressName: address['address_title'],
                addressDesc: address['user_address'],
              ))
          .toList();
    });
  }

  void _addNewAddress() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        var cubit = GroceryCubit.get(context);
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add New Address',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Address Name'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: descController,
                decoration: InputDecoration(labelText: 'Address Description'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  int response = await Helper.addAddress(
                    address_title: nameController.text,
                    user_address: descController.text,
                    user_username: cubit.userNameController.text,
                  );

                  if (response > 0) {
                    // Add the new address data
                    setState(() {
                      addresses.add(
                        AddressCard(
                          addresseslength: addresses.length,
                          addressName: nameController.text,
                          addressDesc: descController.text,
                        ),
                      );
                    });
                  }

                  Navigator.pop(context);
                },
                child: Text(
                  'Add Address',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Addresses'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return addresses[index];
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: heightScreen / 100,
                left: widthScreen / 30,
                right: widthScreen / 30,
              ),
              child: ElevatedButton(
                onPressed: () => _addNewAddress(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: heightScreen / 17,
                  child: Center(
                    child: Text(
                      'Add New Address',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
