import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:substore_app/features/subscription/domain/usecases/subscription_check_in_usecase.dart';
import 'package:substore_app/shared/utils/cubit_utils.dart';

part 'check_in_state.dart';

class CheckInCubit extends Cubit<CheckInState> {
  final SubscriptionCheckInUseCase subscriptionCheckInUseCase;
  CheckInCubit({required this.subscriptionCheckInUseCase}) : super(CheckInInitial());

  void onCheckInSuccess() => safeEmit(CheckInSuccess());

  void onCheckInError() {
    subscriptionCheckInUseCase.cancelSubscription();
    safeEmit(CheckInError());
  }

  void cancelCheckInSubscription() => subscriptionCheckInUseCase.cancelSubscription();

  void listenToCheckIn(String checkinId) {
    safeEmit(CheckInInitial());
    try {
      subscriptionCheckInUseCase.call(checkinId: checkinId, onSuccess: onCheckInSuccess, onError: onCheckInError);
    } catch (error) {
      addError(error);
      onCheckInError();
    }
  }
}
