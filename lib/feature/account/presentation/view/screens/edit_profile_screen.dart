import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_dimens.dart';
import 'package:project_graduation/core/theme/app_spacing.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';
import 'package:project_graduation/core/theme/custom_text_field.dart';
import 'package:project_graduation/core/widget/custom_button.dart';
import 'package:project_graduation/feature/account/presentation/view_model/account_cubit.dart';
import 'package:project_graduation/feature/account/presentation/view_model/account_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _passwordController;

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    final account = context.read<AccountCubit>().currentAccount;
    _nameController = TextEditingController(text: account?.name ?? '');
    _emailController = TextEditingController(text: account?.email ?? '');
    _phoneController = TextEditingController(text: account?.phone ?? '');
    _addressController = TextEditingController(text: account?.address ?? '');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showImageSourceBottomSheet(BuildContext cubitContext) {
    showModalBottomSheet(
      context: cubitContext,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimens.radiusM),
        ),
      ),
      builder: (modalContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.primaryGreen,
                ),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(modalContext);
                  cubitContext.read<AccountCubit>().pickImageAndUpload(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                  color: AppColors.primaryGreen,
                ),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(modalContext);
                  cubitContext.read<AccountCubit>().pickImageAndUpload(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSave(BuildContext context) {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final address = _addressController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name and Email cannot be empty'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    context.read<AccountCubit>().updateProfile(
          name: name,
          email: email,
          phone: phone.isNotEmpty ? phone : null,
          address: address.isNotEmpty ? address : null,
          password: password.isNotEmpty ? password : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is AccountUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: AppColors.primaryGreen,
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context, true);
        } else if (state is AccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AccountCubit>();
        final account = cubit.currentAccount;
        final selectedImage = cubit.selectedImageFile;
        final isUpdating = state is AccountUpdating;

        ImageProvider? avatarImage;
        Widget? avatarChild;
        if (selectedImage != null) {
          avatarImage = FileImage(selectedImage);
        } else if (account?.profileImage != null &&
            account!.profileImage!.isNotEmpty) {
          avatarImage = CachedNetworkImageProvider(account.profileImage!);
        } else {
          avatarChild = const Icon(
            Icons.person,
            size: 60,
            color: AppColors.textGrey,
          );
        }

        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              color: AppColors.charcoal,
              onPressed: isUpdating
                  ? null
                  : () {
                      cubit.clearSelectedImage();
                      Navigator.pop(context, false);
                    },
            ),
            title: const Text(
              'Edit Profile',
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
            child: PopScope(
              canPop: !isUpdating,
              onPopInvokedWithResult: (didPop, _) {
                if (didPop) cubit.clearSelectedImage();
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base3x,
                  vertical: AppSpacing.base2x,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSpacing.base1x),
                    Center(
                      child: Stack(
                        children: [
                          Container(
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
                              radius: 60,
                              backgroundColor: AppColors.lightGray,
                              backgroundImage: avatarImage,
                              child: avatarChild,
                            ),
                          ),
                          Positioned(
                             bottom: 0,
                             right: 0,
                             child: GestureDetector(
                               onTap: isUpdating
                                   ? null
                                   : () => _showImageSourceBottomSheet(context),
                               child: Container(
                                 height: 38,
                                 width: 38,
                                 decoration: BoxDecoration(
                                   color: AppColors.primaryGreen,
                                   shape: BoxShape.circle,
                                   border: Border.all(
                                     color: Colors.white,
                                     width: 3,
                                   ),
                                   boxShadow: [
                                     BoxShadow(
                                       color:
                                           const Color.fromRGBO(0, 0, 0, 0.15),
                                       blurRadius: 6,
                                       offset: const Offset(0, 2),
                                     ),
                                   ],
                                 ),
                                 child: const Icon(
                                   Icons.camera_alt_rounded,
                                   color: Colors.white,
                                   size: 16,
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(height: AppSpacing.base5x),
                     _buildLabeledField(
                       label: 'Name',
                       hint: 'Enter your name',
                       controller: _nameController,
                       enabled: !isUpdating,
                     ),
                     const SizedBox(height: AppSpacing.base2x),
                     _buildLabeledField(
                       label: 'Email',
                       hint: 'Enter your email',
                       controller: _emailController,
                       keyboardType: TextInputType.emailAddress,
                       enabled: !isUpdating,
                     ),
                     const SizedBox(height: AppSpacing.base2x),
                     _buildLabeledField(
                       label: 'Phone',
                       hint: 'Enter your phone',
                       controller: _phoneController,
                       keyboardType: TextInputType.phone,
                       enabled: !isUpdating,
                     ),
                     const SizedBox(height: AppSpacing.base2x),
                     _buildLabeledField(
                       label: 'Address',
                       hint: 'Enter your address',
                       controller: _addressController,
                       enabled: !isUpdating,
                     ),
                     const SizedBox(height: AppSpacing.base2x),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Password',
                           style: AppTextStyles.bodyMedium.copyWith(
                             fontWeight: FontWeight.w600,
                             color: AppColors.charcoal,
                           ),
                         ),
                         const SizedBox(height: AppSpacing.base1x),
                         CustomTextField(
                           controller: _passwordController,
                           hintText: 'New password (optional)',
                           obscureText: _obscurePassword,
                           readOnly: isUpdating,
                           suffixIcon: IconButton(
                             icon: Icon(
                               _obscurePassword
                                   ? Icons.visibility_off_outlined
                                   : Icons.visibility_outlined,
                               color: AppColors.textGrey,
                               size: 22,
                             ),
                             onPressed: isUpdating
                                 ? null
                                 : () => setState(
                                       () => _obscurePassword = !_obscurePassword,
                                     ),
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: AppSpacing.base6x),
                     CustomButton(
                       title: 'Save Changes',
                       backgroundColor: AppColors.primaryGreen,
                       isLoading: isUpdating,
                       onPressed: () => _onSave(context),
                     ),
                     const SizedBox(height: AppSpacing.base2x),
                   ],
                 ),
               ),
             ),
           ),
         );
       },
     );
   }

   Widget _buildLabeledField({
     required String label,
     required String hint,
     required TextEditingController controller,
     required bool enabled,
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
           readOnly: !enabled,
           keyboardType: keyboardType,
         ),
       ],
     );
   }
}
