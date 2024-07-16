import 'package:grocery/Network/local/dbHelper.dart';
import 'dart:convert';
import 'dart:typed_data';

class Helper {
  static final SqlDb sqlDb = SqlDb();

  // This function will be used in register page to add user to the system
  static Future<int> userRegister(
      {required String user_username,
      required String user_fullName,
      required String user_password,
      required String user_phoneNum}) async {
    int response;
    try {
      response = await sqlDb.insertData("""
        INSERT INTO users(user_username, user_fullName, user_password, user_phoneNum)
        VALUES("${user_username}", "${user_fullName}", "${user_password}", "${user_phoneNum}")
        """);
    } catch (e) {
      response =
          -1; // Return -1 if there is issues in registeration like used username or Null full name
    }

    return response;
  }

  // This function will be used to add admin
  static Future<int> addAdmin(
      {required String adm_username,
      required String adm_fullName,
      required String adm_password,
      required String adm_phoneNum}) async {
    int response = await sqlDb.insertData("""
      INSERT INTO admins(adm_username, adm_fullName, adm_password, adm_phoneNum)
      VALUES("${adm_username}", "${adm_fullName}", "${adm_password}", "${adm_phoneNum}")
      """);

    return response;
  }

  // This function will be used in Login return true if user can login else 0
  static Future<bool> login(
      {required String username, required String password}) async {
    // Check if it was a normal user
    if (username.endsWith('@grocery.user')) {
      List<Map> response = await sqlDb.readData("""
        SELECT * FROM users
        WHERE user_username = "${username}" 
        AND user_password = "${password}"
        """);
      if (response.isEmpty) {
        return false; // Return false if user not found
      } else {
        return true; // Return true if user found
      }
    }

    // Check if it was an admin
    if (username.endsWith('@grocery.admin')) {
      List<Map> response = await sqlDb.readData("""
        SELECT * FROM admins
        WHERE adm_username = "${username}" 
        AND adm_password = "${password}"
        """);
      if (response.isEmpty) {
        return false; // Return false if admin not found
      } else {
        return true; // Return true if admin found
      }
    }

    // Return false if the username extension was incorrect
    return false;
  }

  // This function will return all data of the user by its username
  static Future<Map<String, dynamic>> fetchUserData(String username) async {
    List<Map<String, dynamic>> response = await sqlDb.readData("""
      SELECT * FROM users WHERE user_username = "${username}"
    """);

    // Check if there is any data before accessing the first element
    if (response.isNotEmpty) {
      return response[0];
    } else {
      // Return an empty map or throw an exception based on your application logic
      return {};
    }
  }

  // This function will be used to edit user information
  static Future<int> editUserProfile(
      {required String user_username,
      required String user_fullName,
      required String user_password,
      required String user_phoneNum,
      Uint8List? imageBytes}) async {
    String? base64Image;

    // Encode image for storing
    if (imageBytes != null) {
      base64Image = base64Encode(imageBytes);
    } else {
      base64Image = null;
    }

    int response = await sqlDb.updateData("""
    UPDATE users
    SET user_fullName = "${user_fullName}", user_password = "${user_password}", user_phoneNum = "${user_phoneNum}" , user_img = "${base64Image}"
    WHERE user_username = "${user_username}"
    """);

    return response;
  }

  // This function will return all data of the admin by its username
  static Future<Map<String, dynamic>> fetchAdminData(String username) async {
    List<Map<String, dynamic>> response = await sqlDb.readData("""
      SELECT * FROM admins WHERE adm_username = "${username}"
    """);

    // Check if there is any data before accessing the first element
    if (response.isNotEmpty) {
      return response[0];
    } else {
      // Return an empty map or throw an exception based on your application logic
      return {};
    }
  }

  // This function will be used to edit admin information
  static Future<int> editAdminProfile(
      {required String adm_username,
      required String adm_fullName,
      required String adm_password,
      required String adm_phoneNum,
      Uint8List? imageBytes}) async {
    String? base64Image;

    // Encode image for storing
    if (imageBytes != null) {
      base64Image = base64Encode(imageBytes);
    } else {
      base64Image = null;
    }

    int response = await sqlDb.updateData("""
    UPDATE admins
    SET adm_fullName = "${adm_fullName}", adm_password = "${adm_password}", adm_phoneNum = "${adm_phoneNum}" , adm_img = "${base64Image}"
    WHERE adm_username = "${adm_username}"
    """);

    return response;
  }

  // this function will add address according to user username
  static Future<int> addAddress(
      {required String user_username,
      required String user_address,
      required String address_title}) async {
    int response = await sqlDb.insertData("""
    INSERT INTO users_addresses(user_username, user_address, address_title)
    VALUES ("${user_username}", "${user_address}", "${address_title}")
    """);

    return response;
  }

  // Get addreses
  static Future<List> getAddresses(String username) async {
    List response = await sqlDb.readData("""
    SELECT * FROM users_addresses 
    WHERE user_username = "${username}"
    """);

    return response;
  }

  // Delete address from DB
  static Future<int> deleteAddress({
    required String user_username,
    required String address_desc,
  }) async {
    int response = await sqlDb.deleteData("""
    DELETE FROM users_addresses
    WHERE user_username = "${user_username}" AND user_address = "${address_desc}"
  """);

    return response;
  }

  // Add new Category to DB by Admin
  static Future<int> addCategory({required String category}) async {
    int response = await sqlDb.insertData("""
    INSERT INTO categories(category)
    VALUES ("${category}")
    """);

    return response;
  }

  // Get Categories
  static Future<List> getCategory() async {
    List response = await sqlDb.readData("""
    SELECT * FROM categories
    """);

    return response;
  }

  // Add new Product to DB by Admin
  static Future<int> addProduct({
    required String prodName,
    required int prodAmount,
    String? prodBrand,
    required double prodOldPrice,
    required double prodNewPrice,
    required int catId,
  }) async {
    int response = await sqlDb.insertData("""
      INSERT INTO products(prod_name, prod_amount, prod_brand, prod_old_price, prod_new_price, cat_id)
      VALUES("$prodName", "$prodAmount", "$prodBrand", $prodOldPrice, $prodNewPrice, $catId)
    """);

    return response;
  }

  // Get All Product
  static Future<List> getAllProducts() async {
    List results = await sqlDb.readData('SELECT * FROM products');
    return results;
  }

  // Add Product image
  static Future<int> addProductImage({
    required int prodId,
    required List<Uint8List?> prodImage,
  }) async {
    int response = 0;
    String? base64Image;

    for (var imageBytes in prodImage) {
      // Encode image for storing
      if (imageBytes != null) {
        base64Image = base64Encode(imageBytes);
      } else {
        base64Image = null;
      }
      response = await sqlDb.insertData("""
      INSERT INTO products_images(prod_id, prod_img)
      VALUES($prodId, "$base64Image")
      """);
    }
    return response;
  }

  // Get Product image
  static Future<List> getProductImages(int prodId) async {
    List<Map> results = await sqlDb.readData(
      'SELECT * FROM products_images WHERE prod_id = $prodId',
    );

    return results;
  }

  // To delete category
  static Future<int> deleteCategory({required int cat_id}) async {
    int response = await sqlDb.deleteData("""
    DELETE FROM categories
    WHERE cat_id = "${cat_id}"
    """);

    return response;
  }

  // Update Category data
  static Future<int> updateCategory(
      {required int cat_id, required String category}) async {
    int response = await sqlDb.updateData("""
    UPDATE categories
    SET category = "${category}"
    WHERE cat_id = "${cat_id}"
    """);

    return response;
  }

  // This function will be used to update the address information
  static Future<int> updateAddress({
    required String user_username,
    required String oldAddressTitle,
    required String newAddressTitle,
    required String newAddressDesc,
  }) async {
    try {
      int response = await sqlDb.updateData("""
      UPDATE users_addresses
      SET address_title = "$newAddressTitle", user_address = "$newAddressDesc"
      WHERE user_username = "$user_username" AND address_title = "$oldAddressTitle"
    """);
      return response;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // Search for a Product in DB
  static Future<List> searchProducts(String query) async {
    try {
      List response = await sqlDb.readData("""
      SELECT * FROM products
      WHERE LOWER(name) LIKE '%${query.toLowerCase()}%'
    """);
      return response;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<Uint8List>> fetchProductImages(
      {required int prod_id}) async {
    List<Map> results = await sqlDb
        .readData('SELECT * FROM products_images WHERE prod_id = $prod_id');

    List<Uint8List> imgs = [];

    if (results.isNotEmpty) {
      for (var i in results) {
        imgs.add(base64Decode(i['prod_img']));
      }

      return imgs;
    } else {
      return [];
    }
  }

  static Future<int> deleteProduct({required int prod_id}) async {
    int response2 = await sqlDb.deleteData("""
    DELETE FROM products 
    WHERE prod_id = $prod_id
    """);

    return response2;
  }

// Add new order to Bag
  static Future<int> addOrder({
    required String ord_date,
    required String ord_status,
    String? ord_location,
    required String user_username,
  }) async {
    int response = await sqlDb.insertData("""
      INSERT INTO orders(ord_date, ord_status, ord_location, user_username)
      VALUES("$ord_date", "$ord_status", "$ord_location", $user_username)
    """);
    print(response);
    return response;
  }
}
