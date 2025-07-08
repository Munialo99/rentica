import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rentica/base/res/app_styles.dart';
import 'package:rentica/providers/booking_provider.dart';
import 'package:rentica/base/utils/enums.dart';

class DateTimeSelector extends ConsumerStatefulWidget {
  final DateType type;
  final Map<String, dynamic> carData;

  const DateTimeSelector({
    super.key,
    required this.type,
    required this.carData,
  });

  @override
  ConsumerState<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends ConsumerState<DateTimeSelector> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize fields from provider if data already exists
    _updateControllersFromState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _updateControllersFromState() {
    final bookingState = ref.read(bookingProvider(widget.carData));
    final initialDateTime = widget.type == DateType.pickup
        ? bookingState.pickUpDate
        : bookingState.returnDate;

    if (initialDateTime != null) {
      _selectedDate = initialDateTime;
      _selectedTime = TimeOfDay.fromDateTime(initialDateTime);
      _dateController.text = DateFormat.yMMMd().format(initialDateTime);
      _timeController.text = _selectedTime!.format(context);
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat.yMMMd().format(picked);
        _selectedTime = null;
        _timeController.clear();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date first.")),
      );
      return;
    }

    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {

      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });

      final finalDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final notifier = ref.read(bookingProvider(widget.carData).notifier);
      if (widget.type == DateType.pickup) {
        notifier.updatePickUpDate(finalDateTime);
      } else {
        notifier.updateReturnDate(finalDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the provider to reflect external changes
    ref.listen(bookingProvider(widget.carData), (_, __) {
      _updateControllersFromState();
    });

    return Row(
      children: [
        // Date Field
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.calendar_today,
                      size: 18, color: AppStyles.primaryColor),
                  hintText: 'Select Date',
                  filled: true,
                  fillColor: AppStyles.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Time Field
        Expanded(
          child: GestureDetector(
            onTap: () => _selectTime(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: _timeController,
                readOnly: true,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  prefixIcon: Icon(Icons.alarm_rounded,
                      size: 18, color: AppStyles.primaryColor),
                  hintText: 'Select Time',
                  filled: true,
                  fillColor: AppStyles.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}