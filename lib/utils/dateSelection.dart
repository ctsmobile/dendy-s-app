import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeDialog extends StatefulWidget {
  final Function(DateTime start, DateTime end) onDateRangeSelected;
  const DateRangeDialog({super.key, required this.onDateRangeSelected});

  @override
  State<DateRangeDialog> createState() => _DateRangeDialogState();
}

class _DateRangeDialogState extends State<DateRangeDialog> {
  DateTime? startDate;
  DateTime? endDate;

  Future<void> selectDate(bool isStart) async {
    final now = DateTime.now();

  final firstDate = isStart
      ? DateTime(2000)
      : ( startDate ?? DateTime(2000));

  final initialDate = isStart
      ? now
      : (now.isBefore(firstDate) ? firstDate : now); 
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: DateTime(2100),
  );
    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          startDate = pickedDate;
          if (endDate != null && endDate!.isBefore(startDate!)) {
            endDate = null; // reset invalid end date
          }
        } else {
          endDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => selectDate(true),
            child: Text(startDate == null
                ? 'Select Start Date'
                : DateFormat('MM/dd/yyyy').format(DateTime.parse('${startDate!.toLocal()}'.split(' ')[0]))),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: startDate != null ? () => selectDate(false) : null,
            child: Text(endDate == null
                ? 'Select End Date'
                : DateFormat('MM/dd/yyyy').format(DateTime.parse('${endDate!.toLocal()}'.split(' ')[0]))),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: startDate != null && endDate != null
              ? () {
                  widget.onDateRangeSelected(startDate!, endDate!);
                  Navigator.of(context).pop();
                }
              : null,
          child: Text('OK'),
        ),
      ],
    );
  }
}
