import '../Entities/Product.dart';

class Productdao {
  List<Product> l;

  Productdao(this.l);

  // 1. Hàm add
  void add(Product p) {
    var index = l.indexWhere((element) => element.id == p.id);
    if (index < 0) {
      l.add(p);
      print('Add successful: ${p.name}');
    } else {
      print('ID already exists!');
    }
  }

  // 2. Hàm Edit
  void Edit(Product p) {
    var index = l.indexWhere((element) => element.id == p.id);
    if (index >= 0) {
      l[index] = p;
      print('Edit successful for ID: ${p.id}');
    } else {
      print('Product not found to edit!');
    }
  }

  // 3. Hàm Find
  Product? Find(String id) {
    var index = l.indexWhere((element) => element.id == id);
    if (index >= 0) {
      return l[index];
    }
    return null;
  }

  // 4. Các hàm Search khác nhau

  // 4.1 Search theo tên
  List<Product> searchByName(String keyword) {
    return l.where((element) =>
        element.name.toLowerCase().contains(keyword.toLowerCase())
    ).toList();
  }

  // 4.2 Search theo khoảng giá
  List<Product> searchByPriceRange(double minPrice, double maxPrice) {
    return l.where((element) =>
    element.price >= minPrice && element.price <= maxPrice
    ).toList();
  }

  // 5. Hàm increasePrice
  void increasePrice() {
    l = l.map((product) {
      product.price = product.price * 1.10;
      return product;
    }).toList();

    print('All products increased in price by 10% successfully.');
  }

  // Hàm hiển thị
  void displayAll() {
    for (var p in l) {
      print(p.toString());
    }
  }

  // Hàm xóa
  void delete(String id) {
    var index = l.indexWhere((element) => element.id == id);
    if (index >= 0) {
      l.removeAt(index);
      print('Delete successful for ID: $id');
    } else {
      print('Product not found!');
    }
  }
}