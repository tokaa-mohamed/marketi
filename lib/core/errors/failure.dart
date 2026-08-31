abstract class Failure {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => '$runtimeType(message: $message)';
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message});
}

class ServiceFailure extends Failure {
  const ServiceFailure({required super.message});
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({required super.message});
}

class ServerException extends Failure {
  const ServerException(String message) : super(message: message);
}

class CacheException extends Failure {
  const CacheException(String message) : super(message: message);
}

class ValidationException extends Failure {
  const ValidationException(String message) : super(message: message);
}

class AuthenticationException extends Failure {
  const AuthenticationException(String message) : super(message: message);
}

class ProductNotFoundException extends Failure {
  const ProductNotFoundException(String message) : super(message: message);
}

class CategoryNotFoundException extends Failure {
  const CategoryNotFoundException(String message) : super(message: message);
}

class OrderNotFoundException extends Failure {
  const OrderNotFoundException(String message) : super(message: message);
}

class PageNotFoundException extends Failure {
  const PageNotFoundException(String message) : super(message: message);
}
