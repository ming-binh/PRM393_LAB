class Product {
  String id;
  String name;
  double price;
  String image;
  String description;
  int likes;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    this.likes = 0,
  });
}