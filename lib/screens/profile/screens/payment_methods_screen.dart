import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rentica/base/res/app_images.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/widgets/dialogs/update_mpesa_number_dialog.dart';
import 'package:rentica/providers/user_provider.dart';

class PaymentMethodsScreen extends ConsumerStatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  ConsumerState<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends ConsumerState<PaymentMethodsScreen> {
  late TextEditingController _mpesaNumberController;

  @override
  void initState() {
    super.initState();
    final userData = ref.read(userProvider);
    _mpesaNumberController = TextEditingController(text: userData['mpesaNumber'] ?? 'Not set');
  }

  @override
  void dispose() {
    _mpesaNumberController.dispose();
    super.dispose();
  }

  Future<void> _showUpdateMpesaNumberDialog() async {
    final String? newNumber = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return UpdateMpesaNumberDialog(currentNumber: ref.read(userProvider)['mpesaNumber'] ?? '');
      },
    );

    if (newNumber != null && newNumber.isNotEmpty) {
      ref.read(userProvider.notifier).updateUserData('mpesaNumber', newNumber);
      _mpesaNumberController.text = newNumber;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('M-Pesa number updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider);
    final String currentMpesaNumber = userData['mpesaNumber'] ?? 'Not set';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_mpesaNumberController.text != currentMpesaNumber) {
        _mpesaNumberController.text = currentMpesaNumber;
      }
    });

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
          'Payment Methods',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Mobile Money Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Mobile Money',
                style: AppStyles.headlineStyle3.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppStyles.textBlack,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Update Payment Number Row
            _buildMpesaNumberRow(currentMpesaNumber), // Pass current number
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMpesaNumberRow(String mpesaNumber) {
    return GestureDetector(
      onTap: _showUpdateMpesaNumberDialog,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: AppStyles.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.network(
              AppImages.mpesaLogo,
              height: 30, // Adjust size as needed
              width: 30,
              errorBuilder: (context, error, stackTrace) {
                return Icon(AppIcons.phoneIcon, color: AppStyles.primaryColor, size: 30);
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'M-Pesa Number', // Display label
                    style: AppStyles.textStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppStyles.textGrey,
                    ),
                  ),
                  Text(
                    mpesaNumber, // Display the current M-Pesa number
                    style: AppStyles.textStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppStyles.textBlack,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppStyles.textGrey),
          ],
        ),
      ),
    );
  }
}