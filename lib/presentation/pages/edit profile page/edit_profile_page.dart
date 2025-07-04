import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
import 'package:safar/constants/app_theme/colour_theme/colour_theme.dart';
import 'package:safar/constants/app_theme/textfield_theme/textfield_theme.dart';
import 'package:safar/constants/app_theme/button_theme/main_button_theme.dart';
import 'cancel_servie.dart';

class EditProfilePage extends StatefulWidget {
  final String initialName;
  final String initialPhone;
  final String initialEmail;
  final String initialAddress;
  final String avatarUrl;

  const EditProfilePage({
    Key? key,
    this.initialName = 'Sachin Belle',
    this.initialPhone = '1234567890',
    this.initialEmail = 'sachinbelle01@gmail.com',
    this.initialAddress =
        'Lorem Ipsum is simply dummy text of the printing and typesetting.',
    this.avatarUrl = 'https://randomuser.me/api/portraits/men/32.jpg',
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    phoneController = TextEditingController(text: widget.initialPhone);
    emailController = TextEditingController(text: widget.initialEmail);
    addressController = TextEditingController(text: widget.initialAddress);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _onSave() {
    // TODO: Connect this to your backend update logic
    final updatedProfile = {
      'name': nameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'address': addressController.text,
    };
    print('Save profile: $updatedProfile');
    // Show a snackbar or navigate back, etc.
  }

  void _onDeleteAccount() {
    // TODO: Connect this to your backend delete logic
    print('Delete account');
  }

  void _onCancelService() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _CancelServiceConfirmDialog(),
    );

    if (result == true) {
      // User confirmed, show the info dialog
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => _CancelServiceInfoDialog(),
      );
      // TODO: Call your backend cancel logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = 48;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kMainHeadlineColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('My Profile', style: AppTextStyles.mainHeadline),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture with edit icon
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: NetworkImage(widget.avatarUrl),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kAccentColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Name
            _FieldLabel('Name'),
            _ProfileTextField(
              controller: nameController,
              hint: 'Enter your name',
            ),

            const SizedBox(height: 12),
            _FieldLabel('Number'),
            _ProfileTextField(
              controller: phoneController,
              hint: 'Enter your number',
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 12),
            _FieldLabel('Email ID'),
            _ProfileTextField(
              controller: emailController,
              hint: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 12),
            _FieldLabel('Address'),
            _ProfileTextField(
              controller: addressController,
              hint: 'Enter your address',
              maxLines: 2,
            ),

            const SizedBox(height: 24),

            // Delete Account
            GestureDetector(
              onTap: _onDeleteAccount,
              child: Row(
                children: [
                  const Icon(Icons.delete_outline, color: kErrorColor),
                  const SizedBox(width: 6),
                  Text(
                    'Delete Account',
                    style: AppTextStyles.mainHeadline.copyWith(
                      color: kErrorColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 0),
        child: SizedBox(
          width: 343,
          height: 45,
          child: ElevatedButton(
            onPressed: _onCancelService,
            style: ElevatedButton.styleFrom(
              backgroundColor: kErrorColor,
              foregroundColor: Colors.white,
              textStyle: AppTextStyles.filledButtonText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.zero,
            ),
            child: const Text('Cancel Service'),
          ),
        ),
      ),
    );
  }
}

// Helper for field label
class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 4),
        child: Text(label, style: AppTextStyles.textFieldHeadline),
      ),
    );
  }
}

// Helper for profile text fields
class _ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;

  const _ProfileTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppTextStyles.instructionText.copyWith(
        color: kMainHeadlineColor,
        fontSize: 15,
      ),
      decoration: baseTextFieldDecoration(hintText: hint),
    );
  }
}
class _CancelServiceConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Are you sure you want to cancel bus/van tracking service?",
              style: AppTextStyles.instructionText.copyWith(
                color: kMainHeadlineColor,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kMainHeadlineColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text("No"),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kErrorColor,
                        side: BorderSide(color: kErrorColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Yes",
                        style: TextStyle(color: kErrorColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CancelServiceInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded, color: kErrorColor, size: 48),
            const SizedBox(height: 12),
            Text(
              "Services will be canceled after current month ends.",
              style: AppTextStyles.instructionText.copyWith(
                color: kMainHeadlineColor,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMainHeadlineColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text("Ok"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

