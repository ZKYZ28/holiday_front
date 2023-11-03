// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:holiday_mobile/presentation/screens/activity_page.dart' as _i1;
import 'package:holiday_mobile/presentation/screens/chat_page.dart' as _i2;
import 'package:holiday_mobile/presentation/screens/encode_activity.dart'
    as _i3;
import 'package:holiday_mobile/presentation/screens/encode_holiday.dart' as _i4;
import 'package:holiday_mobile/presentation/screens/holidays_page.dart' as _i5;
import 'package:holiday_mobile/presentation/screens/list_holidays_chat.dart'
    as _i6;
import 'package:holiday_mobile/presentation/screens/login_page.dart' as _i7;
import 'package:holiday_mobile/presentation/screens/register_page.dart' as _i8;

abstract class $AppRouter extends _i9.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    Activity.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.Activity(),
      );
    },
    ChatRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ChatPage(),
      );
    },
    EncodeActivity.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.EncodeActivity(),
      );
    },
    EncodeHolidayRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.EncodeHoliday(),
      );
    },
    HolidaysRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HolidaysPage(),
      );
    },
    ListHolidaysChatRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ListHolidaysChat(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i9.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.RegisterPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.Activity]
class Activity extends _i9.PageRouteInfo<void> {
  const Activity({List<_i9.PageRouteInfo>? children})
      : super(
          Activity.name,
          initialChildren: children,
        );

  static const String name = 'Activity';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatPage]
class ChatRoute extends _i9.PageRouteInfo<void> {
  const ChatRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EncodeActivity]
class EncodeActivity extends _i9.PageRouteInfo<void> {
  const EncodeActivity({List<_i9.PageRouteInfo>? children})
      : super(
          EncodeActivity.name,
          initialChildren: children,
        );

  static const String name = 'EncodeActivity';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EncodeHoliday]
class EncodeHolidayRoute extends _i9.PageRouteInfo<void> {
  const EncodeHolidayRoute({List<_i9.PageRouteInfo>? children})
      : super(
          EncodeHolidayRoute.name,
          initialChildren: children,
        );

  static const String name = 'EncodeHoliday';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HolidaysPage]
class HolidaysRoute extends _i9.PageRouteInfo<void> {
  const HolidaysRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HolidaysRoute.name,
          initialChildren: children,
        );

  static const String name = 'HolidaysRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ListHolidaysChat]
class ListHolidaysChatRoute extends _i9.PageRouteInfo<void> {
  const ListHolidaysChatRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ListHolidaysChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListHolidaysChat';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute({List<_i9.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}

/// generated route for
/// [_i8.RegisterPage]
class RegisterRoute extends _i9.PageRouteInfo<void> {
  const RegisterRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i9.PageInfo<void> page = _i9.PageInfo<void>(name);
}
