class Product {
  String id;
  String name;
  String image;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  @override
  String toString() {
    return 'ID: $id | Name: $name | Price: \$$price | Image: $image';
  }
}