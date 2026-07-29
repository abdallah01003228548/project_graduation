import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_spacing.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';
import 'package:project_graduation/core/theme/custom_text_field.dart';
import 'package:project_graduation/core/widget/custom_button.dart';
import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';
import 'package:project_graduation/feature/account/presentation/view/screens/edit_profile_screen.dart';
import 'package:project_graduation/feature/account/presentation/view_model/account_cubit.dart';
import 'package:project_graduation/feature/account/presentation/view_model/account_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late final AccountCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = serviceLocator<AccountCubit>()..getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const Text(
            'Account',
            style: TextStyle(
              color: AppColors.charcoal,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: SafeArea(
          child: BlocBuilder<AccountCubit, AccountState>(
            builder: (context, state) {
              if (state is AccountLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryGreen,
                  ),
                );
              }

              if (state is AccountError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.base3x,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.base2x),
                        CustomButton(
                          title: 'Retry',
                          backgroundColor: AppColors.primaryGreen,
                          onPressed: () {
                            context.read<AccountCubit>().getProfile();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is AccountLoaded) {
                return _AccountContent(account: state.account);
              }

              return const Center(
                child: Text('Initialize Account Data...'),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AccountContent extends StatefulWidget {
  final AccountEntity account;

  const _AccountContent({required this.account});

  @override
  State<_AccountContent> createState() => _AccountContentState();
}

class _AccountContentState extends State<_AccountContent> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.account.name);
    _emailController = TextEditingController(text: widget.account.email);
    _passwordController = TextEditingController(text: '********');
  }

  @override
  void didUpdateWidget(covariant _AccountContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.account.name != widget.account.name) {
      _nameController.text = widget.account.name;
    }
    if (oldWidget.account.email != widget.account.email) {
      _emailController.text = widget.account.email;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = widget.account.profileImage;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base3x,
        vertical: AppSpacing.base2x,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: AppSpacing.base1x),
          // Circular Profile Image
          Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 56,
                backgroundColor: AppColors.lightGray,
                backgroundImage: profileImage != null && profileImage.isNotEmpty
                    ? CachedNetworkImageProvider(profileImage)
                    : null,
                child: profileImage == null || profileImage.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 56,
                        color: AppColors.textGrey,
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.base2x),
          // User Full Name
          Text(
            widget.account.name.isNotEmpty ? widget.account.name : 'No Name',
            style: AppTextStyles.h2Heading.copyWith(
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: AppSpacing.base1x),
          // User Email
          Text(
            widget.account.email.isNotEmpty ? widget.account.email : 'No Email',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.base4x),

          // Read-only custom fields
          _buildLabeledField(
            label: 'Name',
            hint: 'Name',
            controller: _nameController,
          ),
          const SizedBox(height: AppSpacing.base2x),
          _buildLabeledField(
            label: 'Email',
            hint: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.base2x),
          _buildLabeledField(
            label: 'Password',
            hint: 'Password',
            controller: _passwordController,
          ),
          const SizedBox(height: AppSpacing.base6x),

          // Edit Profile Button
          CustomButton(
            title: 'Edit Profile',
            backgroundColor: AppColors.primaryGreen,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<AccountCubit>(),
                    child: const EditProfileScreen(),
                  ),
                ),
              ).then((_) {
                // Refresh profile data upon returning
                if (context.mounted) {
                  context.read<AccountCubit>().getProfile();
                }
              });
            },
          ),
          const SizedBox(height: AppSpacing.base2x),
        ],
      ),
    );
  }

  Widget _buildLabeledField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal,
          ),
        ),
        const SizedBox(height: AppSpacing.base1x),
        CustomTextField(
          controller: controller,
          hintText: hint,
          readOnly: true,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
