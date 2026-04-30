import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manager_portal/features/overview/domain/entities/timeframe.dart';
import 'package:rms_design_system/rms_design_system.dart';

class RMSDateRangePickerDialog extends StatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Timeframe initialTimeframe;

  const RMSDateRangePickerDialog({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.initialTimeframe,
  });

  static Future<Map<String, dynamic>?> show(
    BuildContext context, {
    DateTime? initialStartDate,
    DateTime? initialEndDate,
    required Timeframe initialTimeframe,
  }) {
    return showDialog<Map<String, dynamic>>(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => RMSDateRangePickerDialog(
        initialStartDate: initialStartDate,
        initialEndDate: initialEndDate,
        initialTimeframe: initialTimeframe,
      ),
    );
  }

  @override
  State<RMSDateRangePickerDialog> createState() => _RMSDateRangePickerDialogState();
}

class _RMSDateRangePickerDialogState extends State<RMSDateRangePickerDialog> {
  late DateTime _startDate;
  late DateTime _endDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late Timeframe _selectedTimeframe;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate ?? DateTime.now().subtract(const Duration(days: 7));
    _endDate = widget.initialEndDate ?? DateTime.now();
    _startTime = TimeOfDay.fromDateTime(_startDate);
    _endTime = TimeOfDay.fromDateTime(_endDate);
    _selectedTimeframe = widget.initialTimeframe;
  }

  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: PrimaryColors.defaultColor,
              onPrimary: Colors.white,
              surface: NeutralColors.surface,
              onSurface: TextColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          _selectedTimeframe = Timeframe.custom;
        } else {
          _endDate = picked;
          _selectedTimeframe = Timeframe.custom;
        }
      });
    }
  }

  Future<void> _pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: PrimaryColors.defaultColor,
              onPrimary: Colors.white,
              surface: NeutralColors.surface,
              onSurface: TextColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
          _selectedTimeframe = Timeframe.custom;
        } else {
          _endTime = picked;
          _selectedTimeframe = Timeframe.custom;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: NeutralColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: NeutralColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter by Range',
                    style: TextStyle(
                      color: TextColors.primary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: TextColors.secondary),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Presets',
                style: TextStyle(
                  color: TextColors.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: Timeframe.values.where((t) => t != Timeframe.custom).map((t) {
                  final isSelected = _selectedTimeframe == t;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedTimeframe = t;
                        // Update dates based on preset if needed, 
                        // but actually we'll handle this on Save.
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? PrimaryColors.defaultColor : NeutralColors.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? PrimaryColors.defaultColor : NeutralColors.border,
                        ),
                      ),
                      child: Text(
                        t.label,
                        style: TextStyle(
                          color: isSelected ? Colors.white : TextColors.secondary,
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              const Text(
                'Custom Date & Time',
                style: TextStyle(
                  color: TextColors.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: RmsTextField(
                      label: 'Start Date',
                      hintText: 'Select Date',
                      readOnly: true,
                      onTap: () => _pickDate(true),
                      controller: TextEditingController(text: dateFormat.format(_startDate)),
                      suffixIcon: const Icon(Icons.calendar_today, size: 18, color: TextColors.secondary),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: RmsTextField(
                      label: 'Start Time',
                      hintText: 'Select Time',
                      readOnly: true,
                      onTap: () => _pickTime(true),
                      controller: TextEditingController(text: _startTime.format(context)),
                      suffixIcon: const Icon(Icons.access_time, size: 18, color: TextColors.secondary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: RmsTextField(
                      label: 'End Date',
                      hintText: 'Select Date',
                      readOnly: true,
                      onTap: () => _pickDate(false),
                      controller: TextEditingController(text: dateFormat.format(_endDate)),
                      suffixIcon: const Icon(Icons.calendar_today, size: 18, color: TextColors.secondary),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: RmsTextField(
                      label: 'End Time',
                      hintText: 'Select Time',
                      readOnly: true,
                      onTap: () => _pickTime(false),
                      controller: TextEditingController(text: _endTime.format(context)),
                      suffixIcon: const Icon(Icons.access_time, size: 18, color: TextColors.secondary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: RmsButton(
                      text: 'Cancel',
                      isOutlined: true,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: RmsButton(
                      text: 'Apply Filter',
                      onPressed: () {
                        final finalStart = _combineDateAndTime(_startDate, _startTime);
                        final finalEnd = _combineDateAndTime(_endDate, _endTime);
                        Navigator.pop(context, {
                          'timeframe': _selectedTimeframe,
                          'startDate': finalStart,
                          'endDate': finalEnd,
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
