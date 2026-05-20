import 'dart:io';
import 'Entities/Product.dart';
import 'Repository/ProductDAO.dart';
import 'Utils/ProductValidator.dart';

void main() {
  Productdao dao = Productdao([]);

  dao.l = Product.products;

  bool isRunning = true;

  while (isRunning) {
    print('\n===== PRODUCT MANAGEMENT SYSTEM =====');
    print('1. Add New Product');
    print('2. Display All Existing Products');
    print('3. Update Product Information');
    print('4. Delete Product');
    print('5. Search Products by Name');
    print('6. Search Product by ID');
    print('7. Sort Products by Price');
    print('8. Increase All Prices by 10% (Map)');
    print('0. Exit');
    print('================================================');
    stdout.write('Please input your action option: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        print('\n--- ADD PRODUCT ---');
        String id = '';
        String name = '';
        String image = '';
        double price = 0.0;

        while (true) {
          stdout.write('Enter Product ID (e.g., P123): ');
          id = stdin.readLineSync() ?? '';
          String? error = ProductValidator.validateId(id);
          if (error == null) break;
          print('[Validation Error] $error');
        }

        while (true) {
          stdout.write('Enter Product Name: ');
          name = stdin.readLineSync() ?? '';
          String? error = ProductValidator.validateName(name);
          if (error == null) break;
          print('[Validation Error] $error');
        }

        while (true) {
          stdout.write('Enter Image URL/Path (.png/.jpg): ');
          image = stdin.readLineSync() ?? '';
          String? error = ProductValidator.validateImage(image);
          if (error == null) break;
          print('[Validation Error] $error');
        }

        while (true) {
          stdout.write('Enter Price: ');
          String priceRaw = stdin.readLineSync() ?? '';
          String? error = ProductValidator.validatePrice(priceRaw);
          if (error == null) {
            price = double.parse(priceRaw.trim());
            break;
          }
          print('[Validation Error] $error');
        }

        Product newProduct = Product(id: id.trim(), name: name.trim(), image: image.trim(), price: price);

        dao.add(newProduct);
        break;

      case '2':
        print('\n--- PRODUCT LIST ---');
        dao.displayAll();
        break;

      case '3':
        print('\n--- UPDATE PRODUCT ---');
        stdout.write('Enter Product ID to update: ');
        String updateId = stdin.readLineSync() ?? '';

        Product? existingProduct = dao.Find(updateId);
        if (existingProduct == null) {
          print('Update failed! Product ID: $updateId not found.');
          break;
        }

        print('\nProduct found: [ ${existingProduct.name} ]');
        print('(Leave input empty to keep the current value)');
        print('------------------------------------------------------------');

        String newName = '';
        String newImage = '';
        double newPrice = existingProduct.price;

        while (true) {
          stdout.write('Enter New Name [Current: ${existingProduct.name}]: ');
          String input = stdin.readLineSync() ?? '';

          if (input.trim().isEmpty) {
            newName = existingProduct.name;
            break;
          }
          String? error = ProductValidator.validateName(input);
          if (error == null) {
            newName = input.trim();
            break;
          }
          print('[Validation Error] $error');
        }

        while (true) {
          stdout.write('Enter New Image URL [Current: ${existingProduct.image}]: ');
          String input = stdin.readLineSync() ?? '';

          if (input.trim().isEmpty) {
            newImage = existingProduct.image;
            break;
          }

          String? error = ProductValidator.validateImage(input);
          if (error == null) {
            newImage = input.trim();
            break;
          }
          print('[Validation Error] $error');
        }
        while (true) {
          stdout.write('Enter New Price [Current: \$${existingProduct.price}]: ');
          String input = stdin.readLineSync() ?? '';
          if (input.trim().isEmpty) {
            break;
          }

          String? error = ProductValidator.validatePrice(input);
          if (error == null) {
            newPrice = double.parse(input.trim());
            break;
          }
          print('[Validation Error] $error');
        }

        Product updatedProduct = Product(id: updateId, name: newName, image: newImage, price: newPrice);
        dao.Edit(updatedProduct);
        break;

      case '4':
        print('\n--- DELETE PRODUCT ---');
        stdout.write('Enter Product ID to delete: ');
        String deleteId = stdin.readLineSync() ?? '';
        dao.delete(deleteId);
        break;

      case '5':
        print('\n--- SEARCH PRODUCT BY NAME ---');
        stdout.write('Enter Product Name keyword: ');
        String keyword = stdin.readLineSync() ?? '';

        var queryResults = dao.searchByName(keyword);
        if (queryResults.isEmpty) {
          print('Cannot find product');
        } else {
          print('\n--- Result ---');
          for (var p in queryResults) {
            print(p.toString());
          }
        }
        break;

      case '6':
        print('\n--- SEARCH PRODUCT BY ID ---');
        stdout.write('Enter Product ID: ');
        String searchId = stdin.readLineSync() ?? '';

        Product? foundProduct = dao.Find(searchId);

        if (foundProduct == null) {
          print('Cannot find product with ID: $searchId');
        } else {
          print('\n--- Result ---');
          print(foundProduct.toString());
        }
        break;

      case '7':
        print('\n--- SORT PRODUCT BY PRICE ---');
        stdout.write('Execute ascending order sequencing? (y/n): ');
        String inputSequence = stdin.readLineSync()?.toLowerCase() ?? 'y';
        bool isAscending = (inputSequence == 'y');

        dao.l.sort((a, b) {
          return isAscending ? a.price.compareTo(b.price) : b.price.compareTo(a.price);
        });

        print('Product list sorted.');
        dao.displayAll();
        break;

      case '8':
        print('\n--- INCREASE PRICE ---');
        dao.increasePrice();
        dao.displayAll();
        break;

      case '0':
        isRunning = false;
        print('\nExit');
        break;

      default:
        print('\nError: Option index must be between 0 and 8.');
    }
  }
}