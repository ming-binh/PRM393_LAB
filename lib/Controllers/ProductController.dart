import '../Entities/Product.dart';

class ProductController {
  static List<Product> listProducts = [];

  // Data
  static void seedInitialData() {
    listProducts = [
      Product(id: 'P001', name: 'iPhone 15 Pro Max', image: 'iphone15pm.png', price: 1234.56),
      Product(id: 'P002', name: 'MacBook Pro M3', image: 'macbook_m3.png', price: 1999.99),
      Product(id: 'P003', name: 'Sony', image: 'sony.png', price: 349.50),
      Product(id: 'P004', name: 'iPad Pro M4', image: 'ipad_m4.png', price: 999.00),
    ];
  }

  // 1. ADD Product
  static void addProduct(Product newProduct) {
    bool isExist = listProducts.any((p) => p.id == newProduct.id);
    if (isExist) {
      print('Insertion failed! Product ID "${newProduct.id}" already exists.');
    } else {
      listProducts.add(newProduct);
      print('Product added: ${newProduct.name}');
    }
  }

  // 2. DISPLAY ALL Products
  static void displayAll() {
    if (listProducts.isEmpty) {
      print('\n--- The product list is currently empty ---');
      return;
    }
    print('\n--- PRODUCT LIST ---');
    for (var p in listProducts) {
      print(p.toString());
    }
    print('--------------------------------\n');
  }

  // 3. UPDATE Product by ID
  static void updateProduct(String id, String newName, String newImage, double newPrice) {
    int index = listProducts.indexWhere((p) => p.id == id);
    if (index != -1) {
      listProducts[index].name = newName;
      listProducts[index].image = newImage;
      listProducts[index].price = newPrice;
      print('Product with ID: $id has been updated.');
    } else {
      print('Update failed! Product ID: $id not found.');
    }
  }

  // 4. DELETE Product by ID
  static void deleteProduct(String id) {
    int initialLength = listProducts.length;
    listProducts.removeWhere((p) => p.id == id);

    if (listProducts.length < initialLength) {
      print('Product with ID: $id has been deleted.');
    } else {
      print('Deletion failed! Product ID: $id not found.');
    }
  }

  // 5. SEARCH Product by Name
  static List<Product> searchByName(String keyword) {
    return listProducts.where((p) {
      return p.name.toLowerCase().contains(keyword.toLowerCase());
    }).toList();
  }

// 6. SEARCH Product by Exact Id
  static Product? searchById(String id) {
    for (var p in listProducts) {
      if (p.id.toLowerCase() == id.trim().toLowerCase()) {
        return p;
      }
    }
    return null;
  }

  // 7. SORT
  static void sortByPrice({bool ascending = true}) {
    listProducts.sort((a, b) {
      return ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price);
    });
    String sortOrder = ascending ? "Ascending" : "Descending";
    print('Product list sorted by price ($sortOrder).');
  }
}