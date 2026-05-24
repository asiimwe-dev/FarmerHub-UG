import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/app_scaffold.dart';
import '../modules/auth/presentation/login_page.dart';
import '../modules/field_capture/presentation/pages/field_capture_page.dart';
import '../modules/forecasts/presentation/pages/forecasts_page.dart';
import '../modules/traceability/presentation/pages/traceability_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/field-capture',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return AppScaffold(
            currentPath: state.uri.path,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/field-capture',
            builder: (context, state) => const FieldCapturePage(),
          ),
          GoRoute(
            path: '/traceability',
            builder: (context, state) => const TraceabilityPage(),
          ),
          GoRoute(
            path: '/forecasts',
            builder: (context, state) => const ForecastsPage(),
          ),
        ],
      ),
    ],
  );
});
