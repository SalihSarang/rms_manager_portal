import 'dart:developer';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/payout_model/payout_model.dart';

abstract class PayoutRemoteDataSource {
  /// Initiates a salary payout via the payment gateway.
  Future<PayoutModel> processPayout({
    required String staffId,
    required double amount,
    required DateTime periodStart,
    required DateTime periodEnd,
  });
}

class PayoutRemoteDataSourceImpl implements PayoutRemoteDataSource {
  @override
  Future<PayoutModel> processPayout({
    required String staffId,
    required double amount,
    required DateTime periodStart,
    required DateTime periodEnd,
  }) async {
    log('Initiating RazorpayX payout for staff $staffId...');
    
    // Simulate network delay for API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock successful response
    final mockId = DateTime.now().millisecondsSinceEpoch.toString();
    final mockTransactionId = 'pout_$mockId';
    
    log('RazorpayX payout successful. Transaction ID: $mockTransactionId');

    return PayoutModel(
      id: mockId,
      staffId: staffId,
      amount: amount,
      currency: 'INR',
      gatewayTransactionId: mockTransactionId,
      status: PayoutStatus.success,
      timestamp: DateTime.now(),
      periodStart: periodStart,
      periodEnd: periodEnd,
    );
  }
}
