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
import 'package:project_graduation/feature/auth/domain/entity/register_requiest_entitiy.dart';
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
    return BlocProvider<RegisterCubit>(
      create: (context) => serviceLocator<RegisterCubit>(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            AppDialogs.showLoadingDialog(context);
          } else if (state is RegisterSuccess) {
            Navigator.pop(context);
            AppToast.showToast(
              context: context,
              title: AppStrings.success,
              description: AppStrings.accountCreatedSuccessfully,
              type: ToastificationType.success,
            );
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          } else if (state is RegisterError) {
            Navigator.pop(context);
            AppToast.showToast(
              context: context,
              title: AppStrings.error,
              description: state.errorMessage,
              type: ToastificationType.error,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.signUpTitle,
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
                  const SizedBox(height: AppDimens.spaceL),
                  Text(
                    AppStrings.nameLabel,
                    style: AppTextStyles.bodyLarge,
                  ),
                  const SizedBox(height: AppDimens.spaceXS),
                  CustomTextFormField(
                    controller: nameController,
                    validator: Validator.validateName,
                    hintText: AppStrings.enterYourName,
                    keyboardType: TextInputType.text,
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDimens.spaceL),
                  Text(
                    AppStrings.phoneNumberLabel,
                    style: AppTextStyles.bodyLarge,
                  ),
                  const SizedBox(height: AppDimens.spaceXS),
                  CustomTextFormField(
                    controller: phoneNumberController,
                    validator: Validator.validatePhoneNumber,
                    hintText: AppStrings.enterYourPhoneNumber,
                    keyboardType: TextInputType.phone,
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDimens.spaceL),
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
                  const SizedBox(height: AppDimens.spaceL),
                  Text(
                    AppStrings.passwordLabel,
                    style: AppTextStyles.bodyLarge,
                  ),
                  const SizedBox(height: AppDimens.spaceXS),
                  CustomTextFormField(
                    controller: passwordController,
                    validator: Validator.validatePassword,
                    hintText: AppStrings.enterYourPassword,
                    isPassword: true,
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDimens.spaceL),
                  Text(
                    AppStrings.confirmPasswordLabel,
                    style: AppTextStyles.bodyLarge,
                  ),
                  const SizedBox(height: AppDimens.spaceXS),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    validator: (value) => Validator.validateConfirmPassword(
                      value,
                      passwordController.text,
                    ),
                    hintText: AppStrings.enterYourConfirmPassword,
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
                            var cubit = BlocProvider.of<RegisterCubit>(
                              btnContext,
                            );
                            cubit.intent(
                              RegisterIntentRegister(
                                RegisterRequestEntity(
                                  name: nameController.text,
                                  phone: phoneNumberController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword:
                                      confirmPasswordController.text,
                                ),
                              ),
                            );
                          }
                        },
                        color: AppColors.charcoal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimens.radiusButton),
                        ),
                        child: Text(
                          AppStrings.signUpButtonText,
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButtonAnimator:
              FloatingActionButtonAnimator.noAnimation,
          floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Text.rich(
                    TextSpan(
                      text: AppStrings.alreadyHaveAccount,
                      style: AppTextStyles.bodyMedium,
                      children: [
                        TextSpan(
                          text: AppStrings.login,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.charcoal,
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
        ),
      ),
    );
  }
}
