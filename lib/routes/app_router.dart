import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';


//flutter pub run build_runner build
@AutoRouterConfig()
class AppRouter extends $AppRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HolidaysRoute.page, initial: true),
    AutoRoute(page: EncodeHolidayRoute.page),
    AutoRoute(page: ListHolidaysChatRoute.page),
    AutoRoute(page: ChatRoute.page),
  ];
}