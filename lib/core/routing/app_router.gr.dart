// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:marketi/features/auth/presentation/screens/create_new_password.dart'
    as _i2;
import 'package:marketi/features/auth/presentation/screens/forget_password.dart'
    as _i3;
import 'package:marketi/features/auth/presentation/screens/login_screen.dart'
    as _i4;
import 'package:marketi/features/auth/presentation/screens/onboarding_screen.dart'
    as _i5;
import 'package:marketi/features/auth/presentation/screens/password_success.dart'
    as _i6;
import 'package:marketi/features/auth/presentation/screens/register_screen.dart'
    as _i9;
import 'package:marketi/features/auth/presentation/screens/splash_screen.dart'
    as _i10;
import 'package:marketi/features/auth/presentation/screens/verify_otp.dart'
    as _i13;
import 'package:marketi/features/profile/presentation/screens/profile_screen.dart'
    as _i8;
import 'package:marketi/features/profile/presentation/widgets/account_prefrence_screen.dart'
    as _i1;
import 'package:marketi/features/profile/presentation/widgets/profile_drawer.dart'
    as _i7;
import 'package:marketi/features/profile/presentation/widgets/subscription_payment_screen.dart'
    as _i11;
import 'package:marketi/features/profile/presentation/widgets/support_screen.dart'
    as _i12;

/// generated route for
/// [_i1.AccountPreferencesScreen]
class AccountPreferencesRoute extends _i14.PageRouteInfo<void> {
  const AccountPreferencesRoute({List<_i14.PageRouteInfo>? children})
    : super(AccountPreferencesRoute.name, initialChildren: children);

  static const String name = 'AccountPreferencesRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountPreferencesScreen();
    },
  );
}

/// generated route for
/// [_i2.CreateNewPasswordScreen]
class CreateNewPasswordRoute
    extends _i14.PageRouteInfo<CreateNewPasswordRouteArgs> {
  CreateNewPasswordRoute({
    _i15.Key? key,
    required String phone,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         CreateNewPasswordRoute.name,
         args: CreateNewPasswordRouteArgs(key: key, phone: phone),
         initialChildren: children,
       );

  static const String name = 'CreateNewPasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateNewPasswordRouteArgs>();
      return _i2.CreateNewPasswordScreen(key: args.key, phone: args.phone);
    },
  );
}

class CreateNewPasswordRouteArgs {
  const CreateNewPasswordRouteArgs({this.key, required this.phone});

  final _i15.Key? key;

  final String phone;

  @override
  String toString() {
    return 'CreateNewPasswordRouteArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i3.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i14.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i14.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i3.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return _i14.WrappedRoute(child: const _i4.LoginScreen());
    },
  );
}

/// generated route for
/// [_i5.OnboardingScreen]
class OnboardingRoute extends _i14.PageRouteInfo<void> {
  const OnboardingRoute({List<_i14.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i6.PasswordSuccessScreen]
class PasswordSuccessRoute extends _i14.PageRouteInfo<void> {
  const PasswordSuccessRoute({List<_i14.PageRouteInfo>? children})
    : super(PasswordSuccessRoute.name, initialChildren: children);

  static const String name = 'PasswordSuccessRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.PasswordSuccessScreen();
    },
  );
}

/// generated route for
/// [_i7.ProfileDrawerScreen]
class ProfileDrawerRoute extends _i14.PageRouteInfo<void> {
  const ProfileDrawerRoute({List<_i14.PageRouteInfo>? children})
    : super(ProfileDrawerRoute.name, initialChildren: children);

  static const String name = 'ProfileDrawerRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProfileDrawerScreen();
    },
  );
}

/// generated route for
/// [_i8.ProfileScreen]
class ProfileRoute extends _i14.PageRouteInfo<void> {
  const ProfileRoute({List<_i14.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i9.RegisterScreen]
class RegisterRoute extends _i14.PageRouteInfo<void> {
  const RegisterRoute({List<_i14.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return _i14.WrappedRoute(child: const _i9.RegisterScreen());
    },
  );
}

/// generated route for
/// [_i10.SplashScreen]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute({List<_i14.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i10.SplashScreen();
    },
  );
}

/// generated route for
/// [_i11.SubscriptionAndPaymentScreen]
class SubscriptionAndPaymentRoute extends _i14.PageRouteInfo<void> {
  const SubscriptionAndPaymentRoute({List<_i14.PageRouteInfo>? children})
    : super(SubscriptionAndPaymentRoute.name, initialChildren: children);

  static const String name = 'SubscriptionAndPaymentRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.SubscriptionAndPaymentScreen();
    },
  );
}

/// generated route for
/// [_i12.SupportScreen]
class SupportRoute extends _i14.PageRouteInfo<void> {
  const SupportRoute({List<_i14.PageRouteInfo>? children})
    : super(SupportRoute.name, initialChildren: children);

  static const String name = 'SupportRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i12.SupportScreen();
    },
  );
}

/// generated route for
/// [_i13.VerifyOtpScreen]
class VerifyOtpRoute extends _i14.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i15.Key? key,
    String? targetDestination,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         VerifyOtpRoute.name,
         args: VerifyOtpRouteArgs(
           key: key,
           targetDestination: targetDestination,
         ),
         initialChildren: children,
       );

  static const String name = 'VerifyOtpRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerifyOtpRouteArgs>(
        orElse: () => const VerifyOtpRouteArgs(),
      );
      return _i13.VerifyOtpScreen(
        key: args.key,
        targetDestination: args.targetDestination,
      );
    },
  );
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({this.key, this.targetDestination});

  final _i15.Key? key;

  final String? targetDestination;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, targetDestination: $targetDestination}';
  }
}
