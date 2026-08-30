class OrderModel {
  final dynamic id;
  final String? status;
  final double? totalPrice;
  final String? createdAt;
  final int? itemsCount;

  OrderModel({
    this.id,
    this.status,
    this.totalPrice,
    this.createdAt,
    this.itemsCount,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      totalPrice: (json['total_price'] as num?)?.toDouble(),
      createdAt: json['created_at'],
      itemsCount: json['items_count'],
    );
  }
}