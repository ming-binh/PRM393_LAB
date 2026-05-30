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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
    };
  }

  static List<Product> products = [
    Product(id: 'P001', name: 'iPhone 15 Pro Max', image: 'iphone15pm.png', price: 1234.56),
    Product(id: 'P002', name: 'MacBook Pro M3', image: 'macbook_m3.png', price: 1999.99),
    Product(id: 'P003', name: 'Sony', image: 'sony.png', price: 349.50),
    Product(id: 'P004', name: 'iPad Pro M4', image: 'ipad_m4.png', price: 999.00),
  ];

  @override
  String toString() {
    return 'ID: $id | Name: $name | Price: \$$price | Image: $image';
  }
}