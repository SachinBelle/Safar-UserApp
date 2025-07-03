part of 'otp_verification_bloc.dart';

@immutable
abstract class OtpVerificationState {}

class OtpVerificationInitial extends OtpVerificationState {}

class OtpSend extends OtpVerificationState{

}

class OtpVerifing extends OtpVerificationState{

}

class WrongOtp extends OtpVerificationState{

}

class ResendOtp extends OtpVerificationState{

}