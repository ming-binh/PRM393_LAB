import '../Entities/Product.dart';


class ProductDao {
  static List<Product> getProducts() {
    return [
      Product(
        id: "P01",
        name: "Super Dog",
        price: 40.0,
        image: "assets/images/d1.jpg",
        description: "Chó dễ thương",
        likes: 11,
      ),

      Product(
        id: "P02",
        name: "Shiba Dog",
        price: 40.0,
        image: "assets/images/d2.jpg",
        description: "Chó Shiba",
        likes: 20,
      ),

      Product(
        id: "P03",
        name: "Shiro",
        price: 40.0,
        image: "assets/images/d3.jpg",
        description: "Chó màu trắng",
        likes: 13,
      ),

      Product(
        id: "P04",
        name: "Con j đó",
        price: 550.0,
        image: "assets/images/d4.jpg",
        description: "Chó",
        likes: 34,
      ),

      Product(
        id: "P05",
        name: "Lắm lông",
        price: 700.0,
        image: "assets/images/d5.jpg",
        description: "Lống lăm",
        likes: 75,
      ),
    ];
  }
}