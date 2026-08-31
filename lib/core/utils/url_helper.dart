import '../constant/app_constants.dart';

class UrlHelper {
  static String getFullImageUrl(String? rawPath) {
    if (rawPath == null || rawPath.trim().isEmpty) {
      return '';
    }
    
    final trimmedPath = rawPath.trim();
    
    if (trimmedPath.startsWith('http')) {
      return trimmedPath;
    }
    
    // Ensure storageUrl ends with / and rawPath doesn't start with /
    final storageBase = AppConstants.storageUrl.endsWith('/') 
        ? AppConstants.storageUrl 
        : '${AppConstants.storageUrl}/';
        
    final sanitizedPath = trimmedPath.startsWith('/') 
        ? trimmedPath.substring(1) 
        : trimmedPath;
        
    return '$storageBase$sanitizedPath';
  }
}
