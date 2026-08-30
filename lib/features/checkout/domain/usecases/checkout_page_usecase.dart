import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';

import '../entities/checkout_page_entities.dart';
import '../repositories/checkout_page_repository.dart';

class CheckoutPageUsecase {
  final CheckoutPageRepository repository;

  CheckoutPageUsecase({required this.repository});

  Future<Either<Failure, CheckoutPageEntities>> call() async {
    return await repository.getDataOfCheckoutPage();
  }
}
