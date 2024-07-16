class Product {
  String? imagePath;
  String? title;
  double? oldprice;
  double? newprice;
  int count = 1;
  Product(
      {this.title,
      this.count = 1,
      this.imagePath,
      this.oldprice,
      this.newprice});
}
