import 'package:flutter/material.dart';
import 'package:practicebloom/components/buttons.dart';
import 'package:practicebloom/components/textfield_input.dart';
import 'package:practicebloom/resources/auth_methods.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import '../util/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text
    );
    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    } else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const RootPage())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset(
                'assets/lottie_musicplayingroom.json',
                height: 250,
              ),
              const Text('Welcome back!', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),),
              const Text("It's great to see you again. Sign in and get back to practicing!", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
              const SizedBox(
                height: 25
              ),
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress
              ),
              const SizedBox(
                height: 15
              ),
              TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Password',
                  textInputType: TextInputType.visiblePassword,
                  isPass: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CTAButton(onTap: loginUser, buttonText: 'Log in', loading: _isLoading, textColor: Theme.of(context).colorScheme.onPrimary,),
            ],
          )),
    );
  }
}
