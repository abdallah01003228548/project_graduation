import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/constants/app_routes.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/utils/app_dialog.dart';
import 'package:project_graduation/core/utils/app_tost.dart';
import 'package:project_graduation/core/utils/validator_app.dart';
import 'package:project_graduation/core/widget/custom_text_form_field.dart';
import 'package:project_graduation/feature/auth/presentation/view_model/cubit/register/register_cubit.dart';
import 'package:toastification/toastification.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SignUp",
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
          child: BlocProvider<RegisterCubit>(
            create: (context) => serviceLocator<RegisterCubit>(),
            child: BlocListener<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterLoading) {
                  AppDialogs.showLoadingDialog(context);
                } else if (state is RegisterSuccess) {
                  Navigator.pop(context);
                  AppToast.showToast(
                    context: context,
                    title: "Success",
                    description: "Account created successfully!",
                    type: ToastificationType.success,
                  );
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.login,
                  );
                } else if (state is RegisterError) {
                  Navigator.pop(context);
                  AppToast.showToast(
                    context: context,
                    title: "Error",
                    description: state.errorMessage,
                    type: ToastificationType.error,
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    "Name",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    controller: nameController,
                    validator: Validator.validateName,
                    hintText: "Enter your name",
                    keyboardType: TextInputType.text,
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    controller: phoneNumberController,
                    validator: Validator.validatePhoneNumber,
                    hintText: "Enter your phone number",
                    keyboardType: TextInputType.phone,
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 15),
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    controller: passwordController,
                    validator: Validator.validatePassword,
                    hintText: "Enter your password",
                    isPassword: true,
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    validator: (value) => Validator.validateConfirmPassword(
                      value,
                      passwordController.text,
                    ),
                    hintText: "Enter your confirm password",
                    isPassword: true,
                    action: TextInputAction.done,
                  ),
                  const SizedBox(height: 25),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.appSection,
                        );
                      }
                    },
                    color: const Color(0xff212121),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Sign up",
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
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
      floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff6E6A7C),
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff212121),
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          } else {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.login,
                            );
                          }
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
