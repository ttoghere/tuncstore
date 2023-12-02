import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tuncstore/repositories/auth/auth_repository.dart';

part 'password_reset_state.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  final AuthRepository _authRepository;

  PasswordResetCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(PasswordResetInitial());

  void passwordReset(
      {required String email, required BuildContext context}) async {
    emit(PasswordResetLoading());

    try {
      _authRepository.sendPasswordResetEmail(email: email, context: context);
      emit(PasswordResetSuccess());
    } catch (e) {
      emit(PasswordResetFailure(error: 'Bir hata oluştu.'));
    }
  }
}
