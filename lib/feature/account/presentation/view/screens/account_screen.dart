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

  // ─── Open Edit Profile ────────────────────────────────────────────────────

  Future<void> _openEditProfile(BuildContext context) async {
    // Pass the same cubit instance so no new Cubit is created.
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<AccountCubit>(),
          child: const EditProfileScreen(),
        ),
      ),
    );

    // If the edit was successful, re-fetch from the API so the UI always
    // reflects the latest backend data — never stale local data.
    if (updated == true && context.mounted) {
      context.read<AccountCubit>().getProfile();
    }
  }

  // ─── Build ────────────────────────────────────────────────────────────────

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
              // ── Loading ──────────────────────────────────────────────────
              if (state is AccountLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryGreen,
                  ),
                );
              }

              // ── Empty State (No Profile) ─────────────────────────────────
              if (state is AccountEmpty) {
                return _AccountEmptyContent(
                  onCreatePressed: () => _openEditProfile(context),
                );
              }

              // ── Error ────────────────────────────────────────────────────
              if (state is AccountError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.base3x,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline_rounded,
                          color: Colors.red,
                          size: 48,
                        ),
                        const SizedBox(height: AppSpacing.base2x),
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

              // ── Loaded ───────────────────────────────────────────────────
              if (state is AccountLoaded) {
                return _AccountContent(
                  account: state.account,
                  onEditPressed: () => _openEditProfile(context),
                );
              }

              // ── Initial / fallback ───────────────────────────────────────
              return const Center(
                child: Text('Loading account data...'),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Account Content (read-only profile view)
// ─────────────────────────────────────────────────────────────────────────────

class _AccountContent extends StatelessWidget {
  final AccountEntity account;
  final VoidCallback onEditPressed;

  const _AccountContent({
    required this.account,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    final profileImage = account.profileImage;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base3x,
        vertical: AppSpacing.base2x,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: AppSpacing.base1x),

          // ── Profile Avatar ──────────────────────────────────────────────
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

          // ── Name ────────────────────────────────────────────────────────
          Text(
            account.name.isNotEmpty ? account.name : 'No Name',
            style: AppTextStyles.h2Heading.copyWith(
              color: AppColors.charcoal,
            ),
          ),

          const SizedBox(height: AppSpacing.base1x),

          // ── Email ────────────────────────────────────────────────────────
          Text(
            account.email.isNotEmpty ? account.email : 'No Email',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: AppSpacing.base4x),

          // ── Read-only fields ─────────────────────────────────────────────
          _buildLabeledField(
            context: context,
            label: 'Name',
            value: account.name,
          ),
          const SizedBox(height: AppSpacing.base2x),
          _buildLabeledField(
            context: context,
            label: 'Email',
            value: account.email,
          ),
          const SizedBox(height: AppSpacing.base2x),
          _buildLabeledField(
            context: context,
            label: 'Password',
            value: '••••••••',
          ),

          const SizedBox(height: AppSpacing.base6x),

          // ── Edit Profile Button ──────────────────────────────────────────
          CustomButton(
            title: 'Edit Profile',
            backgroundColor: AppColors.primaryGreen,
            onPressed: onEditPressed,
          ),

          const SizedBox(height: AppSpacing.base2x),
        ],
      ),
    );
  }

  Widget _buildLabeledField({
    required BuildContext context,
    required String label,
    required String value,
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
          controller: TextEditingController(text: value),
          hintText: label,
          readOnly: true,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Account Empty Content (shown when no profile has been created yet)
// ─────────────────────────────────────────────────────────────────────────────

class _AccountEmptyContent extends StatelessWidget {
  final VoidCallback onCreatePressed;

  const _AccountEmptyContent({required this.onCreatePressed});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base3x,
        vertical: AppSpacing.base4x,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: AppSpacing.base6x),

          // Default Profile Image / Avatar
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
              child: const CircleAvatar(
                radius: 56,
                backgroundColor: AppColors.lightGray,
                child: Icon(
                  Icons.person,
                  size: 56,
                  color: AppColors.textGrey,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.base4x),

          Text(
            "You haven't created your profile yet.",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.charcoal,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppSpacing.base6x),

          CustomButton(
            title: 'Create Profile',
            backgroundColor: AppColors.primaryGreen,
            onPressed: onCreatePressed,
          ),
        ],
      ),
    );
  }
}
