import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc() : super(OtpVerificationInitial());

  @override
  Stream<OtpVerificationState> mapEventToState(
    OtpVerificationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
