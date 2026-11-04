import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/tokens/tokens.dart';
import '../../../../core/router/page_transitions.dart';
import '../../../home/presentation/screens/home.dart';
import '../../../onboarding/presentation/screens/registration.dart';

// ── Widget Imports
import '../widgets/auth_header.dart';
import '../widgets/otp_gradient.dart';
import '../widgets/user_type_toggle.dart';
import '../widgets/auth_text_fields.dart';
import '../widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showOTP = false;
  String userType = "creative"; // "creative" | "brand"

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String selectedCountryCode = "+91";

  // 6-digit OTP Controllers and Focus Nodes
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;
  int _secondsLeft = 42;

  String? _phoneError;
  String? _emailError;
  String? _otpError;

  @override
  void dispose() {
    _timer?.cancel();
    phoneController.dispose();
    emailController.dispose();
    for (final c in otpControllers) {
      c.dispose();
    }
    for (final f in otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _secondsLeft = 42;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  String get _formattedTime {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  String? _validatePhone(String val) {
    final digits = val.trim();
    if (digits.isEmpty) return "Mobile number is required";
    if (digits.length != 10) return "Enter a valid 10-digit mobile number";
    final first = int.tryParse(digits[0]) ?? 0;
    if (first <= 5) return "Number must start with 6, 7, 8 or 9";
    return null;
  }

  String? _validateEmail(String val) {
    final email = val.trim();
    if (email.isEmpty) return "Business email is required";
    final regex = RegExp(r'^[\w.+\-]+@[a-zA-Z\d\-]+\.[a-zA-Z\d\-.]+$');
    if (!regex.hasMatch(email)) return "Enter a valid email address";
    return null;
  }

  bool get _otpComplete => otpControllers.every((c) => c.text.isNotEmpty);

  void _handleSendCode() {
    if (userType == "brand") {
      final err = _validateEmail(emailController.text);
      if (err != null) {
        setState(() => _emailError = err);
        return;
      }
    } else {
      final err = _validatePhone(phoneController.text);
      if (err != null) {
        setState(() => _phoneError = err);
        return;
      }
    }

    setState(() {
      _phoneError = null;
      _emailError = null;
      _otpError = null;
    });
    _startTimer();
    setState(() => showOTP = true);
  }

  void _handleVerifyOtp() {
    if (!_otpComplete) {
      setState(() => _otpError = "Please enter all 6 digits");
      return;
    }
    setState(() => _otpError = null);

    Navigator.pushReplacement(
      context,
      PageTransitions.fade(const HomePage()),
    );
  }

  Widget _buildOtpBox(int index) {
    const Color kGreenDark = Color(0xff15503F);
    const Color kNavyDark = Color(0xff14213D);
    const Color kLightGreenBg = Color(0xffE6F7EF);
    const Color kFieldGray = Color(0xffF3F4F6);
    const Color kMint = Color(0xff2EBF91);
    const Color kBorderGray = Color(0xffE5E7EB);

    final controller = otpControllers[index];
    final focusNode = otpFocusNodes[index];
    final hasValue = controller.text.isNotEmpty;

    return SizedBox(
      width: 44,
      height: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: AppTypography.fontFamilySans,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: hasValue ? kGreenDark : kNavyDark,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          setState(() => _otpError = null);
          if (value.length == 1 && index < otpFocusNodes.length - 1) {
            FocusScope.of(context).requestFocus(otpFocusNodes[index + 1]);
          }
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(otpFocusNodes[index - 1]);
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: hasValue ? kLightGreenBg : kFieldGray,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: hasValue ? kMint : kBorderGray,
              width: hasValue ? 1.5 : 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: hasValue ? kMint : kBorderGray,
              width: hasValue ? 1.5 : 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: kMint, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInBody() {
    const Color kNavyDark = Color(0xff14213D);
    const Color kTextGray = Color(0xff6B7280);
    const Color kMint = Color(0xff2EBF91);
    const Color kBorderGray = Color(0xffE5E7EB);
    const Color kLightGreenBg = Color(0xffE6F7EF);
    const Color kGreenDark = Color(0xff15503F);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sign In",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: kNavyDark,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: kTextGray,
                  fontSize: 13,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageTransitions.slideHorizontal(const RegistrationPage()),
                ),
                child: const Text(
                  "Create one free",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: kMint,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── User Type Toggle Component
          UserTypeToggle(
            selectedType: userType,
            onTypeChanged: (type) => setState(() => userType = type),
          ),
          const SizedBox(height: 22),

          Text(
            userType == "brand" ? "BUSINESS EMAIL" : "MOBILE NUMBER",
            style: const TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              color: kTextGray,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),

          // ── Auth Text Fields Component
          AuthTextFields(
            userType: userType,
            phoneController: phoneController,
            emailController: emailController,
            selectedCountryCode: selectedCountryCode,
            phoneError: _phoneError,
            emailError: _emailError,
            onCountryCodeTap: () {},
            onPhoneChanged: (val) {
              if (val.isNotEmpty) {
                final first = int.tryParse(val[0]) ?? 0;
                if (first < 6) {
                  setState(() => _phoneError = "Must start with 6, 7, 8 or 9 ");
                } else {
                  setState(() => _phoneError = null);
                }
              } else {
                setState(() => _phoneError = null);
              }
            },
          ),
          const SizedBox(height: 20),

          // ── Divider
          Row(
            children: const [
              Expanded(child: Divider(color: kBorderGray)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "or sign in with",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: kTextGray,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(child: Divider(color: kBorderGray)),
            ],
          ),
          const SizedBox(height: 16),

          // ── Social Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: kBorderGray),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    child: const Icon(Icons.g_mobiledata, color: Colors.red, size: 28),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: kBorderGray),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    child: const Icon(Icons.apple, color: Colors.black, size: 24),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Gradient Action Button Component
          AuthGradientButton(
            label: userType == "brand" ? "Send Verification Code" : "Send OTP",
            onPressed: _handleSendCode,
          ),
          const SizedBox(height: 18),

          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: kTextGray,
                  fontSize: 12,
                ),
                children: [
                  const TextSpan(text: "By continuing you agree to our "),
                  TextSpan(
                    text: "Terms of Service",
                    style: const TextStyle(color: kMint, fontWeight: FontWeight.w700),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: const TextStyle(color: kMint, fontWeight: FontWeight.w700),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: kLightGreenBg,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bolt, color: kMint, size: 16),
                SizedBox(width: 6),
                Text(
                  "Join 9,000+ creative & industry professionals",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: kGreenDark,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpBody() {
    const Color kTextGray = Color(0xff6B7280);
    const Color kMint = Color(0xff2EBF91);
    const Color kLightGreenBg = Color(0xffE6F7EF);
    const Color kGreenDark = Color(0xff15503F);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "ENTER OTP",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: kTextGray,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: Colors.red),
                  const SizedBox(width: 4),
                  Text(
                    "$_formattedTime remaining",
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── 6-Box OTP Inputs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (i) => _buildOtpBox(i)),
          ),
          if (_otpError != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 14),
                const SizedBox(width: 6),
                Text(
                  _otpError!,
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 18),

          Row(
            children: [
              const Text(
                "Didn't receive the code? ",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: kTextGray,
                  fontSize: 13,
                ),
              ),
              GestureDetector(
                onTap: _startTimer,
                child: const Text(
                  "Resend OTP",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: kMint,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // ── Info Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kLightGreenBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  userType == "brand"
                      ? Icons.mark_email_unread_outlined
                      : Icons.sms_outlined,
                  color: kGreenDark,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userType == "brand"
                            ? "Check your email inbox"
                            : "Check your SMS inbox",
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: kGreenDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        userType == "brand"
                            ? "The code is valid for 10 minutes. Check your spam folder if not received."
                            : "The code is valid for 10 minutes. Make sure your number is correct.",
                        style: const TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: kGreenDark,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // ── Action Button
          AuthGradientButton(
            label: "Verify & Continue",
            onPressed: _handleVerifyOtp,
          ),
          const SizedBox(height: 14),

          Center(
            child: TextButton(
              onPressed: () {
                _timer?.cancel();
                setState(() => showOTP = false);
              },
              child: Text(
                userType == "brand" ? "Change email address" : "Change phone number",
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: kTextGray,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contactDisplay = userType == "brand"
        ? (emailController.text.isEmpty ? 'your@email.com' : emailController.text)
        : "$selectedCountryCode ${phoneController.text.isEmpty ? '98765 43210' : phoneController.text}";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              showOTP
                  ? OtpGradientHeader(
                      userType: userType,
                      contactDisplay: contactDisplay,
                      onBackTap: () {
                        _timer?.cancel();
                        setState(() => showOTP = false);
                      },
                      onEditTap: () {
                        _timer?.cancel();
                        setState(() => showOTP = false);
                      },
                    )
                  : const AuthHeader(),
              showOTP ? _buildOtpBody() : _buildSignInBody(),
            ],
          ),
        ),
      ),
    );
  }
}