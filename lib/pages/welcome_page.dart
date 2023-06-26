import 'package:flutter/material.dart';
import 'package:practicebloom/components/buttons.dart';
import 'package:practicebloom/components/textfield_input.dart';
import 'package:practicebloom/main.dart';
import 'package:practicebloom/pages/login_page.dart';
import 'package:practicebloom/resources/auth_methods.dart';
import 'package:practicebloom/util/utils.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        fullname: _fullNameController.text,
        email: _emailController.text,
        password: _passwordController.text);

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
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset('assets/lottie_growingplant.json', repeat: false, height: 200.0),
              const SizedBox(
                height: 25
              ),
              const Text('Welcome to Practice Bloom!', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),),
              const Text('Create an account to get started.', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17)),
              const SizedBox(
                height: 25
              ),
              TextFieldInput(
                  textEditingController: _fullNameController,
                  hintText: 'Name',
                  textInputType: TextInputType.name),
              const SizedBox(
                height: 15,
              ),
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 15,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Password',
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(
                height: 15,
              ),
              CTAButton(
                onTap: signUpUser, 
                buttonText: 'Sign up', 
                loading: _isLoading, 
                textColor: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(
                height: 20
              ),
              Row(
                children: [
                  const Text('Already have an account?'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const LoginPage())
                      ),
                      child: Text('Login.', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
