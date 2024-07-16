import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    // To get the path of database
    String databasepath = await getDatabasesPath();
    // To join the database path with its name
    String path = join(databasepath, 'grocery.db');
    // Create database
    Database mydb = await openDatabase(path,
        onCreate: _onCreate,
        version: 1,
        onUpgrade:
            _onUpgrade); // Change version number to update database tables

    return mydb;
  }

  // To create tables in the database (executed only once when creating database)
  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    // Create admin table
    batch.execute("""
    CREATE TABLE admins
    (
      adm_username TEXT NOT NULL PRIMARY KEY, 
      adm_fullName TEXT NOT NULL,
      adm_password TEXT NOT NULL,
      adm_phoneNum TEXT,
      adm_img TEXT
    )
    """);

    // Create user table
    batch.execute("""
    CREATE TABLE users
    (
      user_username TEXT NOT NULL PRIMARY KEY, 
      user_fullName TEXT NOT NULL,
      user_password TEXT NOT NULL,
      user_phoneNum TEXT NOT NULL,
      user_img TEXT
    )
    """);

    // Create user addresses table
    batch.execute("""
    CREATE TABLE users_addresses
    (
      user_username TEXT NOT NULL, 
      user_address TEXT NOT NULL,
      address_title TEXT,
      FOREIGN KEY (user_username) REFERENCES users(user_username),
      PRIMARY KEY (user_username, user_address)
    )
    """);

    // Create categories table
    batch.execute("""
    CREATE TABLE categories
    (
      cat_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      category TEXT NOT NULL
    )
    """);

    // Create products table
    batch.execute("""
    CREATE TABLE products
    (
      prod_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      prod_name TEXT NOT NULL,
      prod_amount INTEGER NOT NULL,
      prod_brand TEXT,
      prod_old_price REAL NOT NULL,
      prod_new_price REAL NOT NULL,
      cat_id INTEGER,
      FOREIGN KEY (cat_id) REFERENCES categories(cat_id)
    )
    """);

    // Create products images table
    batch.execute("""
    CREATE TABLE products_images
    (
      prod_id INTEGER NOT NULL,
      prod_img TEXT NOT NULL,
      FOREIGN KEY (prod_id) REFERENCES products(prod_id),
      PRIMARY KEY (prod_id, prod_img)
    )
    """);

    // Create orders table
    batch.execute("""
    CREATE TABLE orders
    (
      ord_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      ord_date TEXT NOT NULL,
      ord_status TEXT NOT NULL,
      ord_location TEXT NOT NULL,
      user_username TEXT NOT NULL,
      FOREIGN KEY (user_username) REFERENCES users(user_username)
    )
    """);

    // Create orders elements table
    batch.execute("""
    CREATE TABLE orders_elements
    (
      ord_id INTEGER NOT NULL,
      prod_id INTEGER NOT NULL,
      ord_quantity INTEGER NOT NULL,
      FOREIGN KEY (ord_id) REFERENCES orders(ord_id),
      FOREIGN KEY (prod_id) REFERENCES products(prod_id),
      PRIMARY KEY (ord_id, prod_id)
    )
    """);

    await batch.commit();

    print(
        '=====================Create DATABASE and TABLE=====================');
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    print('=====================Upgrade DATABASE TABLES=====================');
  }

  // Select
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  // INSERT
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  // UPDATE
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql); // 0 if fails
    return response;
  }

  // DELETE
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql); // 0 if fails
    return response;
  }

  myDeleteDatabase() async {
    // To ge the path of database
    String databasepath = await getDatabasesPath();
    // To join the database path with its name
    String path = join(databasepath, 'grocery.db');

    await deleteDatabase(path);
  }
}
