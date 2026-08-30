import 'package:dartz/dartz.dart';
import 'package:marketi/checkout_page/domain/entities/checkout_page_entities.dart';
import 'package:marketi/checkout_page/domain/repositories/checkout_page_repository.dart';
import 'package:marketi/core/errors/failure.dart';

class CheckoutPageUsecase {
  final CheckoutPageRepository repository;

  CheckoutPageUsecase({required this.repository});

  Future<Either<Failure, CheckoutPageEntities>> call() async {
    return await repository.getDataOfCheckoutPage();
  }
}
