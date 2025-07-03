part of 'otp_verification_bloc.dart';

@immutable
abstract class OtpVerificationEvent {}

class SendOtp extends OtpVerificationEvent{
  


}

class VerifiyOtp extends OtpVerificationEvent{
  final String inputOtp;
  VerifiyOtp(this.inputOtp);
}

