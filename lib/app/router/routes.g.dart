// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $leanShellRouteData,
    ];

RouteBase get $leanShellRouteData => StatefulShellRouteData.$route(
      restorationScopeId: LeanShellRouteData.$restorationScopeId,
      navigatorContainerBuilder: LeanShellRouteData.$navigatorContainerBuilder,
      factory: $LeanShellRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          navigatorKey: HomeBranchData.$navigatorKey,
          restorationScopeId: HomeBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/',
              name: 'home_view',
              parentNavigatorKey: HomeRoute.$parentNavigatorKey,
              factory: $HomeRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'home_detail',
                  name: 'home_detail_view',
                  parentNavigatorKey: HomeDetailRoute.$parentNavigatorKey,
                  factory: $HomeDetailRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: MessageBranchData.$navigatorKey,
          restorationScopeId: MessageBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/message',
              name: 'message_view',
              parentNavigatorKey: MessageRoute.$parentNavigatorKey,
              factory: $MessageRouteExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          navigatorKey: MenuBranchData.$navigatorKey,
          restorationScopeId: MenuBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/menu',
              name: 'menu_view',
              parentNavigatorKey: MenuRoute.$parentNavigatorKey,
              factory: $MenuRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $LeanShellRouteDataExtension on LeanShellRouteData {
  static LeanShellRouteData _fromState(GoRouterState state) =>
      const LeanShellRouteData();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HomeDetailRouteExtension on HomeDetailRoute {
  static HomeDetailRoute _fromState(GoRouterState state) =>
      const HomeDetailRoute();

  String get location => GoRouteData.$location(
        '/home_detail',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MessageRouteExtension on MessageRoute {
  static MessageRoute _fromState(GoRouterState state) => const MessageRoute();

  String get location => GoRouteData.$location(
        '/message',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MenuRouteExtension on MenuRoute {
  static MenuRoute _fromState(GoRouterState state) => const MenuRoute();

  String get location => GoRouteData.$location(
        '/menu',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
