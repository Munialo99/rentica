import 'package:flutter/material.dart';
import 'package:rentica/base/data/mock%20data/cancellation_reasons_data.dart';
import 'package:rentica/base/res/app_icons.dart';
import 'package:rentica/base/res/app_styles.dart';

class CancelRideModalScreen extends StatefulWidget {
  final String bookingId;
  final String carName;

  const CancelRideModalScreen({
    super.key,
    required this.bookingId,
    required this.carName,
  });

  @override
  State<CancelRideModalScreen> createState() => _CancelRideModalScreenState();
}

class _CancelRideModalScreenState extends State<CancelRideModalScreen> {
  String? _selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.9,
            decoration: BoxDecoration(
              color: AppStyles.whiteColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(AppIcons.arrowBack),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Cancel Car Rental',
                          style: AppStyles.headlineStyle2.copyWith(
                              color: AppStyles.textBlack),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 48), // balance the back arrow
                    ],
                  ),
                ),
                Divider(height: 1, color: AppStyles.disabledGrey),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Please select the reason for cancellation:',
                          style: AppStyles.textStyle.copyWith(
                            color: AppStyles.textDarkGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...kCancellationReasons.map((reason) {
                          return RadioListTile<String>(
                            title: Text(
                              reason,
                              style: AppStyles.textStyle.copyWith(
                                  color: AppStyles.textBlack),
                            ),
                            value: reason,
                            groupValue: _selectedReason,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedReason = value;
                                if (value != 'Other') {
                                  _otherReasonController.clear();
                                }
                              });
                            },
                            activeColor: AppStyles
                                .primaryColor,
                          );
                        }).toList(),
                        const SizedBox(height: 20),
                        if (_selectedReason == 'Other')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Other',
                                style: AppStyles.textStyle.copyWith(
                                  color: AppStyles.textBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppStyles.whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppStyles.textGrey.withValues(
                                          alpha: 0.5)),
                                ),
                                child: TextField(
                                  controller: _otherReasonController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your Reason',
                                    hintStyle: AppStyles.textStyle4.copyWith(
                                        color: AppStyles.textGrey, fontWeight: FontWeight.w400),
                                    border: InputBorder
                                        .none, // Remove default border
                                  ),
                                  style: AppStyles.textStyle.copyWith(
                                      color: AppStyles.textBlack),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                // Confirm Cancellation Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      _confirmCancellation(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppStyles.cancelRed,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Confirm Cancellation',
                        style: AppStyles.textStyle.copyWith(
                          color: AppStyles.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
          ;
        }
    );
  }

  void _confirmCancellation(BuildContext context) {
    String finalReason = _selectedReason ?? 'No reason selected';
    if (_selectedReason == 'Other' && _otherReasonController.text.isNotEmpty) {
      finalReason = 'Other: ${_otherReasonController.text.trim()}';
    }

    if (_selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a cancellation reason.'),
          backgroundColor: AppStyles.cancelRed,
        ),
      );
      return;
    }

    // Todo: Implement actual cancellation logic
    print('Booking ID: ${widget.bookingId}');
    print('Car Name: ${widget.carName}');
    print('Cancellation Reason: $finalReason');

    // pass data back to the previous screen if needed
    Navigator.pop(context, finalReason);
  }
}