// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:holiday_mobile/presentation/screens/activity/activity_screen.dart'
    as _i1;
import 'package:holiday_mobile/presentation/screens/activity/encode_activity.dart'
    as _i3;
import 'package:holiday_mobile/presentation/screens/authentification/login_page.dart'
    as _i9;
import 'package:holiday_mobile/presentation/screens/authentification/register_page.dart'
    as _i13;
import 'package:holiday_mobile/presentation/screens/chat/chat_page.dart' as _i2;
import 'package:holiday_mobile/presentation/screens/holiday/encode_holiday.dart'
    as _i4;
import 'package:holiday_mobile/presentation/screens/holiday/holidays_page.dart'
    as _i7;
import 'package:holiday_mobile/presentation/screens/holiday/my_holiday_screen.dart'
    as _i11;
import 'package:holiday_mobile/presentation/screens/invitation/invitations_screen.dart'
    as _i8;
import 'package:holiday_mobile/presentation/screens/maps/maps_screen.dart'
    as _i10;
import 'package:holiday_mobile/presentation/screens/participant/encode_participant_activity_screen.dart'
    as _i5;
import 'package:holiday_mobile/presentation/screens/participant/encode_participant_holiday_screen.dart'
    as _i6;
import 'package:holiday_mobile/presentation/screens/profile/profile_screen.dart'
    as _i12;
import 'package:holiday_mobile/presentation/screens/weather/weather_screen.dart'
    as _i14;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    ActivityRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ActivityRouteArgs>(
          orElse: () => ActivityRouteArgs(
                activityId: pathParams.getString('activityId'),
                holidayId: pathParams.getString('holidayId'),
              ));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ActivityScreen(
          key: args.key,
          activityId: args.activityId,
          holidayId: args.holidayId,
        ),
      );
    },
    ChatRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChatRouteArgs>(
          orElse: () =>
              ChatRouteArgs(holidayId: pathParams.getString('holidayId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ChatScreen(
          key: args.key,
          holidayId: args.holidayId,
        ),
      );
    },
    EncodeActivity.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.EncodeActivity(),
      );
    },
    EncodeHoliday.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.EncodeHoliday(),
      );
    },
    EncodeParticipantActivityRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EncodeParticipantActivityRouteArgs>(
          orElse: () => EncodeParticipantActivityRouteArgs(
              activityId: pathParams.getString('activityId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.EncodeParticipantActivityScreen(
          key: args.key,
          activityId: args.activityId,
        ),
      );
    },
    EncodeParticipantHolidayRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EncodeParticipantHolidayRouteArgs>(
          orElse: () => EncodeParticipantHolidayRouteArgs(
              holidayId: pathParams.getString('holidayId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.EncodeParticipantHolidayScreen(
          key: args.key,
          holidayId: args.holidayId,
        ),
      );
    },
    HolidaysRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HolidaysPage(),
      );
    },
    InvitationsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<InvitationsRouteArgs>(
          orElse: () => InvitationsRouteArgs(
              participantId: pathParams.getString('participantId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.InvitationsScreen(
          key: args.key,
          participantId: args.participantId,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.LoginPage(),
      );
    },
    MapRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MapRouteArgs>(
          orElse: () => MapRouteArgs(
                destinationLatitude:
                    pathParams.getDouble('destinationLatitude'),
                destinationLongitude:
                    pathParams.getDouble('destinationLongitude'),
              ));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.MapScreen(
          key: args.key,
          destinationLatitude: args.destinationLatitude,
          destinationLongitude: args.destinationLongitude,
        ),
      );
    },
    MyHolidayRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MyHolidayRouteArgs>(
          orElse: () =>
              MyHolidayRouteArgs(holidayId: pathParams.getString('holidayId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.MyHolidayPage(
          key: args.key,
          holidayId: args.holidayId,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ProfilePage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.RegisterPage(),
      );
    },
    WeatherRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<WeatherRouteArgs>(
          orElse: () =>
              WeatherRouteArgs(holidayId: pathParams.getString('holidayId')));
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.WeatherScreen(
          key: args.key,
          holidayId: args.holidayId,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ActivityScreen]
class ActivityRoute extends _i15.PageRouteInfo<ActivityRouteArgs> {
  ActivityRoute({
    _i16.Key? key,
    required String activityId,
    required String holidayId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ActivityRoute.name,
          args: ActivityRouteArgs(
            key: key,
            activityId: activityId,
            holidayId: holidayId,
          ),
          rawPathParams: {
            'activityId': activityId,
            'holidayId': holidayId,
          },
          initialChildren: children,
        );

  static const String name = 'ActivityRoute';

  static const _i15.PageInfo<ActivityRouteArgs> page =
      _i15.PageInfo<ActivityRouteArgs>(name);
}

class ActivityRouteArgs {
  const ActivityRouteArgs({
    this.key,
    required this.activityId,
    required this.holidayId,
  });

  final _i16.Key? key;

  final String activityId;

  final String holidayId;

  @override
  String toString() {
    return 'ActivityRouteArgs{key: $key, activityId: $activityId, holidayId: $holidayId}';
  }
}

/// generated route for
/// [_i2.ChatScreen]
class ChatRoute extends _i15.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i16.Key? key,
    required String holidayId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            holidayId: holidayId,
          ),
          rawPathParams: {'holidayId': holidayId},
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i15.PageInfo<ChatRouteArgs> page =
      _i15.PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.holidayId,
  });

  final _i16.Key? key;

  final String holidayId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, holidayId: $holidayId}';
  }
}

/// generated route for
/// [_i3.EncodeActivity]
class EncodeActivity extends _i15.PageRouteInfo<void> {
  const EncodeActivity({List<_i15.PageRouteInfo>? children})
      : super(
          EncodeActivity.name,
          initialChildren: children,
        );

  static const String name = 'EncodeActivity';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EncodeHoliday]
class EncodeHoliday extends _i15.PageRouteInfo<void> {
  const EncodeHoliday({List<_i15.PageRouteInfo>? children})
      : super(
          EncodeHoliday.name,
          initialChildren: children,
        );

  static const String name = 'EncodeHoliday';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EncodeParticipantActivityScreen]
class EncodeParticipantActivityRoute
    extends _i15.PageRouteInfo<EncodeParticipantActivityRouteArgs> {
  EncodeParticipantActivityRoute({
    _i16.Key? key,
    required String activityId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          EncodeParticipantActivityRoute.name,
          args: EncodeParticipantActivityRouteArgs(
            key: key,
            activityId: activityId,
          ),
          rawPathParams: {'activityId': activityId},
          initialChildren: children,
        );

  static const String name = 'EncodeParticipantActivityRoute';

  static const _i15.PageInfo<EncodeParticipantActivityRouteArgs> page =
      _i15.PageInfo<EncodeParticipantActivityRouteArgs>(name);
}

class EncodeParticipantActivityRouteArgs {
  const EncodeParticipantActivityRouteArgs({
    this.key,
    required this.activityId,
  });

  final _i16.Key? key;

  final String activityId;

  @override
  String toString() {
    return 'EncodeParticipantActivityRouteArgs{key: $key, activityId: $activityId}';
  }
}

/// generated route for
/// [_i6.EncodeParticipantHolidayScreen]
class EncodeParticipantHolidayRoute
    extends _i15.PageRouteInfo<EncodeParticipantHolidayRouteArgs> {
  EncodeParticipantHolidayRoute({
    _i16.Key? key,
    required String holidayId,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          EncodeParticipantHolidayRoute.name,
          args: EncodeParticipantHolidayRouteArgs(
            key: key,
            holidayId: holidayId,
          ),
          rawPathParams: {'holidayId': holidayId},
          initialChildren: children,
        );

  static const String name = 'EncodeParticipantHolidayRoute';

  static const _i15.PageInfo<EncodeParticipantHolidayRouteArgs> page =
      _i15.PageInfo<EncodeParticipantHolidayRouteArgs>(name);
}

class EncodeParticipantHolidayRouteArgs {
  const EncodeParticipantHolidayRouteArgs({
    this.key,
    required this.holidayId,
  });

  final _i16.Key? key;

  final String holidayId;

  @override
  String toString() {
    return 'EncodeParticipantHolidayRouteArgs{key: $key, holidayId: $holidayId}';
  }
}

/// generated route for
/// [_i7.HolidaysPage]
class HolidaysRoute extends _i15.PageRouteInfo<void> {
  const HolidaysRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HolidaysRoute.name,
          initialChildren: children,
        );

  static const String name = 'HolidaysRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.InvitationsScreen]
class InvitationsRoute extends _i15.PageRouteInfo<InvitationsRouteArgs> {
  InvitationsRoute({
    _i16.Key? key,
    required String participantId,
    List<_i15.PageRouteInfo>? children,
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

  static const _i15.PageInfo<InvitationsRouteArgs> page =
      _i15.PageInfo<InvitationsRouteArgs>(name);
}

class InvitationsRouteArgs {
  const InvitationsRouteArgs({
    this.key,
    required this.participantId,
  });

  final _i16.Key? key;

  final String participantId;

  @override
  String toString() {
    return 'InvitationsRouteArgs{key: $key, participantId: $participantId}';
  }
}

/// generated route for
/// [_i9.LoginPage]
class LoginRoute extends _i15.PageRouteInfo<void> {
  const LoginRoute({List<_i15.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.MapScreen]
class MapRoute extends _i15.PageRouteInfo<MapRouteArgs> {
  MapRoute({
    _i16.Key? key,
    required double destinationLatitude,
    required double destinationLongitude,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          MapRoute.name,
          args: MapRouteArgs(
            key: key,
            destinationLatitude: destinationLatitude,
            destinationLongitude: destinationLongitude,
          ),
          rawPathParams: {
            'destinationLatitude': destinationLatitude,
            'destinationLongitude': destinationLongitude,
          },
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const _i15.PageInfo<MapRouteArgs> page =
      _i15.PageInfo<MapRouteArgs>(name);
}

class MapRouteArgs {
  const MapRouteArgs({
    this.key,
    required this.destinationLatitude,
    required this.destinationLongitude,
  });

  final _i16.Key? key;

  final double destinationLatitude;

  final double destinationLongitude;

  @override
  String toString() {
    return 'MapRouteArgs{key: $key, destinationLatitude: $destinationLatitude, destinationLongitude: $destinationLongitude}';
  }
}

/// generated route for
/// [_i11.MyHolidayPage]
class MyHolidayRoute extends _i15.PageRouteInfo<MyHolidayRouteArgs> {
  MyHolidayRoute({
    _i16.Key? key,
    required String holidayId,
    List<_i15.PageRouteInfo>? children,
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

  static const _i15.PageInfo<MyHolidayRouteArgs> page =
      _i15.PageInfo<MyHolidayRouteArgs>(name);
}

class MyHolidayRouteArgs {
  const MyHolidayRouteArgs({
    this.key,
    required this.holidayId,
  });

  final _i16.Key? key;

  final String holidayId;

  @override
  String toString() {
    return 'MyHolidayRouteArgs{key: $key, holidayId: $holidayId}';
  }
}

/// generated route for
/// [_i12.ProfilePage]
class ProfileRoute extends _i15.PageRouteInfo<void> {
  const ProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i13.RegisterPage]
class RegisterRoute extends _i15.PageRouteInfo<void> {
  const RegisterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.WeatherScreen]
class WeatherRoute extends _i15.PageRouteInfo<WeatherRouteArgs> {
  WeatherRoute({
    _i16.Key? key,
    required String holidayId,
    List<_i15.PageRouteInfo>? children,
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

  static const _i15.PageInfo<WeatherRouteArgs> page =
      _i15.PageInfo<WeatherRouteArgs>(name);
}

class WeatherRouteArgs {
  const WeatherRouteArgs({
    this.key,
    required this.holidayId,
  });

  final _i16.Key? key;

  final String holidayId;

  @override
  String toString() {
    return 'WeatherRouteArgs{key: $key, holidayId: $holidayId}';
  }
}
