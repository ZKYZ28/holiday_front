// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:holiday_mobile/presentation/screens/activity/activity_page.dart'
    as _i1;
import 'package:holiday_mobile/presentation/screens/activity/encode_activity.dart'
    as _i3;
import 'package:holiday_mobile/presentation/screens/authentification/login_page.dart'
    as _i8;
import 'package:holiday_mobile/presentation/screens/authentification/register_page.dart'
    as _i10;
import 'package:holiday_mobile/presentation/screens/chat/chat_page.dart' as _i2;
import 'package:holiday_mobile/presentation/screens/chat/list_holidays_chat.dart'
    as _i7;
import 'package:holiday_mobile/presentation/screens/holiday/encode_holiday.dart'
    as _i4;
import 'package:holiday_mobile/presentation/screens/holiday/holidays_page.dart'
    as _i6;
import 'package:holiday_mobile/presentation/screens/holiday/myholiday_screen.dart'
    as _i9;
import 'package:holiday_mobile/presentation/screens/participant/EncodateParticipant.dart'
    as _i5;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    Activity.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.Activity(),
      );
    },
    ChatRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ChatPage(),
      );
    },
    EncodeActivity.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.EncodeActivity(),
      );
    },
    EncodeHoliday.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.EncodeHoliday(),
      );
    },
    EncodeParticipant.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.EncodeParticipant(),
      );
    },
    HolidaysRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HolidaysPage(),
      );
    },
    ListHolidaysChat.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ListHolidaysChat(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LoginPage(),
      );
    },
    MyHolidayRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.MyHolidayPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.RegisterPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.Activity]
class Activity extends _i11.PageRouteInfo<void> {
  const Activity({List<_i11.PageRouteInfo>? children})
      : super(
          Activity.name,
          initialChildren: children,
        );

  static const String name = 'Activity';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatPage]
class ChatRoute extends _i11.PageRouteInfo<void> {
  const ChatRoute({List<_i11.PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EncodeActivity]
class EncodeActivity extends _i11.PageRouteInfo<void> {
  const EncodeActivity({List<_i11.PageRouteInfo>? children})
      : super(
          EncodeActivity.name,
          initialChildren: children,
        );

  static const String name = 'EncodeActivity';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EncodeHoliday]
class EncodeHoliday extends _i11.PageRouteInfo<void> {
  const EncodeHoliday({List<_i11.PageRouteInfo>? children})
      : super(
          EncodeHoliday.name,
          initialChildren: children,
        );

  static const String name = 'EncodeHoliday';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EncodeParticipant]
class EncodeParticipant extends _i11.PageRouteInfo<void> {
  const EncodeParticipant({List<_i11.PageRouteInfo>? children})
      : super(
          EncodeParticipant.name,
          initialChildren: children,
        );

  static const String name = 'EncodeParticipant';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HolidaysPage]
class HolidaysRoute extends _i11.PageRouteInfo<void> {
  const HolidaysRoute({List<_i11.PageRouteInfo>? children})
      : super(
          HolidaysRoute.name,
          initialChildren: children,
        );

  static const String name = 'HolidaysRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ListHolidaysChat]
class ListHolidaysChat extends _i11.PageRouteInfo<void> {
  const ListHolidaysChat({List<_i11.PageRouteInfo>? children})
      : super(
          ListHolidaysChat.name,
          initialChildren: children,
        );

  static const String name = 'ListHolidaysChat';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.MyHolidayPage]
class MyHolidayRoute extends _i11.PageRouteInfo<void> {
  const MyHolidayRoute({List<_i11.PageRouteInfo>? children})
      : super(
          MyHolidayRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHolidayRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i10.RegisterPage]
class RegisterRoute extends _i11.PageRouteInfo<void> {
  const RegisterRoute({List<_i11.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
