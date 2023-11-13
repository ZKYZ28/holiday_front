// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:holiday_mobile/data/models/map_screen.dart' as _i10;
import 'package:holiday_mobile/presentation/screens/activity/activity_page.dart'
    as _i1;
import 'package:holiday_mobile/presentation/screens/activity/encode_activity.dart'
    as _i3;
import 'package:holiday_mobile/presentation/screens/authentification/login_page.dart'
    as _i9;
import 'package:holiday_mobile/presentation/screens/authentification/register_page.dart'
    as _i12;
import 'package:holiday_mobile/presentation/screens/chat/chat_page.dart' as _i2;
import 'package:holiday_mobile/presentation/screens/chat/list_holidays_chat.dart'
    as _i8;
import 'package:holiday_mobile/presentation/screens/holiday/encode_holiday.dart'
    as _i4;
import 'package:holiday_mobile/presentation/screens/holiday/holidays_page.dart'
    as _i6;
import 'package:holiday_mobile/presentation/screens/invitations_screen.dart'
    as _i7;
import 'package:holiday_mobile/presentation/screens/my_holiday_screen.dart'
    as _i11;
import 'package:holiday_mobile/presentation/screens/participant/EncodateParticipant.dart'
    as _i5;
import 'package:holiday_mobile/presentation/screens/weather_screen.dart'
    as _i13;

abstract class $AppRouter extends _i14.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    Activity.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.Activity(),
      );
    },
    ChatRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ChatPage(),
      );
    },
    EncodeActivity.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.EncodeActivity(),
      );
    },
    EncodeHoliday.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.EncodeHoliday(),
      );
    },
    EncodeParticipant.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EncodeParticipantArgs>(
          orElse: () => EncodeParticipantArgs(
              holidayId: pathParams.getString('holidayId')));
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.EncodeParticipant(
          key: args.key,
          holidayId: args.holidayId,
        ),
      );
    },
    HolidaysRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HolidaysPage(),
      );
    },
    InvitationsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<InvitationsRouteArgs>(
          orElse: () => InvitationsRouteArgs(
              participantId: pathParams.getString('participantId')));
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.InvitationsScreen(
          key: args.key,
          participantId: args.participantId,
        ),
      );
    },
    ListHolidaysChat.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ListHolidaysChat(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.LoginPage(),
      );
    },
    MapRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.MapScreen(),
      );
    },
    MyHolidayRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MyHolidayRouteArgs>(
          orElse: () =>
              MyHolidayRouteArgs(holidayId: pathParams.getString('holidayId')));
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.MyHolidayPage(
          key: args.key,
          holidayId: args.holidayId,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.RegisterPage(),
      );
    },
    WeatherRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<WeatherRouteArgs>(
          orElse: () =>
              WeatherRouteArgs(holidayId: pathParams.getString('holidayId')));
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.WeatherScreen(
          key: args.key,
          holidayId: args.holidayId,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.Activity]
class Activity extends _i14.PageRouteInfo<void> {
  const Activity({List<_i14.PageRouteInfo>? children})
      : super(
          Activity.name,
          initialChildren: children,
        );

  static const String name = 'Activity';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatPage]
class ChatRoute extends _i14.PageRouteInfo<void> {
  const ChatRoute({List<_i14.PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EncodeActivity]
class EncodeActivity extends _i14.PageRouteInfo<void> {
  const EncodeActivity({List<_i14.PageRouteInfo>? children})
      : super(
          EncodeActivity.name,
          initialChildren: children,
        );

  static const String name = 'EncodeActivity';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EncodeHoliday]
class EncodeHoliday extends _i14.PageRouteInfo<void> {
  const EncodeHoliday({List<_i14.PageRouteInfo>? children})
      : super(
          EncodeHoliday.name,
          initialChildren: children,
        );

  static const String name = 'EncodeHoliday';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EncodeParticipant]
class EncodeParticipant extends _i14.PageRouteInfo<EncodeParticipantArgs> {
  EncodeParticipant({
    _i15.Key? key,
    required String holidayId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          EncodeParticipant.name,
          args: EncodeParticipantArgs(
            key: key,
            holidayId: holidayId,
          ),
          rawPathParams: {'holidayId': holidayId},
          initialChildren: children,
        );

  static const String name = 'EncodeParticipant';

  static const _i14.PageInfo<EncodeParticipantArgs> page =
      _i14.PageInfo<EncodeParticipantArgs>(name);
}

class EncodeParticipantArgs {
  const EncodeParticipantArgs({
    this.key,
    required this.holidayId,
  });

  final _i15.Key? key;

  final String holidayId;

  @override
  String toString() {
    return 'EncodeParticipantArgs{key: $key, holidayId: $holidayId}';
  }
}

/// generated route for
/// [_i6.HolidaysPage]
class HolidaysRoute extends _i14.PageRouteInfo<void> {
  const HolidaysRoute({List<_i14.PageRouteInfo>? children})
      : super(
          HolidaysRoute.name,
          initialChildren: children,
        );

  static const String name = 'HolidaysRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i7.InvitationsScreen]
class InvitationsRoute extends _i14.PageRouteInfo<InvitationsRouteArgs> {
  InvitationsRoute({
    _i15.Key? key,
    required String participantId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          InvitationsRoute.name,
          args: InvitationsRouteArgs(
            key: key,
            participantId: participantId,
          ),
          rawPathParams: {'participantId': participantId},
          initialChildren: children,
        );

  static const String name = 'InvitationsRoute';

  static const _i14.PageInfo<InvitationsRouteArgs> page =
      _i14.PageInfo<InvitationsRouteArgs>(name);
}

class InvitationsRouteArgs {
  const InvitationsRouteArgs({
    this.key,
    required this.participantId,
  });

  final _i15.Key? key;

  final String participantId;

  @override
  String toString() {
    return 'InvitationsRouteArgs{key: $key, participantId: $participantId}';
  }
}

/// generated route for
/// [_i8.ListHolidaysChat]
class ListHolidaysChat extends _i14.PageRouteInfo<void> {
  const ListHolidaysChat({List<_i14.PageRouteInfo>? children})
      : super(
          ListHolidaysChat.name,
          initialChildren: children,
        );

  static const String name = 'ListHolidaysChat';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i9.LoginPage]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i10.MapScreen]
class MapRoute extends _i14.PageRouteInfo<void> {
  const MapRoute({List<_i14.PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i11.MyHolidayPage]
class MyHolidayRoute extends _i14.PageRouteInfo<MyHolidayRouteArgs> {
  MyHolidayRoute({
    _i15.Key? key,
    required String holidayId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          MyHolidayRoute.name,
          args: MyHolidayRouteArgs(
            key: key,
            holidayId: holidayId,
          ),
          rawPathParams: {'holidayId': holidayId},
          initialChildren: children,
        );

  static const String name = 'MyHolidayRoute';

  static const _i14.PageInfo<MyHolidayRouteArgs> page =
      _i14.PageInfo<MyHolidayRouteArgs>(name);
}

class MyHolidayRouteArgs {
  const MyHolidayRouteArgs({
    this.key,
    required this.holidayId,
  });

  final _i15.Key? key;

  final String holidayId;

  @override
  String toString() {
    return 'MyHolidayRouteArgs{key: $key, holidayId: $holidayId}';
  }
}

/// generated route for
/// [_i12.RegisterPage]
class RegisterRoute extends _i14.PageRouteInfo<void> {
  const RegisterRoute({List<_i14.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i13.WeatherScreen]
class WeatherRoute extends _i14.PageRouteInfo<WeatherRouteArgs> {
  WeatherRoute({
    _i15.Key? key,
    required String holidayId,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          WeatherRoute.name,
          args: WeatherRouteArgs(
            key: key,
            holidayId: holidayId,
          ),
          rawPathParams: {'holidayId': holidayId},
          initialChildren: children,
        );

  static const String name = 'WeatherRoute';

  static const _i14.PageInfo<WeatherRouteArgs> page =
      _i14.PageInfo<WeatherRouteArgs>(name);
}

class WeatherRouteArgs {
  const WeatherRouteArgs({
    this.key,
    required this.holidayId,
  });

  final _i15.Key? key;

  final String holidayId;

  @override
  String toString() {
    return 'WeatherRouteArgs{key: $key, holidayId: $holidayId}';
  }
}
