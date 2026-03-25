class MenuValidators {
  static String? validatePortionName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Portion name is required';
    }
    if (value.trim().length < 2) {
      return 'Portion name must be at least 2 characters';
    }
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }
    final price = double.tryParse(value);
    if (price == null) {
      return 'Please enter a valid number';
    }
    if (price < 0) {
      return 'Price cannot be negative';
    }
    return null;
  }

  static String? validateCount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    final count = int.tryParse(value);
    if (count == null) {
      return 'Please enter a valid integer';
    }
    if (count < 1) {
      return 'Count must be at least 1';
    }
    return null;
  }

  static String? validateUnit(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional field
    }
    if (value.trim().length > 20) {
      return 'Unit name is too long';
    }
    return null;
  }
}
