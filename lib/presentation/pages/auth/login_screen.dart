import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/constants/routes.dart';
import 'package:todo/presentation/cubit/auth/auth_cubit.dart';
import 'package:todo/presentation/cubit/task/task_cubit.dart';
import 'package:todo/presentation/models/normal_input.dart';
import 'package:todo/presentation/widgets/custom_text_field.dart';
import 'package:todo/presentation/widgets/text_span_with_action.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state.effect) {
            case AuthScreenEffect.loginSuccess:
              context.read<TaskCubit>().syncTasksFromServer();
              // context.goNamed(AppRouteName.HOME_ROUTE_NAME);
            case AuthScreenEffect.none:
              null;
            case AuthScreenEffect.wrongPassword:
              null;
            case AuthScreenEffect.signUpSuccess:
              null;
          }
          context.read<AuthCubit>().clearEffect();
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 78),
                  Text(
                    AppConstants.LOGIN,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 53),
                  Text(
                    AppConstants.USERNAME,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    onChange: (value) => {
                      context.read<AuthCubit>().onUsernameChange(username:  value,validConfirmPassword: false),
                    },
                    hintText: AppConstants.ENTER_YOUR_USERNAME,
                    errorText: state.usernameInput.inputStatusText,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    AppConstants.PASSWORD,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    onChange: (value) => {
                      context.read<AuthCubit>().onPasswordChange(password:  value, validConfirmPassword: false),
                    },
                    hintText: AppConstants.ENTER_YOUR_PASSWORD,
                    isPasswordTextField: true,
                    errorText: state.passwordInput.inputStatusText,
                  ),
                  const SizedBox(height: 69),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isValid
                          ? () {
                              context.read<AuthCubit>().login();
                            }
                          : null,
                      child: Text(
                        AppConstants.LOGIN,
                        textAlign: TextAlign.center,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: AlignmentGeometry.bottomCenter,
                    child: TextSpanWithAction(
                      text1: AppConstants.DONT_HAVE_ACCOUNT,
                      text2: AppConstants.REGISTER,
                      onAction: () {
                        context.pushNamed(AppRouteName.SIGNUP_ROUTE_NAME);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
