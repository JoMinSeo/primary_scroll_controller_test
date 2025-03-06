import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primary_scroll_controller_test/core/visible_detect_scroll_controller_notifier.dart';
import 'package:primary_scroll_controller_test/app/router/routes.dart';

const _navBarTheme = NavigationBarThemeData(
  height: 57,
  backgroundColor: Colors.white,
  indicatorColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  elevation: 1.0,
  // labelTextStyle: WidgetStateProperty.resolveWith((states) {
  //   if (states.contains(WidgetState.selected)) {
  //     return $styles.text.font11.semiBold.textColor($styles.colors.brand600);
  //   }
  //   return $styles.text.font11.semiBold.textColor($styles.colors.gray500);
  // }),
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

  bool _isTopPosition = true;

  // 각 브랜치의 context를 가져오는 메서드
  BuildContext? getBranchContext(int index) {
    switch (index) {
      case 0:
        return homeNavigatorKey.currentContext;
      case 1:
        return messageNavigatorKey.currentContext;
      case 2:
        return menuNavigatorKey.currentContext;
      default:
        return null;
    }
  }

  // 현재 활성화된 브랜치의 context를 가져오는 메서드
  BuildContext? getCurrentBranchContext() {
    return getBranchContext(widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollControllerNotification>(
      onNotification: (notification) {
        if (_primaryScrollController != notification.controller) {
          _primaryScrollController?.removeListener(scrollOffsetListener);
          setState(() {
            // 기본 스크롤 컨트롤러를 업데이트합니다.
            // 주어진 컨트롤러는 전송 측의 위젯에 따라 삭제되므로 여기서는 삭제되지 않습니다.
            _primaryScrollController = notification.controller;
          });
          _primaryScrollController?.addListener(scrollOffsetListener);
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
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 2),
                    child: NavigationDestination(
                      label: '메시지',
                      icon: Icon(Icons.message_outlined),
                      selectedIcon: Icon(Icons.message),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 2),
                    child: NavigationDestination(
                      label: '내 정보',
                      icon: Icon(Icons.person_outline),
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
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );

    final BuildContext? context = getBranchContext(index);

    if (context == null) return;

    final scrollController = PrimaryScrollController.of(context);

    if (scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 300), () {
        scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      });
    }
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
