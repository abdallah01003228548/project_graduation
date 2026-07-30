import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/constants/app_routes.dart';
import 'package:project_graduation/core/constants/app_strings.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_dimens.dart';

import 'package:project_graduation/core/theme/app_text_styles.dart';
import 'package:project_graduation/core/utils/app_dialog.dart';
import 'package:project_graduation/core/utils/app_tost.dart';
import 'package:project_graduation/core/utils/validator_app.dart';
import 'package:project_graduation/core/widget/custom_text_form_field.dart';
import 'package:project_graduation/feature/auth/presentation/view_model/cubit/login/login_cubit.dart';
import 'package:toastification/toastification.dart';

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
    return BlocProvider<LoginCubit>(
      create: (context) => serviceLocator<LoginCubit>(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            AppDialogs.showLoadingDialog(context);
          } else if (state is LoginSuccess) {
            Navigator.pop(context);
            AppToast.showToast(
              context: context,
              title: AppStrings.success,
              description: AppStrings.loggedInSuccessfully,
              type: ToastificationType.success,
            );
            Navigator.pushReplacementNamed(context, AppRoutes.appSection);
          } else if (state is LoginError) {
            Navigator.pop(context);
            AppToast.showToast(
              context: context,
              title: AppStrings.error,
              description: state.error,
              type: ToastificationType.error,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.login,
              style: AppTextStyles.h2Heading,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimens.spaceL),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimens.spaceXL),
                  Text(
                    AppStrings.emailLabel,
                    style: AppTextStyles.bodyLarge,
                  ),
                  const SizedBox(height: AppDimens.spaceXS),
                  CustomTextFormField(
                    controller: emailController,
                    validator: Validator.validateEmail,
                    hintText: AppStrings.enterYourEmail,
                    keyboardType: TextInputType.emailAddress,
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDimens.spaceXL),
                  Text(
                    AppStrings.passwordLabel,
                    style: AppTextStyles.bodyLarge,
                  ),
                  const SizedBox(height: AppDimens.spaceXS),
                  CustomTextFormField(
                    controller: passwordController,
                    validator: Validator.validatePassword,
                    hintText: AppStrings.enterYourPassword,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    action: TextInputAction.done,
                  ),
                  const SizedBox(height: AppDimens.spaceXL),
                  Builder(
                    builder: (btnContext) {
                      return MaterialButton(
                        minWidth: double.infinity,
                        height: 50,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var cubit = BlocProvider.of<LoginCubit>(btnContext);
                            cubit.intent(
                              LoginIntentLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                        color: AppColors.charcoal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimens.radiusButton),
                        ),
                        child: Text(
                          AppStrings.login,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      );
                    },
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
                      text: AppStrings.dontHaveAccount,
                      style: AppTextStyles.bodyMedium,
                      children: [
                        TextSpan(
                          text: AppStrings.signUp,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.charcoal,
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
        ),
      ),
    );
  }
}