import 'package:get_it/get_it.dart';
import 'package:manager_portal/features/reports/domain/repositories/order_repository.dart';
import 'package:manager_portal/features/reports/data/repositories/order_repository_impl.dart';
import 'package:manager_portal/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:manager_portal/features/table_management/domain/repositories/table_repository.dart';

final getIt = GetIt.instance;

void setUpReportsDI() {
  // Repository
  getIt.registerLazySingleton<IOrderRepository>(
    () => OrderRepositoryImpl(getIt()),
  );

  // BLoC
  getIt.registerFactory(
    () => ReportsBloc(
      tableRepository: getIt<ITableRepository>(),
      orderRepository: getIt<IOrderRepository>(),
    ),
  );
}
