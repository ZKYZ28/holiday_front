import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';


//flutter pub run build_runner build
@AutoRouterConfig()
class AppRouter extends $AppRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: HolidaysRoute.page),
    AutoRoute(page: EncodeHoliday.page),
    AutoRoute(page: ListHolidaysChat.page),
    AutoRoute(page: ChatRoute.page),
    AutoRoute(page: EncodeParticipant.page),
    AutoRoute(page: MyHolidayRoute.page),
    AutoRoute(page: WeatherRoute.page),
    AutoRoute(page: InvitationsRoute.page),
    AutoRoute(page: MapRoute.page),
    AutoRoute(page: ProfileRoute.page),
  ];
}