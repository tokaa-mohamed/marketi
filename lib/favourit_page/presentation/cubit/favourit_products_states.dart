import 'package:marketi/favourit_page/domain/entities/favourit_products_entities.dart';

class FavouritProductsStates {}

class FavouritProductsInitialState extends FavouritProductsStates {}

class GetFavouritProductsLoadingState extends FavouritProductsStates {}

class GetFavouritPProductsSuccessfulState extends FavouritProductsStates {
  final List<FavouritProductsEntities> favouritProducts;

  GetFavouritPProductsSuccessfulState({required this.favouritProducts});
}

class FailGetFavouritProducts extends FavouritProductsStates {
  final String message;

  FailGetFavouritProducts({required this.message});
}
