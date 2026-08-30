import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';

import '../entities/checkout_page_entities.dart';

abstract class CheckoutPageRepository {
  Future<Either<Failure, CheckoutPageEntities>> getDataOfCheckoutPage();

  Future<Either<Failure, void>> placeOrder({
    required CheckoutPageEntities checkoutData,
    String? voucherCode,
  });
}
