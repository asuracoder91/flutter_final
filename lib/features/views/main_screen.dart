import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'fluid_menu/fluid_nav_bar.dart';
import 'list_page.dart';
import 'write_page.dart';

final mainScreenKey = GlobalKey<_MainScreenState>();

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key, required this.tab}) : super(key: key);
  static const routeName = "main";
  final String tab;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  late Widget _childScreen;
  final List<String> _tabs = [
    "home",
    "write",
  ];

  void onTap(int index) {
    context.go("/${_tabs[index]}");
    final controller = ref.read(fluidNavBarControllerProvider);
    controller.triggerAnimationForIndex(index);
    setState(() {
      _changeScreen(_tabs[index]);
    });
  }

  void _changeScreen(String tab) {
    switch (tab) {
      case "home":
        _childScreen = const ListPage();
        break;
      case "write":
        _childScreen = const WritePage();
        break;
      default:
        _childScreen = const ListPage();
    }
    _childScreen = AnimatedSwitcher(
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      duration: const Duration(milliseconds: 600),
      child: _childScreen,
    );
  }

  void changeTab(int index) {
    _handleNavigationChange(index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _changeScreen(widget.tab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0E9FF),
      extendBody: true,
      body: _childScreen,
      bottomNavigationBar: FluidNavBar(
          selectedIndex: _tabs.indexOf(widget.tab),
          onChange: _handleNavigationChange),
    );
  }

  void _handleNavigationChange(int index) {
    onTap(index);
  }
}
