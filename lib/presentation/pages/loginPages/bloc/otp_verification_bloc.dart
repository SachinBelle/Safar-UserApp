import 'dart:async';

import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  OtpVerificationBloc() : super(OtpVerificationInitial());

  @override
  // ignore: override_on_non_overriding_member
  Stream<OtpVerificationState> mapEventToState(
    OtpVerificationEvent event,
  ) async* {
 
    
  }
}
