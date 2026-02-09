import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/theme/colors.dart';
import 'package:todo/i18n/strings.g.dart';
import 'package:todo/presentation/cubit/auth/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 86,
              backgroundColor: ColorDark.whiteFocus,
              child: CachedNetworkImage(
                imageUrl:
                    state.userEntity?.avatarUrl ?? AppConstants.IMAGE_URL_TEST,
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
                    const Icon(Icons.person, size: 56),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              t.id(id: state.userEntity?.id ?? ""),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              t.showUsername(username: state.userEntity?.username ?? ""),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
          ],
        );
      },
    );
  }
}
