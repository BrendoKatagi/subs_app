part of 'store_report_cubit.dart';

sealed class StoreReportState extends Equatable {
  const StoreReportState();

  @override
  List<Object> get props => [];
}

final class StoreReportInitial extends StoreReportState {}

final class StoreReportLoading extends StoreReportState {}

final class StoreReportError extends StoreReportState {}

final class StoreReportInvalidParamsError extends StoreReportState {}

final class StoreReportData extends StoreReportState {
  final StoreReport storeReport;

  const StoreReportData({required this.storeReport});
}
