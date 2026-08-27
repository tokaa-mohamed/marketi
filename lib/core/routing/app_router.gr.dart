// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:marketi/features/auth/presentation/screens/create_new_password.dart'
    as _i1;
import 'package:marketi/features/auth/presentation/screens/forget_password.dart'
    as _i2;
import 'package:marketi/features/auth/presentation/screens/login_screen.dart'
    as _i3;
import 'package:marketi/features/auth/presentation/screens/onboarding_screen.dart'
    as _i4;
import 'package:marketi/features/auth/presentation/screens/password_success.dart'
    as _i5;
import 'package:marketi/features/auth/presentation/screens/register_screen.dart'
    as _i6;
import 'package:marketi/features/auth/presentation/screens/splash_screen.dart'
    as _i7;
import 'package:marketi/features/auth/presentation/screens/verify_otp.dart'
    as _i8;

/// generated route for
/// [_i1.CreateNewPasswordScreen]
class CreateNewPasswordRoute
    extends _i9.PageRouteInfo<CreateNewPasswordRouteArgs> {
  CreateNewPasswordRoute({
    _i10.Key? key,
    required String phone,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         CreateNewPasswordRoute.name,
         args: CreateNewPasswordRouteArgs(key: key, phone: phone),
         initialChildren: children,
       );

  static const String name = 'CreateNewPasswordRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateNewPasswordRouteArgs>();
      return _i1.CreateNewPasswordScreen(key: args.key, phone: args.phone);
    },
  );
}

class CreateNewPasswordRouteArgs {
  const CreateNewPasswordRouteArgs({this.key, required this.phone});

  final _i10.Key? key;

  final String phone;

  @override
  String toString() {
    return 'CreateNewPasswordRouteArgs{key: $key, phone: $phone}';
  }
}

/// generated route for
/// [_i2.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i9.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i9.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return _i9.WrappedRoute(child: const _i3.LoginScreen());
    },
  );
}

/// generated route for
/// [_i4.OnboardingScreen]
class OnboardingRoute extends _i9.PageRouteInfo<void> {
  const OnboardingRoute({List<_i9.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i5.PasswordSuccessScreen]
class PasswordSuccessRoute extends _i9.PageRouteInfo<void> {
  const PasswordSuccessRoute({List<_i9.PageRouteInfo>? children})
    : super(PasswordSuccessRoute.name, initialChildren: children);

  static const String name = 'PasswordSuccessRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.PasswordSuccessScreen();
    },
  );
}

/// generated route for
/// [_i6.RegisterScreen]
class RegisterRoute extends _i9.PageRouteInfo<void> {
  const RegisterRoute({List<_i9.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return _i9.WrappedRoute(child: const _i6.RegisterScreen());
    },
  );
}

/// generated route for
/// [_i7.SplashScreen]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashScreen();
    },
  );
}

/// generated route for
/// [_i8.VerifyOtpScreen]
class VerifyOtpRoute extends _i9.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i10.Key? key,
    String? targetDestination,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         VerifyOtpRoute.name,
         args: VerifyOtpRouteArgs(
           key: key,
           targetDestination: targetDestination,
         ),
         initialChildren: children,
       );

  static const String name = 'VerifyOtpRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerifyOtpRouteArgs>(
        orElse: () => const VerifyOtpRouteArgs(),
      );
      return _i8.VerifyOtpScreen(
        key: args.key,
        targetDestination: args.targetDestination,
      );
    },
  );
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({this.key, this.targetDestination});

  final _i10.Key? key;

  final String? targetDestination;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, targetDestination: $targetDestination}';
  }
}
