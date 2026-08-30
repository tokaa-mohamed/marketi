class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://marketi.newcinderella.online/api/v1/';
  static const String storageUrl = 'https://marketi.newcinderella.online/storage/';
  static const String marketiBaseUrl = 'https://marketi.newcinderella.online';

  // Auth Endpoints
  static const String registerEndpoint = '/register';
  static const String loginEndpoint = '/login';
  static const String forgotPasswordEndpoint = '/forgot-password';
  static const String verifyOtpEndpoint = '/verify-otp';
  static const String resetPasswordEndpoint = '/reset-password';
  static const String meEndpoint = '/me';
  static const String logoutEndpoint = '/logout';

  // Home & Catalog Endpoints
  static const String homeEndpoint = '/home';
  static const String searchEndpoint = '/search';
  static const String categoriesEndpoint = '/categories';
  static String categoryProductsEndpoint(int id) => '/categories/$id/products';
  static const String brandsEndpoint = '/brands';
  static const String productsEndpoint = '/products';
  static String productDetailsEndpoint(dynamic id) => '/products/$id';
  static String productRatingsEndpoint(dynamic id) => '/products/$id/ratings';
  static const String deliverySlotsEndpoint = '/delivery-slots';
  static const String faqsEndpoint = '/faqs';

  // Cart & Checkout Endpoints
  static const String cartEndpoint = '/cart';
  static const String cartItemsEndpoint = '/cart/items';
  static String updateCartItemEndpoint(int id) => '/cart/items/$id';
  static const String ordersEndpoint = '/orders';
  static String orderDetailsEndpoint(dynamic id) => '/orders/$id';
  static String cancelOrderEndpoint(dynamic id) => '/orders/$id/cancel';
  static String retryPaymentEndpoint(dynamic id) => '/orders/$id/payment/retry';

  // Payments Endpoints
  static const String paymentsEndpoint = '/payments';
  static String paymentDetailsEndpoint(dynamic id) => '/payments/$id';
  static String paypalSuccessEndpoint(dynamic id) => '/payments/paypal/success/$id';
  static const String paypalWebhookEndpoint = '/payments/paypal/webhook';
  static String mockCheckoutEndpoint(dynamic id) => '/payments/mock/$id/checkout';
  static String mockCompletePaymentEndpoint(dynamic id) => '/payments/mock/$id/complete';

  // Profile & Favorites Endpoints
  static const String profileEndpoint = '/profile';
  static const String profilePasswordEndpoint = '/profile/password';
  static const String favoritesEndpoint = '/favorites';

  // Support & Subscriptions Endpoints
  static const String subscriptionPlansEndpoint = '/subscription-plans';
  static const String subscriptionsEndpoint = '/subscriptions';
  static const String supportTicketsEndpoint = '/support/tickets';
  static const String notificationsEndpoint = '/notifications';

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

  // Legacy/Temp (If needed by some merged code)
  static const String KhamnyBaseUrl = baseUrl;
}
