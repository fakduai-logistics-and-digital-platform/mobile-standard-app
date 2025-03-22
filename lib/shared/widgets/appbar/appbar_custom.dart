import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_standard/router/router.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';
import 'package:mobile_app_standard/shared/widgets/appbar/language_dropdown.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String currentRouteName;

  const AppBarCustom({
    super.key,
    required this.currentRouteName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: _buildTitle(),
        actions: [
          Row(
            children: [
              _buildRouteButton(
                'Home',
                isActive: currentRouteName == HomeRoute.name,
                onPressed: () {
                  currentRouteName == HomeRoute.name
                      ? null
                      : context.router.push(const HomeRoute());
                },
              ),
              _buildRouteButton(
                'Todo',
                isActive: currentRouteName == TodoRoute.name,
                onPressed: () {
                  currentRouteName == TodoRoute.name
                      ? null
                      : context.router.push(const TodoRoute());
                },
              ),
            ],
          ),
          LanguageDropdown(context: context),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildRouteButton(
    String text, {
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? PColor.primaryColor : Colors.black,
          fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Fakduai ',
            style: TextStyle(
              color: PColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const TextSpan(
            text: 'APP',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
