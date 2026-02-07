import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:substore_app/features/auth/domain/usecases/get_user_logged_usecase.dart';
import 'package:substore_app/features/store_report/domain/entities/store_report.dart';
import 'package:substore_app/features/store_report/domain/useCases/get_store_report_data_usecase.dart';
import 'package:substore_app/features/users/domain/entities/user.dart';
import 'package:substore_app/shared/utils/cubit_utils.dart';

part 'store_report_state.dart';

class StoreReportCubit extends Cubit<StoreReportState> {
  final GetUserLoggedUseCase getUserLoggedUseCase;
  final GetStoreReportDataUsecase getStoreReportDataUsecase;
  StoreReportCubit(this.getUserLoggedUseCase, this.getStoreReportDataUsecase) : super(StoreReportInitial());

  Future<void> getStoreReportData() async {
    try {
      safeEmit(StoreReportLoading());
      final User? user = await getUserLoggedUseCase.call();
      if (user == null || user.store == null) return safeEmit(StoreReportInvalidParamsError());

      final storeReport = await getStoreReportDataUsecase.call(storeId: user.store!.id);
      safeEmit(StoreReportData(storeReport: storeReport));
    } catch (error) {
      addError(error);
      safeEmit(StoreReportError());
    }
  }
}
