import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobile_app_standard/i18n/i18n.dart';
import 'package:mobile_app_standard/router/router.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';

class BottomBarCustom extends HookWidget {
  final String currentRouteName;

  const BottomBarCustom({super.key, required this.currentRouteName});

  int _getIndexFromRoute(String routeName) {
    if (routeName == HomeRoute.name) return 0;
    if (routeName == TodoRoute.name) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(_getIndexFromRoute(currentRouteName));

    useEffect(() {
      selectedIndex.value = _getIndexFromRoute(currentRouteName);
      return null;
    }, [currentRouteName]);

    void onItemTapped(int index) {
      if (index == 0 && currentRouteName != HomeRoute.name) {
        context.router.push(const HomeRoute());
      } else if (index == 1 && currentRouteName != TodoRoute.name) {
        context.router.push(const TodoRoute());
      }
      selectedIndex.value = index;
    }

    final msg = AppLocalizations(context).appbar;
    return BottomNavigationBar(
      currentIndex: selectedIndex.value,
      onTap: onItemTapped,
      selectedItemColor: PColor.primaryColor,
      unselectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: msg.home_route_name,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: msg.todo_route_name,
        ),
      ],
    );
  }
}
