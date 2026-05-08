import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';

class PayrollUtils {
  static List<StaffModel> filterStaff({
    required List<StaffModel> staffList,
    required Map<String, SalaryCalculationResult> calculationResults,
    required WageType? selectedWageType,
    required String selectedStatus,
  }) {
    return staffList.where((staff) {
      final result = calculationResults[staff.id];
      if (result == null) return false;

      // Wage Type Filter
      if (selectedWageType != null && staff.wageType != selectedWageType) {
        return false;
      }

      // Status Filter
      if (selectedStatus == 'Pending' && result.totalDue <= 0) {
        return false;
      }
      if (selectedStatus == 'Completed' && result.totalDue > 0) {
        return false;
      }

      return true;
    }).toList();
  }
}
