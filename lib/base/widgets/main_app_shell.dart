import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/data/bottom_nav_items.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/widgets/tab_navigator.dart';
import 'package:rentica/providers/bottom_nav_provider.dart';

class MainAppShell extends ConsumerWidget {
  const MainAppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final currentNavigatorKey = bottomNavItems[selectedIndex].navigatorKey;

        if (currentNavigatorKey.currentState?.canPop() == true) {
          currentNavigatorKey.currentState?.pop();
        } else {
          if (selectedIndex != 0) {
            ref.read(bottomNavIndexProvider.notifier).state = 0;
          } else {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: bottomNavItems.map((item) {
            return TabNavigator(
              key: ValueKey(item.label),
              navigatorKey: item.navigatorKey,
              initialRoute: item.initialRoute,
              routes: item.routes,
            );
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            if (selectedIndex == index) {
              bottomNavItems[index]
                  .navigatorKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            }
            ref.read(bottomNavIndexProvider.notifier).state = index;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppStyles.whiteColor,
          selectedItemColor: AppStyles.primaryColor,
          unselectedItemColor: AppStyles.textGrey,
          selectedLabelStyle: AppStyles.textStyle
              .copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle: AppStyles.textStyle.copyWith(fontSize: 14.0),
          items: bottomNavItems.map((item) {
            return BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            );
          }).toList(),
        ),
      ),
    );
  }
}