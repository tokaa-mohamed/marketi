class CartProductsEntities {
  final String name;
  final double price;
  final int stock_quantity;
  final double rating;
  final String main_image;
  final String main_image_url;

  CartProductsEntities(
      {required this.name,
      required this.price,
      required this.stock_quantity,
      required this.rating,
      required this.main_image,
      required this.main_image_url});
}
