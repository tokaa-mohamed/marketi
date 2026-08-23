class AppConstants {
  // API Configuration
  static const String marketiBaseUrl = 'https://marketi.newcinderella.online';
  static const String _apiV1 = '/api/v1';

  // Auth Endpoints
  static const String registerEndpoint = '$_apiV1/register';
  static const String loginEndpoint = '$_apiV1/login';
  static const String forgotPasswordEndpoint = '$_apiV1/forgot-password';
  static const String verifyOtpEndpoint = '$_apiV1/verify-otp';
  static const String resetPasswordEndpoint = '$_apiV1/reset-password';
  static const String meEndpoint = '$_apiV1/me';
  static const String logoutEndpoint = '$_apiV1/logout';

  // Home & Catalog Endpoints
  static const String homeEndpoint = '$_apiV1/home';
  static const String searchEndpoint = '$_apiV1/search';
  static const String categoriesEndpoint = '$_apiV1/categories';
  static String categoryProductsEndpoint(int categoryId) =>
      '$_apiV1/categories/$categoryId/products';
  static const String brandsEndpoint = '$_apiV1/brands';
  static const String productsEndpoint = '$_apiV1/products';
  static String productDetailsEndpoint(dynamic id) => '$_apiV1/products/$id';
  static String productRatingsEndpoint(dynamic id) => '$_apiV1/products/$id/ratings';
  static const String deliverySlotsEndpoint = '$_apiV1/delivery-slots';
  static const String faqsEndpoint = '$_apiV1/faqs';

  // Cart & Checkout Endpoints
  static const String cartEndpoint = '$_apiV1/cart';
  static const String cartItemsEndpoint = '$_apiV1/cart/items';
  static String updateCartItemEndpoint(int itemId) => '$_apiV1/cart/items/$itemId';
  static const String ordersEndpoint = '$_apiV1/orders';
  static String retryPaymentEndpoint(dynamic orderId) =>
      '$_apiV1/orders/$orderId/payment/retry';
  static String orderDetailsEndpoint(dynamic orderId) => '$_apiV1/orders/$orderId';
  static String cancelOrderEndpoint(dynamic orderId) =>
      '$_apiV1/orders/$orderId/cancel';

  // Payments Endpoints
  static const String paymentsEndpoint = '$_apiV1/payments';
  static String paymentDetailsEndpoint(dynamic paymentId) =>
      '$_apiV1/payments/$paymentId';
  static String paypalSuccessEndpoint(dynamic paymentId) =>
      '$_apiV1/payments/paypal/success/$paymentId';
  static const String paypalWebhookEndpoint = '$_apiV1/payments/paypal/webhook';
  static String mockCheckoutEndpoint(dynamic paymentId) =>
      '$_apiV1/payments/mock/$paymentId/checkout';
  static String mockCompletePaymentEndpoint(dynamic paymentId) =>
      '$_apiV1/payments/mock/$paymentId/complete';

  // Profile & Favorites Endpoints
  static const String profileEndpoint = '$_apiV1/profile';
  static const String profilePasswordEndpoint = '$_apiV1/profile/password';
  static const String favoritesEndpoint = '$_apiV1/favorites';

  // Support & Subscriptions Endpoints
  static const String subscriptionPlansEndpoint = '$_apiV1/subscription-plans';
  static const String subscriptionsEndpoint = '$_apiV1/subscriptions';
  static const String supportTicketsEndpoint = '$_apiV1/support/tickets';
  static const String notificationsEndpoint = '$_apiV1/notifications';

  // Admin Endpoints
  static const String adminDashboardEndpoint = '$_apiV1/admin/dashboard';
  static const String adminUsersEndpoint = '$_apiV1/admin/users';
  static const String adminCategoriesEndpoint = '$_apiV1/admin/categories';
  static const String adminProductsEndpoint = '$_apiV1/admin/products';
  static const String adminOrdersEndpoint = '$_apiV1/admin/orders';
  static String adminUpdateOrderStatusEndpoint(dynamic orderId) =>
      '$_apiV1/admin/orders/$orderId/status';
  static const String adminPaymentsRevenueEndpoint = '$_apiV1/admin/payments/revenue';
  static const String adminNotificationsEndpoint = '$_apiV1/admin/notifications';
  static const String adminSupportTicketsEndpoint = '$_apiV1/admin/support/tickets';

  // Languages
  static const String arabicLangCode = 'ar';
  static const String englishLangCode = 'en';

  static const String lastAuthProviderCacheKey = 'last_auth_provider';

  // Design System Constants
  static const double defaultRadius = 14.0;
  static const double defaultButtonHeight = 48.0;

  // Error Messages
  static const String networkErrorMessage = 'خطأ في الشبكة';
  static const String serverErrorMessage = 'خطأ في الخادم';
  static const String cacheErrorMessage = 'خطأ في التخزين المؤقت';
  static const String unknownErrorMessage = 'خطأ غير معروف';
  static const String timeoutErrorMessage = 'انتهت مهلة الاتصال';
  static const String requestCancelledMessage = 'تم إلغاء الطلب';
  static const String noInternetMessage = 'لا يوجد اتصال بالإنترنت';
  static const String badCertificateMessage = 'شهادة غير صالحة';

  // Success Messages
  static const String productAddedToCart = 'تمت إضافة المنتج إلى السلة بنجاح';
  static const String orderPlacedSuccessfully = 'تم تأكيد الطلب بنجاح';
  static const String dataLoadedSuccessfully = 'تم تحميل البيانات بنجاح';
}