import 'dart:developer';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/payout_model/payout_model.dart';

abstract class PayoutRemoteDataSource {
  /// Processes a salary payout.
  Future<PayoutModel> processPayout({
    required String staffId,
    required double amount,
    required DateTime periodStart,
    required DateTime periodEnd,
    required PaymentMethod paymentMethod,
    String? notes,
  });
}

class PayoutRemoteDataSourceImpl implements PayoutRemoteDataSource {
  @override
  Future<PayoutModel> processPayout({
    required String staffId,
    required double amount,
    required DateTime periodStart,
    required DateTime periodEnd,
    required PaymentMethod paymentMethod,
    String? notes,
  }) async {
    log('Processing payout for staff $staffId via ${paymentMethod.name}...');

    // Simulate network delay or Firestore write delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock successful response or Firestore document creation logic
    final mockId = DateTime.now().millisecondsSinceEpoch.toString();
    final mockTransactionId = paymentMethod == PaymentMethod.cash
        ? 'cash_${DateTime.now().millisecondsSinceEpoch}'
        : 'manual_${DateTime.now().millisecondsSinceEpoch}';

    log('Payout recorded successfully. ID: $mockId');

    return PayoutModel(
      id: mockId,
      staffId: staffId,
      amount: amount,
      currency: 'INR',
      gatewayTransactionId: mockTransactionId,
      paymentMethod: paymentMethod,
      notes: notes,
      status: PayoutStatus.success,
      timestamp: DateTime.now(),
      periodStart: periodStart,
      periodEnd: periodEnd,
    );
  }
}
