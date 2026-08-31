import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/save%20data/save_data.dart';
import 'package:marketi/core/security/security_helper.dart';

import '../../domain/usecases/get_favourit_products.dart';
import '../../domain/usecases/add_favorite_usecase.dart';
import '../../data/models/favourit_products_model.dart';
import 'favourit_products_states.dart';

class FavouritProductsCubit extends Cubit<FavouritProductsStates> {
  final GetFavouritProductsUseCase getFavouritProductsUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final AuthStorage authStorage;
  final CacheHelper cacheHelper;

  FavouritProductsCubit(this.getFavouritProductsUseCase, this.addFavoriteUseCase,
      this.authStorage, this.cacheHelper)
      : super(FavouritProductsInitialState());

  Set<int> favoritesIds = {};

  Future<void> init() async {
    await _loadFavoritesFromCache();
    if (authStorage.token != null) {
      await getFavouritProducts();
    }
  }

  Future<void> _loadFavoritesFromCache() async {
    final List<String>? cached = cacheHelper.getStringList(key: 'favorites_ids');
    if (cached != null) {
      favoritesIds = cached.map((e) => int.parse(e)).toSet();
    }
  }

  Future<void> _saveFavoritesToCache() async {
    await cacheHelper.setStringList(
      key: 'favorites_ids',
      value: favoritesIds.map((e) => e.toString()).toList(),
    );
  }

  Future<void> getFavouritProducts() async {
    emit(GetFavouritProductsLoadingState());

    final result = await getFavouritProductsUseCase.callFavouritProducts();

    result.fold(
      (failure) {
        emit(FailGetFavouritProducts(message: failure.message));
      },
      (favouritProducts) {
        // Update local set from server list using the actual productId
        favoritesIds = favouritProducts
            .whereType<FavouritProductsModel>()
            .map((e) => e.productId)
            .toSet();
        _saveFavoritesToCache();

        emit(
          GetFavouritPProductsSuccessfulState(
            favouritProducts: favouritProducts,
          ),
        );
      },
    );
  }

  Future<void> addFavorite(int productId) async {
    if (authStorage.token == null || authStorage.token!.isEmpty) {
      emit(AddFavoriteErrorState(message: "AuthRequired"));
      return;
    }

    // Optimistic UI update
    final bool isRemoving = favoritesIds.contains(productId);
    if (isRemoving) {
      favoritesIds.remove(productId);
    } else {
      favoritesIds.add(productId);
    }
    _saveFavoritesToCache();
    emit(FavouritProductsInitialState()); // Trigger UI rebuild

    emit(AddFavoriteLoadingState());

    final result = await addFavoriteUseCase(productId);

    result.fold(
      (failure) {
        // Rollback on failure
        if (isRemoving) {
          favoritesIds.add(productId);
        } else {
          favoritesIds.remove(productId);
        }
        _saveFavoritesToCache();
        emit(AddFavoriteErrorState(message: failure.message));
      },
      (successMessage) {
        emit(AddFavoriteSuccessState(message: successMessage));
        // Refresh from server to keep sync
        getFavouritProducts();
      },
    );
  }

  bool isFavorite(int productId) {
    return favoritesIds.contains(productId);
  }
}
