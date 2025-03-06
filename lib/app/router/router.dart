import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primary_scroll_controller_test/app/router/routes.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: HomeRoute.path,
  navigatorKey: _navigatorKey,
  routes: $appRoutes,
);
