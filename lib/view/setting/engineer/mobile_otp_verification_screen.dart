import 'dart:async';

import 'package:ag_widgets/ag_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/images.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/otp_theme.dart';

class MobileOtpVerificationScreen extends StatefulWidget {
  final String? mobileNumber;
  final String? countryCode;

  const MobileOtpVerificationScreen({super.key, this.mobileNumber, this.countryCode});

  @override
  State<MobileOtpVerificationScreen> createState() => _MobileOtpVerificationScreenState();
}

class _MobileOtpVerificationScreenState extends State<MobileOtpVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> otpFormState = GlobalKey();
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  String verificationId = "";
  int? resendToken;
  Stream<int>? _timerStream;
  late StreamController<int> _streamController;
  Timer? _timer;
  int _remainingTime = 60;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future.delayed(Duration(seconds: 1));
        try {
          sendOTP();
        } on Exception catch (e) {
          mainLog(
            message: "error after try catch $e",
          );
        }
      },
    );
  }

  void _startTimer() {
    _remainingTime = 60;
    _streamController = StreamController<int>();
    _timerStream = _streamController.stream;
    _streamController.add(_remainingTime);

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        _streamController.add(_remainingTime);
      } else {
        timer.cancel();
        _streamController.close();
      }
    });
  }

  Future<void> verifyOTP() async {
    if (!otpFormState.currentState!.validate()) return;

    try {
      appLoaderStore.appLoadingState[AppLoaderStateName.mobileOtpApiState] = true;

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text.trim(),
      );

      await _auth.signInWithCredential(credential);
      toast("OTP Verified Successfully");
      appLoaderStore.appLoadingState[AppLoaderStateName.mobileOtpApiState] = false;

      _auth.signOut();
      _streamController.close();

      // Navigator.pop(context); // Navigate back after verification
    } catch (e) {
      _streamController.close();
      appLoaderStore.appLoadingState[AppLoaderStateName.mobileOtpApiState] = false;

      toast("Invalid OTP. Please try again.");
    }
  }

  Future<void> sendOTP({bool isResend = false}) async {
    mainLog(message: 'entered sendOTP()');
    appLoaderStore.appLoadingState[AppLoaderStateName.mobileOtpApiState] = true;
    mainLog(message: 'loader starts');

    try {
      mainLog(message: 'entered in try');
      await _auth.verifyPhoneNumber(
        phoneNumber: "+${widget.countryCode.validate()}" + widget.mobileNumber.validate(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          mainLog(message: 'verificationCompleted');
          toast("OTP Auto Verified");
          appLoaderStore.appLoadingState[AppLoaderStateName.mobileOtpApiState] = false;

          await _auth.signInWithCredential(credential);
          await personalDetailsStore.onMobileVerificationSubmit(true);

          Navigator.pop(context);
        },
        verificationFailed: (FirebaseAuthException e) {
          mainLog(message: 'verificationFailed');
          appLoaderStore.appLoadingState[AppLoaderStateName.mobileOtpApiState] = false;
          toast("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          mainLog(message: 'codeSent');
          setState(() {
            this.verificationId = verificationId;
            this.resendToken = resendToken;
          });
          _startTimer();
          appLoaderStore.appLoadingState[AppLoaderStateName.mobileOtpApiState] = false;

          toast("OTP sent to ${widget.countryCode.validate()}${widget.mobileNumber.validate()}");
        },
        timeout: Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          mainLog(message: 'codeAutoRetrievalTimeout');
          setState(() {
            this.verificationId = verificationId;
          });
          toast("Code auto-retrieval timeout");
        },
        forceResendingToken: isResend ? resendToken : null,
      );
    } on Exception catch (e) {
      print("🔥 Exception in verifyPhoneNumber: $e");
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: commonAppBarWidget("Verify your number"),
        body: AppScaffoldWithLoader(
          isLoading: false,
          child: Form(
            key: otpFormState,
            child: AnimatedScrollView(
              crossAxisAlignment: CrossAxisAlignment.start,
              padding: EdgeInsets.all(16),
              children: [
                32.height,
                AppSvgIcons.icMobileVerification.agLoadImage(height: context.height() * 0.3, width: context.width(), fit: BoxFit.contain).center(),
                32.height,
                Wrap(
                  children: [
                    Text("Enter OTP sent to ", style: secondaryTextStyle(size: 16)),
                    Text("${widget.countryCode != null && widget.countryCode!.isNotEmpty ? "+${widget.countryCode}${widget.mobileNumber}" : '${widget.mobileNumber}'}", style: boldTextStyle(size: 16)),
                  ],
                ).center(),
                16.height,
                Pinput(
                  controller: otpController,
                  focusNode: otpFocusNode,
                  defaultPinTheme: defaultPinTheme,
                  length: 6,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  validator: (value) {
                    if (value.validate().isEmpty) return errorThisFieldRequired;
                    return null;
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) => verifyOTP(),
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: focusedPinTheme,
                  errorPinTheme: errorPinTheme,
                ),
                32.height,
                StreamBuilder<int>(
                  stream: _timerStream,
                  builder: (context, snap) {
                    if (!snap.hasData || snap.connectionState == ConnectionState.waiting) {
                      return SizedBox.shrink();
                    }

                    return RichTextWidget(
                      list: [
                        TextSpan(text: "Didn’t receive the code?", style: secondaryTextStyle(size: 14)),
                        snap.connectionState == ConnectionState.done
                            ? TextSpan(
                                text: " Resend OTP",
                                style: boldTextStyle(color: context.primaryColor, size: 14, fontStyle: FontStyle.italic),
                                recognizer: TapGestureRecognizer()..onTap = () => sendOTP(isResend: true),
                              )
                            : TextSpan(
                                text: " 00:${snap.data}",
                                style: boldTextStyle(color: Colors.red, size: 14, fontStyle: FontStyle.italic),
                              ),
                      ],
                    ).center();
                  },
                ),
                40.height,
                Observer(
                  builder: (context) {
                    return ButtonAppLoader(
                      isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.mobileOtpApiState].validate(),
                      child: AppButton(
                        width: context.width(),
                        text: "Verify OTP",
                        onTap: () => verifyOTP(),
                      ),
                    );
                  },
                ),
                32.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
