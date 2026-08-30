import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/save%20data/save_data.dart';
import 'package:marketi/core/security/security_helper.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/features/profile/domain/repos/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit({required this.profileRepository}) : super(ProfileInitial());

  int cartItemsCount = 0;
  bool isNotificationsEnabled = true;
  bool isDarkModeEnabled = false;

  Future<void> fetchUserProfile() async {
    emit(ProfileLoading());
    final result = await profileRepository.getUserProfile();
    result.fold(
      (failureMessage) => emit(ProfileError(message: failureMessage)),
      (userProfile) => emit(ProfileLoaded(profile: userProfile)),
    );
  }

  Future<void> updateProfile({
    required String name,
    required String city,
  }) async {
    emit(ProfileLoading());
    final result = await profileRepository.updateProfile(name: name, city: city);
    result.fold(
      (failureMessage) => emit(ProfileError(message: failureMessage)),
      (_) {
        emit(ProfileUpdateSuccess());
        fetchUserProfile();
      },
    );
  }



// Future<void> updateProfileImage() async {
//   final ImagePicker picker = ImagePicker();
//   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  
//   if (image != null) {
//     emit(ProfileLoading());
//     // final result = await profileRepository.updateProfilePicture(image.path);
//     emit(ProfileUpdateSuccess());
//     fetchUserProfile();
//   }
// }

  Future<void> changePassword({
    required String currentPass,
    required String newPass,
  }) async {
    emit(ProfileLoading());
    final result = await profileRepository.changePassword(
      currentPassword: currentPass,
      newPassword: newPass,
    );
    result.fold(
      (failureMessage) => emit(ProfileError(message: failureMessage)),
      (_) => emit(ProfilePasswordChangedSuccess()),
    );
  }

  Future<void> loadOrders() async {
    emit(ProfileOrdersLoading());
    final result = await profileRepository.getOrders();
    result.fold(
      (failureMessage) => emit(ProfileError(message: failureMessage)),
      (orders) => emit(ProfileOrdersLoaded(orders: orders)),
    );
  }

  Future<void> loadSubscriptions() async {
    emit(ProfileSubscriptionsLoading());
    final result = await profileRepository.getSubscriptions();
    result.fold(
      (failureMessage) => emit(ProfileError(message: failureMessage)),
      (subscriptions) => emit(ProfileSubscriptionsLoaded(subscriptions: subscriptions)),
    );
  }

  Future<void> createSupportTicket({
    required String subject,
    required String message,
  }) async {
    emit(ProfileSupportTicketLoading());
    final result = await profileRepository.createSupportTicket(
      subject: subject,
      message: message,
    );
    result.fold(
      (failureMessage) => emit(ProfileError(message: failureMessage)),
      (_) => emit(ProfileSupportTicketCreated()),
    );
  }

  void toggleNotifications(bool value) {
    isNotificationsEnabled = value;
    emit(ProfileSettingsUpdated());
  }

  void toggleDarkMode(bool value) {
    isDarkModeEnabled = value;
    emit(ProfileSettingsUpdated());
  }

  void rateApp() {
    // InAppReview
  }

  Future<void> logout() async {
    emit(ProfileLoading());
    await getIt<CacheHelper>().removeData(key: 'token');
    getIt<AuthStorage>().token = null;
    getIt<AuthStorage>().userId = null;
    emit(ProfileLoggedOut());
  }
}