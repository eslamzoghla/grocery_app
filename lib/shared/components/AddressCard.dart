import 'package:flutter/material.dart';
import 'package:grocery/cubit/grocery_cubit.dart';
import 'package:grocery/models/helperClass.dart';

class AddressCard extends StatefulWidget {
  String? addressName;
  String? addressDesc;
  int addresseslength;
  final Function(String)?
      onDelete; // Callback to notify the parent about the delete

  AddressCard(
      {required this.addressName,
      required this.addressDesc,
      required this.addresseslength,
      this.onDelete});

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  List addresses = [];

  Future readAddress(String username) async {
    List response = await Helper.getAddresses(username);
    addresses.addAll(response);
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    var cubit = GroceryCubit.get(context);
    // Function to show modal bottom sheet for editing address

    void _editAddress(String addressTitle) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          TextEditingController nameController =
              TextEditingController(text: addressTitle);
          TextEditingController descController = TextEditingController(
            text: widget.addressDesc,
          );

          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit Address',
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
                    primary: Colors.green,
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
                    // Update the address data
                    int response = await Helper.updateAddress(
                      user_username: cubit.userNameController.text,
                      oldAddressTitle: addressTitle,
                      newAddressTitle: nameController.text,
                      newAddressDesc: descController.text,
                    );

                    if (response > 0) {
                      setState(() {
                        widget.addressName = nameController.text;
                        widget.addressDesc = descController.text;
                      });

                      Navigator.pop(context); // Close the modal sheet
                      // Show a SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Address updated successfully!'),
                        ),
                      );
                    } else {
                      // Handle the case where the update failed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Failed to update address!'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Save Changes',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Future<void> _deleteAddress(String addressDesc) async {
      var cubit = GroceryCubit.get(context);

      // Delete the address from the database
      int response = await Helper.deleteAddress(
        user_username: cubit.userNameController.text,
        address_desc: addressDesc,
      );

      if (response > 0) {
        setState(() {});

        // Notify the parent about the delete
        widget.onDelete?.call(addressDesc);
        Helper.getAddresses(cubit.userNameController.text);
        // Show a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Address deleted successfully!'),
          ),
        );
      }
    }

    // Function for deleting address
    void _showDeleteConfirmationDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Delete'),
            content: Text('Are you sure you want to delete this address?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Navigator.pop(context);
                  _deleteAddress(widget.addressDesc!);
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, 'AddressesScreen', (route) => true);
                },
                child: Text('Delete'),
              ),
            ],
          );
        },
      );
    }

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          child: ListTile(
            subtitle: Text(widget.addressDesc!, style: TextStyle(fontSize: 17)),
            title: Text(widget.addressName!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                  width: 40,
                  height: 40,
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.white, size: 23),
                    onPressed: () => _editAddress(widget.addressName!),
                  ),
                ),
                SizedBox(width: widthScreen / 20),
                Padding(
                  padding: EdgeInsets.only(right: widthScreen / 1000),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    width: 40,
                    height: 40,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white, size: 23),
                      onPressed: _showDeleteConfirmationDialog,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
