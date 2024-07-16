import 'package:flutter/material.dart';
import 'package:grocery/shared/styles/colors.dart';
import 'package:grocery/models/helperClass.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List> categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = Helper.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Category',
          style: TextStyle(
            color: semiBlack,
          ),
        ),
      ),
      body: FutureBuilder<List>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading categories'),
            );
          } else {
            List categories = snapshot.data!;

            return Container(
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        // Assuming you have a 'route' field in your categories table
                        Navigator.pushNamed(
                            context, categories[index]['route']);
                      },
                      title: Text(categories[index]['category']),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
