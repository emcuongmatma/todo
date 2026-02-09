import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/i18n/strings.g.dart';
import 'package:todo/presentation/cubit/auth/auth_cubit.dart';
import 'package:todo/presentation/widgets/add_task_bottom_sheet.dart';

class MainWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
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
              switch (navigationShell.currentIndex) {
                0 => t.index,
                1 => t.calendar,
                2 => t.focuse,
                3 => t.profile,
                _ => t.undefined,
              },
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: ColorDark.whiteFocus),
            ),
            actions: navigationShell.currentIndex != 3
                ? [
                    GestureDetector(
                      onTap: () {
                        navigationShell.goBranch(
                          3,
                          initialLocation: 3 == navigationShell.currentIndex,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: CircleAvatar(
                          radius: 21,
                          backgroundColor: ColorDark.whiteFocus,
                          child: CachedNetworkImage(
                            imageUrl:
                                state.userEntity?.avatarUrl ??
                                AppConstants.IMAGE_URL_TEST,
                            imageBuilder: (context, imageProvider) => Container(
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
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.person),
                          ),
                        ),
                      ),
                    ),
                  ]
                : null,
            centerTitle: true,
          ),
          body: navigationShell,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                  label: t.index,
                  index: 0,
                  navigationShell: navigationShell,
                ),
                BottomNavigationBarItem(
                  icon: Assets.iconsIcCalendar,
                  label: t.calendar,
                  index: 1,
                  navigationShell: navigationShell,
                ),
                const SizedBox(width: 40),
                BottomNavigationBarItem(
                  icon: Assets.iconsIcFocuse,
                  label: t.focuse,
                  index: 2,
                  navigationShell: navigationShell,
                ),
                BottomNavigationBarItem(
                  icon: Assets.iconsIcProfile,
                  label: t.profile,
                  index: 3,
                  navigationShell: navigationShell,
                ),
              ],
            ),
          ),
        );
      },
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
          SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            colorFilter: index == navigationShell.currentIndex
                ? const ColorFilter.mode(ColorDark.primary, BlendMode.srcIn)
                : null,
          ),
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
