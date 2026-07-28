import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_graduation/core/constants/app_routes.dart';
import 'package:project_graduation/core/utils/validator_app.dart';
import 'package:project_graduation/core/widget/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff1F1F1F),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Email",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                controller: emailController,
                validator: Validator.validateEmail,
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
                action: TextInputAction.next,
              ),
              const SizedBox(height: 30),
              const Text(
                "Password",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              CustomTextFormField(
                controller: passwordController,
                validator: Validator.validatePassword,
                hintText: "Enter your password",
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                action: TextInputAction.done,
              ),
              const SizedBox(height: 30),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushReplacementNamed(context, AppRoutes.appSection);
                  }
                },
                color: const Color(0xff212121),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(fontSize: 14, color: Color(0xff6E6A7C)),
                  children: [
                    TextSpan(
                      text: "Sign Up",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff212121),
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, AppRoutes.register);
                        },
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}