import 'package:marketi/features/profile/data/models/order_model.dart';
import 'package:marketi/features/profile/data/models/subscription_model.dart';
import 'package:marketi/features/profile/domain/entities/user_profile.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

// Profile Fetching States
class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;
  const ProfileLoaded({required this.profile});
}

typedef ProfileSuccess = ProfileLoaded;

// Update & Auth States
class ProfileUpdateSuccess extends ProfileState {}

class ProfilePasswordChangedSuccess extends ProfileState {}

class ProfileSettingsUpdated extends ProfileState {}

class ProfileLoggedOut extends ProfileState {}

// Orders States
class ProfileOrdersLoading extends ProfileState {}

class ProfileOrdersLoaded extends ProfileState {
  final List<OrderModel> orders;
  const ProfileOrdersLoaded({required this.orders});
}

// Subscriptions States
class ProfileSubscriptionsLoading extends ProfileState {}

class ProfileSubscriptionsLoaded extends ProfileState {
  final List<SubscriptionModel> subscriptions;
  const ProfileSubscriptionsLoaded({required this.subscriptions});
}

// Support Ticket States
class ProfileSupportTicketLoading extends ProfileState {}

class ProfileSupportTicketCreated extends ProfileState {}

// General Error State
class ProfileError extends ProfileState {
  final String message;
  const ProfileError({required this.message});
}