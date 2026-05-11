import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:rms_shared_package/models/shift_models/shift_session.dart';

class SalaryCalculationResult {
  final double totalDue;
  final int totalMinutesWorked;
  final List<ShiftSession> processedShifts;
  final double lastPaidAmount;
  final int lastPaidMinutesWorked;

  SalaryCalculationResult({
    required this.totalDue,
    required this.totalMinutesWorked,
    required this.processedShifts,
    this.lastPaidAmount = 0.0,
    this.lastPaidMinutesWorked = 0,
  });
}

class CalculateSalaryUseCase {
  SalaryCalculationResult execute(
    StaffModel staff,
    List<ShiftSession> allShifts,
  ) {
    // 1. Calculate Unpaid/Due shifts
    final unpaidShifts = allShifts.where((shift) {
      if (shift.status != ShiftStatus.ended || shift.actualEnd == null) {
        return false;
      }
      if (shift.isPaid) return false;

      if (staff.lastPaidDate != null) {
        return shift.actualEnd!.isAfter(staff.lastPaidDate!);
      }
      return true;
    }).toList();

    int totalMinutes = _calculateMinutes(unpaidShifts);
    double totalDue = _calculateAmount(staff, unpaidShifts, totalMinutes);

    // 2. Calculate Last Paid History
    double lastPaidAmount = 0.0;
    int lastPaidMinutes = 0;

    final paidShifts = allShifts.where((s) => s.isPaid && s.payoutId != null).toList();
    if (paidShifts.isNotEmpty) {
      // Group by payoutId and find the most recent one based on actualEnd
      final Map<String, List<ShiftSession>> groups = {};
      for (var s in paidShifts) {
        groups.putIfAbsent(s.payoutId!, () => []).add(s);
      }

      final latestPayoutId = groups.keys.reduce((a, b) {
        final aEnd = groups[a]!.map((s) => s.actualEnd!).reduce((v, e) => v.isAfter(e) ? v : e);
        final bEnd = groups[b]!.map((s) => s.actualEnd!).reduce((v, e) => v.isAfter(e) ? v : e);
        return aEnd.isAfter(bEnd) ? a : b;
      });

      final latestPaidShifts = groups[latestPayoutId]!;
      lastPaidMinutes = _calculateMinutes(latestPaidShifts);
      lastPaidAmount = _calculateAmount(staff, latestPaidShifts, lastPaidMinutes);
    }

    return SalaryCalculationResult(
      totalDue: totalDue,
      totalMinutesWorked: totalMinutes,
      processedShifts: unpaidShifts,
      lastPaidAmount: lastPaidAmount,
      lastPaidMinutesWorked: lastPaidMinutes,
    );
  }

  int _calculateMinutes(List<ShiftSession> shifts) {
    int total = 0;
    for (var shift in shifts) {
      if (shift.workedMinutes > 0) {
        total += shift.workedMinutes;
      } else if (shift.actualStart != null && shift.actualEnd != null) {
        total += shift.actualEnd!.difference(shift.actualStart!).inMinutes;
      }
    }
    return total;
  }

  double _calculateAmount(StaffModel staff, List<ShiftSession> shifts, int minutes) {
    if (staff.baseWage == null || staff.baseWage! <= 0) return 0.0;

    if (staff.wageType == WageType.hourly) {
      return (minutes / 60.0) * staff.baseWage!;
    } else if (staff.wageType == WageType.monthly) {
      return shifts.isNotEmpty ? staff.baseWage! : 0.0;
    }
    return 0.0;
  }
}
