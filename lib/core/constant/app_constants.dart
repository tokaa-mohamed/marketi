class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://marketi.newcinderella.online/api/v1/';
  static const String storageUrl =
      'https://marketi.newcinderella.online/storage/';

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

  static String productDetailsEndpoint(int id) => '/products/$id';

  static String productRatingsEndpoint(int id) => '/products/$id/ratings';

  // Cart & Checkout Endpoints
  static const String cartEndpoint = '/cart';
  static const String cartItemsEndpoint = '/cart/items';

  static String updateCartItemEndpoint(int id) => '/cart/items/$id';
  static const String ordersEndpoint = '/orders';

  static String orderDetailsEndpoint(int id) => '/orders/$id';

  static String cancelOrderEndpoint(int id) => '/orders/$id/cancel';

  static String retryPaymentEndpoint(int id) => '/orders/$id/payment/retry';

  // Profile & Favorites Endpoints
  static const String profileEndpoint = '/profile';
  static const String changePasswordEndpoint = '/profile/password';
  static const String favoritesEndpoint = '/favorites';

  // Support & Others
  static const String subscriptionPlansEndpoint = '/subscription-plans';
  static const String mySubscriptionsEndpoint = '/subscriptions';
  static const String supportTicketsEndpoint = '/support/tickets';
  static const String notificationsEndpoint = '/notifications';
  static const String faqsEndpoint = '/faqs';
  static const String deliverySlotsEndpoint = '/delivery-slots';

  // Language Constants
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
