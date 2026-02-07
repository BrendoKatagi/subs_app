import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:substore_app/features/users/data/models/user_registration_model.dart';
import 'package:substore_app/features/users/domain/usecases/register_user_usecase.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final RegisterUserUseCase _registerUserUsecase;

  SignUpCubit(this._registerUserUsecase) : super(const SignUpInitial());

  Future<void> signUp(UserRegistrationModel userData) async {
    try {
      emit(const SignUpLoading());

      final bool result = await _registerUserUsecase.call(userData: userData);

      if (result) {
        emit(const SignUpSuccess());
        return;
      }
      emit(const SignUpError());
    } catch (error) {
      emit(const SignUpError());
      addError(error);
    }
  }
}
