import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/login_response.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/auth_body_widget.dart';
import 'package:ticky/utils/widgets/otp_theme.dart';

class OtpVerificationScreen extends StatefulWidget {
  final LoginResponse loginResponse;
  final bool? isForgotPassword;
  final bool? isFromLogin;

  const OtpVerificationScreen({Key? key, required this.loginResponse, this.isForgotPassword, this.isFromLogin}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  GlobalKey<FormState> otpFormState = GlobalKey();

  TextEditingController otpCont = TextEditingController();

  FocusNode otpFocusNode = FocusNode();

  late Stream<int> _timerStream;
  late StreamController<int> _streamController;
  Timer? _timer;
  int _remainingTime = 60;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: boldTextStyle(),
    decoration: BoxDecoration(
      borderRadius: radius(),
      border: Border.all(color: borderColor),
    ),
  );

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    _streamController = StreamController<int>();
    _timerStream = _streamController.stream;
    if (widget.isFromLogin.validate()) {
      await signupStore.sendEmailOtp(email: widget.loginResponse.user!.email.validate());
      _startTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    _remainingTime = 60; // Reset timer to 1 minute
    _streamController.add(_remainingTime);

    _timer?.cancel(); // Cancel any existing timer
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

  void _restartTimer() {
    _timer?.cancel(); // Cancel current timer
    _streamController.close(); // Close current stream
    setState(() {
      init(); // Reinitialize timer
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _timer?.cancel();
    if (!_streamController.isClosed) _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Observer(
          builder: (context) {
            return AppScaffoldWithLoader(
              isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.loginApiState].validate(),
              child: AuthBodyWidget(
                title: widget.isForgotPassword.validate() ? "OTP to Reset Password 🔑" : "Verify Your Email ✉️",
                subTitle: widget.loginResponse.user != null ? "Enter the OTP sent to your email: ${maskEmail(widget.loginResponse.user!.email.validate())}." : "",
                child: Form(
                  key: otpFormState,
                  child: AnimatedScrollView(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    padding: EdgeInsets.all(16),
                    children: [
                      32.height,
                      Text('Enter Verification Code', style: secondaryTextStyle()),
                      16.height,
                      Pinput(
                        controller: otpCont,
                        focusNode: otpFocusNode,
                        defaultPinTheme: defaultPinTheme,
                        length: 6,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        validator: (value) {
                          if (value.toString().validate().isEmpty) return errorThisFieldRequired;
                          return null;
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) => verifyOtp(),
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: focusedPinTheme,
                        errorPinTheme: errorPinTheme,
                      ),
                      16.height,
                      Observer(builder: (context) {
                        if (signupStore.otpCode.validate().isNotEmpty) {
                          return Text('My Current OTP : - ${signupStore.otpCode.validate()}', style: boldTextStyle());
                        }
                        return Text('My Current OTP : - ${widget.loginResponse.otp}', style: boldTextStyle());
                      }),
                      32.height,
                      AppButton(width: context.width(), text: "Verify OTP", onTap: verifyOtp),
                      32.height,
                      StreamBuilder<int>(
                        stream: _timerStream,
                        initialData: _remainingTime,
                        builder: (context, snap) {
                          return RichTextWidget(
                            list: [
                              TextSpan(text: "Didn’t receive the code?", style: secondaryTextStyle(size: 14)),
                              snap.hasData
                                  ? snap.connectionState == ConnectionState.done
                                      ? TextSpan(
                                          text: " Resend OTP",
                                          style: boldTextStyle(color: context.primaryColor, size: 14, fontStyle: FontStyle.italic),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              if (widget.loginResponse.user != null) {
                                                await signupStore.sendEmailOtp(email: widget.loginResponse.user!.email.validate());
                                                _restartTimer();
                                              } else {
                                                toast("Email Id Not available");
                                              }
                                            },
                                        )
                                      : TextSpan(
                                          text: " 00:${snap.data}",
                                          style: boldTextStyle(color: Colors.red, size: 14, fontStyle: FontStyle.italic),
                                        )
                                  : TextSpan(
                                      text: "",
                                      style: boldTextStyle(color: context.primaryColor, size: 14, fontStyle: FontStyle.italic),
                                    ),
                            ],
                          ).center();
                        },
                      ),
                      32.height,
                    ],
                  ),
                ),
              ),
            );
          },
        ).paddingTop(context.statusBarHeight + 16),
      ),
    );
  }

  verifyOtp() async {
    if (otpFormState.currentState!.validate()) {
      otpFormState.currentState!.save();
      signupStore.verifyOtp(loginData: widget.loginResponse, otp: otpCont.text.validate().trim(), isForgotPassword: widget.isForgotPassword);
    }
  }
}
