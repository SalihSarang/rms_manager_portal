import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/enums/enums.dart';

class ManualPayoutState extends Equatable {
  final PaymentMethod selectedMethod;
  final double incentive;
  final double deduction;
  final double baseAmount;

  const ManualPayoutState({
    required this.selectedMethod,
    required this.incentive,
    required this.deduction,
    required this.baseAmount,
  });

  double get finalAmount =>
      (baseAmount + incentive - deduction).clamp(0.0, double.infinity);

  factory ManualPayoutState.initial(double baseAmount) {
    return ManualPayoutState(
      selectedMethod: PaymentMethod.cash,
      incentive: 0.0,
      deduction: 0.0,
      baseAmount: baseAmount,
    );
  }

  ManualPayoutState copyWith({
    PaymentMethod? selectedMethod,
    double? incentive,
    double? deduction,
    double? baseAmount,
  }) {
    return ManualPayoutState(
      selectedMethod: selectedMethod ?? this.selectedMethod,
      incentive: incentive ?? this.incentive,
      deduction: deduction ?? this.deduction,
      baseAmount: baseAmount ?? this.baseAmount,
    );
  }

  @override
  List<Object?> get props => [selectedMethod, incentive, deduction, baseAmount];
}

class ManualPayoutCubit extends Cubit<ManualPayoutState> {
  ManualPayoutCubit(double baseAmount)
    : super(ManualPayoutState.initial(baseAmount));

  void updateMethod(PaymentMethod method) {
    emit(state.copyWith(selectedMethod: method));
  }

  void updateIncentive(String value) {
    final amount = double.tryParse(value) ?? 0.0;
    emit(state.copyWith(incentive: amount));
  }

  void updateDeduction(String value) {
    final amount = double.tryParse(value) ?? 0.0;
    emit(state.copyWith(deduction: amount));
  }
}
