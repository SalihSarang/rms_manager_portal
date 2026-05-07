import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:rms_shared_package/models/shift_models/shift_session.dart';

class SalaryCalculationResult {
  final double totalDue;
  final int totalMinutesWorked;
  final List<ShiftSession> processedShifts;

  SalaryCalculationResult({
    required this.totalDue,
    required this.totalMinutesWorked,
    required this.processedShifts,
  });
}

class CalculateSalaryUseCase {
  SalaryCalculationResult execute(
    StaffModel staff,
    List<ShiftSession> allShifts,
  ) {
    if (staff.baseWage == null || staff.baseWage! <= 0) {
      return SalaryCalculationResult(
        totalDue: 0.0,
        totalMinutesWorked: 0,
        processedShifts: [],
      );
    }

    // Filter shifts that were completed after the lastPaidDate
    final unpaidShifts = allShifts.where((shift) {
      if (shift.status != ShiftStatus.ended || shift.actualEnd == null) {
        return false;
      }
      if (staff.lastPaidDate != null) {
        return shift.actualEnd!.isAfter(staff.lastPaidDate!);
      }
      return true;
    }).toList();

    int totalMinutes = 0;
    for (var shift in unpaidShifts) {
      totalMinutes += shift.workedMinutes;
    }

    double totalDue = 0.0;
    if (staff.wageType == WageType.hourly) {
      final hoursWorked = totalMinutes / 60.0;
      totalDue = hoursWorked * staff.baseWage!;
    } else if (staff.wageType == WageType.monthly) {
      // Basic monthly wage processing (assumes full payout if triggered, 
      // though typically this would be prorated based on attendance)
      // For MVP, if there are any unpaid shifts, the monthly wage is due.
      totalDue = unpaidShifts.isNotEmpty ? staff.baseWage! : 0.0;
    }

    return SalaryCalculationResult(
      totalDue: totalDue,
      totalMinutesWorked: totalMinutes,
      processedShifts: unpaidShifts,
    );
  }
}
