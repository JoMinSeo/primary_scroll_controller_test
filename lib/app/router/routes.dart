import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primary_scroll_controller_test/app/router/bottom_navigation_bar.dart';
import 'package:primary_scroll_controller_test/pages/home_page.dart';
import 'package:primary_scroll_controller_test/pages/menu_page.dart';
import 'package:primary_scroll_controller_test/pages/message_page.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home navigator key');
final GlobalKey<NavigatorState> messageNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'message navigator key');
final GlobalKey<NavigatorState> menuNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'menu navigator key');

@TypedStatefulShellRoute<LeanShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<HomeRoute>(path: HomeRoute.path, name: HomeRoute.name),
      ],
    ),
    TypedStatefulShellBranch<MessageBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MessageRoute>(path: MessageRoute.path, name: MessageRoute.name),
      ],
    ),
    TypedStatefulShellBranch<MenuBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MenuRoute>(path: MenuRoute.path, name: MenuRoute.name),
      ],
    ),
  ],
)
class LeanShellRouteData extends StatefulShellRouteData {
  const LeanShellRouteData();

  static const String $restorationScopeId = 'lean shell route scope';

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return navigationShell;
  }

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return TestBottomNavigationBar(
      key: const ValueKey<String>('CustomShellRouteBuilder'),
      navigationShell: navigationShell,
      children: children,
    );
  }
}

class HomeBranchData extends StatefulShellBranchData {
  const HomeBranchData();

  static const String $restorationScopeId = 'homeScope';

  static final GlobalKey<NavigatorState> $navigatorKey = homeNavigatorKey;
}

class MessageBranchData extends StatefulShellBranchData {
  const MessageBranchData();

  static const String $restorationScopeId = 'messageScope';

  static final GlobalKey<NavigatorState> $navigatorKey = messageNavigatorKey;
}

class MenuBranchData extends StatefulShellBranchData {
  const MenuBranchData();

  static const String $restorationScopeId = 'menuScope';

  static final GlobalKey<NavigatorState> $navigatorKey = menuNavigatorKey;
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  static const path = '/';

  static const String name = 'home_view';

  static final GlobalKey<NavigatorState> $parentNavigatorKey = homeNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class MessageRoute extends GoRouteData {
  const MessageRoute();

  static const path = '/message';

  static const String name = 'message_view';

  static final GlobalKey<NavigatorState> $parentNavigatorKey = messageNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MessagePage();
  }
}

class MenuRoute extends GoRouteData {
  const MenuRoute();

  static const path = '/menu';

  static const String name = 'menu_view';

  static final GlobalKey<NavigatorState> $parentNavigatorKey = menuNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MenuPage();
  }
}
