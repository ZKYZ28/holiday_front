import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';


//flutter pub run build_runner build
@AutoRouterConfig()
class AppRouter extends $AppRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HolidaysRoute.page),
    AutoRoute(page: EncodeHoliday.page),
    AutoRoute(page: ChatRoute.page),
    AutoRoute(page: EncodeParticipantHolidayRoute.page),
    AutoRoute(page: EncodeParticipantActivityRoute.page),
    AutoRoute(page: MyHolidayRoute.page),
    AutoRoute(page: WeatherRoute.page),
    AutoRoute(page: InvitationsRoute.page),
    AutoRoute(page: ActivityRoute.page),
    AutoRoute(page: MapRoute.page),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: ChatRoute.page),
  ];
}