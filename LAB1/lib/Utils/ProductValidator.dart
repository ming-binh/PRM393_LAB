class ProductValidator {
  // 1. Validate Product ID
  static String? validateId(String? id) {
    if (id == null || id.trim().isEmpty) {
      return 'Product ID cannot be empty or blank.';
    }
    final idRegex = RegExp(r'^P\d+$', caseSensitive: false);
    if (!idRegex.hasMatch(id.trim())) {
      return 'Product ID must start with "P" followed by numbers (e.g., P001).';
    }
    return null;
  }

  // 2. Validate Product Name
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Product name cannot be empty.';
    }
    if (name.trim().length < 3) {
      return 'Product name must be at least 3 characters long.';
    }
    return null;
  }

  // 3. Validate Image URL
  static String? validateImage(String? image) {
    if (image == null || image.trim().isEmpty) {
      return 'Image URL or path cannot be empty.';
    }
    if (!image.endsWith('.png') && !image.endsWith('.jpg') && !image.endsWith('.jpeg')) {
      return 'Image must be a valid image file path (.png, .jpg, or .jpeg).';
    }
    return null;
  }

  // 4. Validate Price
  static String? validatePrice(String? priceRaw) {
    if (priceRaw == null || priceRaw.trim().isEmpty) {
      return 'Price value cannot be empty.';
    }

    double? parsedPrice = double.tryParse(priceRaw.trim());
    if (parsedPrice == null) {
      return 'Price must be a valid decimal number.';
    }
    if (parsedPrice < 0) {
      return 'Price cannot be a negative value.';
    }
    return null;
  }
}