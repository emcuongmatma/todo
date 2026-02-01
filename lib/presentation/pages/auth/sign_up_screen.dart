import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_constants.dart';
import 'package:todo/core/utils/toast.dart';
import 'package:todo/presentation/cubit/auth/auth_cubit.dart';
import 'package:todo/presentation/models/normal_input.dart';
import 'package:todo/presentation/widgets/custom_text_field.dart';
import 'package:todo/presentation/widgets/loading_wrapper.dart';
import 'package:todo/presentation/widgets/text_span_with_action.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.read<AuthCubit>().resetInputState();
            if (context.canPop()) context.pop();
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (prv, cur) => prv.effect != cur.effect,
        listener: (context, state) {
          switch (state.effect) {
            case AuthScreenEffect.none:
              null;
            case AuthScreenEffect.success:
              showToast(msg: AppConstants.REGISTER_SUCCESS, isLong: true);
            case AuthScreenEffect.error:
              showToast(msg: state.error?.message, isLong: true);
          }
          context.read<AuthCubit>().clearEffect();
        },
        builder: (context, state) {
          return LoadingWrapper(
            isLoading: state.isLoading,
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                AppConstants.REGISTER,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
                              ),
                              const SizedBox(height: 53),
                              Text(
                                AppConstants.USERNAME,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                onChange: (value) => {
                                  context.read<AuthCubit>().onUsernameChange(
                                    username: value,
                                    validConfirmPassword: true,
                                  ),
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
                                  context.read<AuthCubit>().onPasswordChange(
                                    password: value,
                                    validConfirmPassword: true,
                                  ),
                                },
                                hintText: AppConstants.ENTER_YOUR_PASSWORD,
                                isPasswordTextField: true,
                                errorText: state.passwordInput.inputStatusText,
                              ),
                              const SizedBox(height: 25),
                              Text(
                                AppConstants.CONFIRM_PASSWORD,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              CustomTextField(
                                onChange: (value) => {
                                  context
                                      .read<AuthCubit>()
                                      .onConfirmPasswordChange(
                                        confirmPassword: value,
                                        validConfirmPassword: true,
                                      ),
                                },
                                hintText: AppConstants.ENTER_YOUR_PASSWORD,
                                isPasswordTextField: true,
                                errorText:
                                    state.confirmPasswordInput.inputStatusText,
                              ),
                              const SizedBox(height: 69),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: state.isValid
                                      ? () {
                                          context.read<AuthCubit>().signUp();
                                        }
                                      : null,
                                  child: Text(
                                    AppConstants.REGISTER,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: AlignmentGeometry.bottomCenter,
                                child: TextSpanWithAction(
                                  text1: AppConstants.ALREADY_HAVE_ACCOUNT,
                                  text2: AppConstants.LOGIN,
                                  onAction: () {
                                    context.read<AuthCubit>().resetInputState();
                                    if (context.canPop()) context.pop();
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
