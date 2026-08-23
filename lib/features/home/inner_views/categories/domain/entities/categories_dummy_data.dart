import 'category_entity.dart';

class CategoriesDummyData {
  static final categories = List.generate(
    6,
    (index) => CategoryEntity(
      id: index,
      name: 'Category Name',
      image: '',
      description: 'Description',
      productsCount: 10,
    ),
  );
}
