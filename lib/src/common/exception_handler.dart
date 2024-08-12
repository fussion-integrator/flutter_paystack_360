class CustomerCreationException implements Exception {
  final String message;
  CustomerCreationException(this.message);
  @override
  String toString() => 'CustomerCreationException: $message';
}

class CustomerListException implements Exception {
  final String message;
  CustomerListException(this.message);
  @override
  String toString() => 'CustomerListException: $message';
}

class CustomerFetchException implements Exception {
  final String message;
  CustomerFetchException(this.message);
  @override
  String toString() => 'CustomerFetchException: $message';
}

class CustomerUpdateException implements Exception {
  final String message;
  CustomerUpdateException(this.message);
  @override
  String toString() => 'CustomerUpdateException: $message';
}

class CustomerValidationException implements Exception {
  final String message;
  CustomerValidationException(this.message);
  @override
  String toString() => 'CustomerValidationException: $message';
}

class CustomerDeletionException implements Exception {
  final String message;
  CustomerDeletionException(this.message);
  @override
  String toString() => 'CustomerDeletionException: $message';
}
