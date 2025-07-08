import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/widgets/buttons/bottom_nav_btn.dart';
import 'package:rentica/screens/modal%20screens/gender_selection_modal.dart';
import 'package:rentica/screens/profile/widgets/profile_detail_field.dart';
import 'package:rentica/providers/user_provider.dart';

class YourProfileScreen extends ConsumerStatefulWidget {
  const YourProfileScreen({super.key});

  @override
  ConsumerState<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends ConsumerState<YourProfileScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;
  late TextEditingController _dobController;
  String? _selectedGenderLocally;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current user data from provider
    final userData = ref.read(userProvider);
    _fullNameController = TextEditingController(text: userData['fullName']);
    _phoneNumberController =
        TextEditingController(text: userData['phoneNumber']);
    _emailController = TextEditingController(text: userData['email']);
    _dobController = TextEditingController(text: userData['dob']);
    _selectedGenderLocally =
        userData['gender']; // Initialize local gender state
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  // Function to show Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? initialDate;
    try {
      if (_dobController.text.isNotEmpty && _dobController.text != 'DD/MM/YY') {
        initialDate = DateFormat('dd/MM/yy').parse(_dobController.text);
      }
    } catch (e) {
      initialDate = DateTime.now();
    }
    initialDate = initialDate?.isAfter(DateTime.now()) == true
        ? DateTime.now()
        : initialDate;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppStyles.primaryColor,
              onPrimary: AppStyles.whiteColor,
              onSurface: AppStyles.textBlack,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppStyles.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('dd/MM/yy').format(pickedDate);
      setState(() {
        _dobController.text = formattedDate; // Update local controller
      });
      // Important: Do NOT update Riverpod here. It will be updated on submit.
    }
  }

  // Gender Selection
  Future<void> _selectGender(BuildContext context) async {
    final String? selectedGender = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        // Pass the current LOCAL gender to the modal
        return GenderSelectionModal(currentGender: _selectedGenderLocally);
      },
    );

    if (selectedGender != null) {
      setState(() {
        _selectedGenderLocally =
            selectedGender; // Update local state for gender
      });
      // Important: Do NOT update Riverpod here. It will be updated on submit.
    }
  }

  // handle profile update submission
  void _updateProfile() {
    if (_formKey.currentState?.validate() == false) {
      //Todo: Form Validation
      // If validation fails, show error messages and return
      return;
    }

    final Map<String, dynamic> updatedData = {
      'fullName': _fullNameController.text,
      'phoneNumber': _phoneNumberController.text,
      'email': _emailController.text,
      'dob': _dobController.text,
      'gender': _selectedGenderLocally,
    };

    final userNotifier = ref.read(userProvider.notifier);
    userNotifier.updateUserData('fullName', updatedData['fullName']);
    userNotifier.updateUserData('phoneNumber', updatedData['phoneNumber']);
    userNotifier.updateUserData('email', updatedData['email']);
    userNotifier.updateUserData('dob', updatedData['dob']);
    userNotifier.updateUserData('gender', updatedData['gender']);

    // Todo: make API call here.
    // Example: await _userService.updateUserProfile(updatedData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.read(userProvider);

    return Scaffold(
      backgroundColor: AppStyles.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(AppIcons.arrowBack, color: AppStyles.textBlack),
        ),
        title: Text(
          'Your Profile',
          style: TextStyle(
            color: AppStyles.textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppStyles.whiteColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // User Profile Picture and Edit Button
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 85,
                    backgroundImage:
                        NetworkImage(userData['profileImageUrl'] ?? ''),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppStyles.primaryColor,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppStyles.whiteColor, width: 2),
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(5.0),
                        icon: Icon(AppIcons.edit,
                            color: AppStyles.whiteColor, size: 20),
                        onPressed: () {
                          // TODO: Implement edit profile picture functionality
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Name Field
              ProfileDetailField(
                label: 'Name',
                value: _fullNameController.text,
                isEditable: true,
                controller: _fullNameController,
                onChanged: (newValue) {/* Local controller handles it */},
                //Todo: Validation // validator: (value) { /* Add validation logic here */ return null; },
              ),
              const SizedBox(height: 20),

              // Phone Number Field
              ProfileDetailField(
                label: 'Phone Number',
                value: _phoneNumberController.text,
                isEditable: true,
                controller: _phoneNumberController,
                onChanged: (newValue) {/* Local controller handles it */},
                suffixWidget: TextButton(
                  onPressed: () {
                    //Todo: Implement phone number verification: Your Profile Screen
                  },
                  child: Text(
                    'Validate',
                    style:
                        TextStyle(color: AppStyles.primaryColor, fontSize: 14),
                  ),
                ),
                // validator: (value) { /* Add validation logic here */ return null; },
              ),
              const SizedBox(height: 20),

              // Email Field (Editable)
              ProfileDetailField(
                label: 'Email',
                value: _emailController.text,
                isEditable: true,
                controller: _emailController,
                onChanged: (newValue) {/* Local controller handles it */},
                // validator: (value) { /* Add validation logic here */ return null; },
              ),
              const SizedBox(height: 20),

              // DOB
              ProfileDetailField(
                label: 'DOB',
                value: _dobController.text,
                isEditable: true,
                controller: _dobController,
                onTap: () => _selectDate(context),
                suffixWidget:
                    Icon(AppIcons.edit, color: AppStyles.textGrey, size: 20),
                // validator: (value) { /* Add validation logic here */ return null; },
              ),
              const SizedBox(height: 20),

              // Gender Field (Modal Selection)
              ProfileDetailField(
                label: 'Gender',
                value: _selectedGenderLocally ?? 'Select',
                isSelectable: true,
                isEditable: true,
                onTap: () => _selectGender(context),
                // validator: (value) { /* Add validation logic here */ return null; },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: _updateProfile,
        child: BottomNavBtn(labelText: "Update Profile", showPrice: false),
      ),
    );
  }
}
