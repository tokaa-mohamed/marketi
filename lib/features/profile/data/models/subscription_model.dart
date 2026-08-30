class SubscriptionModel {
  final int? id;
  final String? planName;
  final String? planType; 
  
  final String? status;
  final String? price;
  final String? renewalDate;

  SubscriptionModel({
    this.id,
    this.planName,
    this.planType,
    this.status,
    this.price,
    this.renewalDate,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'],
      planName: json['plan_name'],
      planType: json['plan_type'], 
            status: json['status'],
      price: json['price']?.toString(),
      renewalDate: json['renewal_date'],
    );
  }
}