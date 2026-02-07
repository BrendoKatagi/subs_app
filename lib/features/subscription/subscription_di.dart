import 'package:get_it/get_it.dart';
import 'package:substore_app/features/subscription/domain/usecases/subscription_check_in_usecase.dart';
import 'package:substore_app/features/subscription/presentation/cubit/check_in_cubit.dart';

class SubscriptionDI {
  static Future<void> register() async {
    GetIt.I.registerFactory<SubscriptionCheckInUseCase>(
      () => SubscriptionCheckInUseCase(
        userSubscriptionRepository: GetIt.I.get(),
      ),
    );
    GetIt.I.registerFactory<CheckInCubit>(
      () => CheckInCubit(
        subscriptionCheckInUseCase: GetIt.I.get(),
      ),
    );
  }
}
