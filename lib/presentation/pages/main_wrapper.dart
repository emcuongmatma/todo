import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/widgets/add_task_bottom_sheet.dart';

class MainWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: SvgPicture.asset(Assets.iconsIcFilter),
          ),
        ),
        title: Text(
          AppConstants.INDEX,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: ColorDark.whiteFocus),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: CachedNetworkImage(
                imageUrl: AppConstants.IMAGE_URL_TEST,
                imageBuilder: (context, imageProvider) => Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: navigationShell,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskSheet(context);
        },
        elevation: 0,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),

      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 12),
        color: ColorDark.bottomNavigationBackground,
        shape: null,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BottomNavigationBarItem(
              icon: Assets.iconsIcHome,
              label: AppConstants.INDEX,
              index: 0,
              navigationShell: navigationShell,
            ),
            BottomNavigationBarItem(
              icon: Assets.iconsIcCalendar,
              label: AppConstants.CALENDAR,
              index: 1,
              navigationShell: navigationShell,
            ),
            const SizedBox(width: 40),
            BottomNavigationBarItem(
              icon: Assets.iconsIcFocuse,
              label: AppConstants.FOCUSE,
              index: 2,
              navigationShell: navigationShell,
            ),
            BottomNavigationBarItem(
              icon: Assets.iconsIcProfile,
              label: AppConstants.PROFILE,
              index: 3,
              navigationShell: navigationShell,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationBarItem extends StatelessWidget {
  final String icon;
  final String label;
  final int index;
  final StatefulNavigationShell navigationShell;

  const BottomNavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, width: 24, height: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: index == navigationShell.currentIndex
                  ? ColorDark.whiteFocus
                  : ColorDark.whiteNormal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
