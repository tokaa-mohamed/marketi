import '../../inner_views/brands/domain/entities/brand_entity.dart';
import '../../inner_views/categories/domain/entities/category_entity.dart';
import 'home_entity.dart';
import 'product_entity.dart';

class HomeDummyData {
  static const homeData = HomeDataEntity(
    banners: [
      BannerEntity(id: 1, image: ''),
    ],
    categories: [
      CategoryEntity(id: 1, name: 'Loading...', image: '', description: '', productsCount: 0),
      CategoryEntity(id: 2, name: 'Loading...', image: '', description: '', productsCount: 0),
      CategoryEntity(id: 3, name: 'Loading...', image: '', description: '', productsCount: 0),
    ],
    popularProducts: [
      ProductEntity(id: 1, name: 'Product Name', price: 100, image: '', rating: 4.5, isFavorite: false),
      ProductEntity(id: 2, name: 'Product Name', price: 200, image: '', rating: 4.0, isFavorite: false),
    ],
    bestForYou: [
      ProductEntity(id: 1, name: 'Product Name', price: 100, image: '', rating: 4.5, isFavorite: false),
      ProductEntity(id: 2, name: 'Product Name', price: 200, image: '', rating: 4.0, isFavorite: false),
    ],
    buyAgain: [],
    brands: [
      BrandEntity(id: 1, name: 'Brand', image: '', productsCount: 0),
      BrandEntity(id: 2, name: 'Brand', image: '', productsCount: 0),
    ],
  );
}
