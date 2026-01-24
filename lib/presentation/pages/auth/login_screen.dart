import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [
        const SizedBox(height: 78,),
        Text(AppConstants.LOGIN,style: Theme.of(context).textTheme.headlineLarge,)
      ])),
    );
  }
}
