class Validators {
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
  }

  static String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
  }
  static String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
  }
}

