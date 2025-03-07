import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primary_scroll_controller_test/core/visible_detect_scroll_controller_notifier.dart';
import 'package:primary_scroll_controller_test/app/router/routes.dart';

final _navBarTheme = NavigationBarThemeData(
  height: 57,
  backgroundColor: Colors.white,
  indicatorColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  elevation: 1.0,
  labelTextStyle: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black);
    }
    return TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey.shade500);
  }),
);

class TestBottomNavigationBar extends StatefulWidget {
  const TestBottomNavigationBar({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  final StatefulNavigationShell navigationShell;

  final List<Widget> children;

  @override
  State<TestBottomNavigationBar> createState() => _TestBottomNavigationBarState();
}

class _TestBottomNavigationBarState extends State<TestBottomNavigationBar> {
  ScrollController? _primaryScrollController;

  /// 스크롤 위치가 최상단인지에 대한 플래그
  bool _isTopPosition = true;

  /// 스크롤 애니메이션 진행중인지에 대한 플래그
  bool _isAnimating = false;

  // 각 브랜치의 context를 가져오는 메서드
  BuildContext? getBranchContext(int index) {
    return switch (index) {
      0 => homeNavigatorKey.currentContext,
      1 => messageNavigatorKey.currentContext,
      2 => menuNavigatorKey.currentContext,
      _ => null,
    };
  }

  // 기본 라우트 경로 (서브라우트가 아닌 메인 라우트)
  String getRootRoutePath(int index) {
    return switch (index) {
      0 => HomeRoute.path,
      1 => MessageRoute.path,
      2 => MenuRoute.path,
      _ => '',
    };
  }

  // 현재 활성화된 브랜치의 context를 가져오는 메서드
  BuildContext? getCurrentBranchContext() {
    return getBranchContext(widget.navigationShell.currentIndex);
  }

  void _addScrollListener(VoidCallback listener) {
    _primaryScrollController?.addListener(listener);
  }

  void _removeScrollListener(VoidCallback listener) {
    _primaryScrollController?.removeListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollControllerNotification>(
      onNotification: (notification) {
        if (_primaryScrollController != notification.controller) {
          _removeScrollListener(scrollOffsetListener);
          setState(() {
            // 기본 스크롤 컨트롤러를 업데이트합니다.
            // 주어진 컨트롤러는 전송 측의 위젯에 따라 삭제되므로 여기서는 삭제되지 않습니다.
            _primaryScrollController = notification.controller;
          });
          _addScrollListener(scrollOffsetListener);
          scrollOffsetListener();
        }

        return true;
      },
      child: PrimaryScrollController(
        controller: _primaryScrollController ?? PrimaryScrollController.of(context),
        child: Scaffold(
          body: BranchContainer(
            currentIndex: widget.navigationShell.currentIndex,
            children: widget.children,
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: _navBarTheme,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade100, width: 1.0),
                ),
              ),
              child: NavigationBar(
                selectedIndex: widget.navigationShell.currentIndex,
                onDestinationSelected: (index) => _onDestinationSelected(index),
                destinations: const [
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 2),
                    child: NavigationDestination(
                      label: '홈',
                      icon: Icon(Icons.home_outlined, color: Colors.grey),
                      selectedIcon: Icon(Icons.home),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 2),
                    child: NavigationDestination(
                      label: '메시지',
                      icon: Icon(Icons.message_outlined, color: Colors.grey),
                      selectedIcon: Icon(Icons.message),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 2),
                    child: NavigationDestination(
                      label: '내 정보',
                      icon: Icon(Icons.person_outline, color: Colors.grey),
                      selectedIcon: Icon(Icons.person),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 스크롤 위치를 감지하여 상단 위치 여부를 업데이트하는 리스너입니다.
  ///
  /// [_primaryScrollController]가 유효하지 않은 경우 상단 위치로 간주합니다.
  /// 스크롤 offset이 50.0 미만인 경우를 상단 위치로 판단하며,
  /// 이전 상태와 다른 경우에만 [_isTopPosition] 상태를 업데이트합니다.
  void scrollOffsetListener() {
    final hasValidController = _primaryScrollController?.hasClients ?? false;
    if (!hasValidController) {
      setState(() => _isTopPosition = true);
      return;
    }

    final offset = _primaryScrollController!.offset;
    final isTopPosition = offset < 50.0;

    if (_isTopPosition != isTopPosition) {
      setState(() => _isTopPosition = isTopPosition);
    }
  }

  void _onDestinationSelected(int index) {
    // 현재 탭과 선택된 탭이 같은지 확인
    bool isSameIndex = index == widget.navigationShell.currentIndex;

    // 현재 라우트 정보 가져오기
    final GoRouterState routerState = GoRouterState.of(context);
    final String currentLocation = routerState.uri.path;

    // 기본 라우트 경로 (서브라우트가 아닌 메인 라우트)
    final String rootRoutePath = getRootRoutePath(index);

    bool isSameRoute = currentLocation == rootRoutePath;

    // 같은 탭이지만 정확히 같은 라우트인지 확인
    if (isSameIndex && isSameRoute) {
      final BuildContext? context = getBranchContext(index);
      if (context == null) return;

      final scrollController = PrimaryScrollController.of(context);
      if (scrollController.hasClients && !_isAnimating) {
        _startScrollAnimation(scrollController);
      }
    }

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  void _startScrollAnimation(ScrollController controller) {
    _isAnimating = true;
    controller.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut).then((_) {
      _isAnimating = false;
    });
  }
}

/// 브랜치 네비게이터를 표시할 컨테이너
/// 브랜치 전환 시 애니메이션 효과를 제공합니다.
class BranchContainer extends StatelessWidget {
  const BranchContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  /// 현재 활성화된 브랜치의 인덱스
  final int currentIndex;

  /// 브랜치 네비게이터를 표시할 자식 위젯들
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: currentIndex,
      children: children.mapIndexed((int index, Widget navigator) {
        return IgnorePointer(
          ignoring: index != currentIndex,
          child: navigator,
        );
      }).toList(),
    );
  }
}
