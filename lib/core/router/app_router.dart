import 'package:go_router/go_router.dart';

import '../../features/dashboard/views/screens/dashboard_screen.dart';
import '../../features/main/main_screen.dart';
import 'route_names.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: dashBoardRoute,
      builder: (context, state) =>  DashboardScreen(),
    ),
    GoRoute(
      path: mainRoute,
      builder: (context, state) => const MainScreen(),
    ),
  ],
  initialLocation: mainRoute,
);