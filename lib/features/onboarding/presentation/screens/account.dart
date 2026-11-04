import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:p1/core/tokens/tokens.dart';
import 'package:p1/shared/widgets/primary_gradient_button.dart';

class AccountStep extends StatefulWidget {
  final String initialRole;
  final ValueChanged<String> onRoleChanged;
  final VoidCallback onAccountCreated;
  final VoidCallback onSignInTap;

  const AccountStep({
    super.key,
    this.initialRole = "creative",
    required this.onRoleChanged,
    required this.onAccountCreated,
    required this.onSignInTap,
  });

  @override
  State<AccountStep> createState() => _AccountStepState();
}

class _AccountStepState extends State<AccountStep> {
  late String _selectedRole;

  // Form Controllers
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  // State Flags
  String countryCode = "+91";
  bool isOtpSent = false;
  bool isOtpVerified = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
  }

  @override
  void dispose() {
    phoneCtrl.dispose();
    emailCtrl.dispose();
    otpCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _selectRole(String role) {
    if (_selectedRole != role) {
      setState(() {
        _selectedRole = role;
        isOtpSent = false;
        isOtpVerified = false;
        otpCtrl.clear();
      });
      widget.onRoleChanged(role);
    }
  }

  bool get _isPhoneValid {
    final digits = phoneCtrl.text.trim();
    if (digits.length != 10) return false;
    final first = int.tryParse(digits[0]) ?? 0;
    return first >= 6;
  }

  bool get _isEmailValid =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailCtrl.text.trim());

  bool get _isOtpValid => otpCtrl.text.trim().length == 6;

  bool get _isPasswordValid {
    final pass = passwordCtrl.text;
    final confirmPass = confirmPasswordCtrl.text;
    if (pass.length < 8) return false;
    return pass == confirmPass;
  }

  bool get _isFormValid {
    final isContactValid = _selectedRole == "creative" ? _isPhoneValid : _isEmailValid;
    return isContactValid && isOtpVerified && _isPasswordValid;
  }

  void _handleSendOtp(Color activeColor) {
    setState(() {
      isOtpSent = true;
      isOtpVerified = false;
      otpCtrl.clear();
    });

    final contact = _selectedRole == "creative"
        ? "$countryCode ${phoneCtrl.text}"
        : emailCtrl.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("OTP verification code sent to $contact"),
        backgroundColor: activeColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleVerifyOtp(Color activeColor) {
    if (!_isOtpValid) return;

    FocusScope.of(context).unfocus();
    setState(() {
      isOtpVerified = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Contact verified successfully ✓"),
        backgroundColor: activeColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final bool isBusiness = _selectedRole == "business";

    // Dynamic Role-Aware Theme Colors & Gradients
    final Color activeColor = isBusiness
        ? (isDark ? AppColors.accentBlue : AppColors.accentNavy)
        : (isDark ? AppColors.primaryDark : AppColors.primary);

    final Gradient activeGradient = isBusiness
        ? AppColors.buttonGradientBusiness
        : AppColors.buttonGradientCreative;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color fieldBg = isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF8FAFC);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space5, vertical: AppSpacing.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Sign In Link
          Row(
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: textSecondary,
                  fontSize: AppTypography.sizeSm,
                ),
              ),
              GestureDetector(
                onTap: widget.onSignInTap,
                child: Text(
                  "Sign in",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: activeColor,
                    fontSize: AppTypography.sizeSm,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space4),

          // ── Account Track Selector
          Text(
            "I AM JOINING AS A...",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              color: textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space2),
          Row(
            children: [
              Expanded(
                child: _buildRoleCard(
                  title: "Creative Professional",
                  subtitle: "Photographer, Stylist, MUA, etc.",
                  icon: Icons.camera_alt_outlined,
                  isSelected: !isBusiness,
                  isCardBusiness: false,
                  onTap: () => _selectRole("creative"),
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: AppSpacing.space3),
              Expanded(
                child: _buildRoleCard(
                  title: "Brand / Business",
                  subtitle: "Fashion, Hotel, Auto, etc.",
                  icon: Icons.storefront_outlined,
                  isSelected: isBusiness,
                  isCardBusiness: true,
                  onTap: () => _selectRole("business"),
                  isDark: isDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space4),

          // ── Contact Input Row (Phone vs Business Email)
          if (!isBusiness) ...[
            Text(
              "PHONE NUMBER *",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                color: textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: AppSpacing.space1),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: fieldBg,
                      borderRadius: AppRadius.radiusFull,
                      border: Border.all(
                        color: isOtpVerified ? activeColor : borderColor,
                        width: isOtpVerified ? 1.6 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 14, right: 10),
                          child: Row(
                            children: [
                              const Text("🇮🇳", style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 4),
                              Text(
                                countryCode,
                                style: TextStyle(
                                  fontFamily: AppTypography.fontFamilySans,
                                  fontSize: AppTypography.sizeSm,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(width: 1, height: 24, color: borderColor),
                        Expanded(
                          child: TextField(
                            controller: phoneCtrl,
                            keyboardType: TextInputType.phone,
                            readOnly: isOtpVerified,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            onChanged: (_) => setState(() {}),
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              fontSize: AppTypography.sizeSm,
                              color: textColor,
                            ),
                            decoration: InputDecoration(
                              hintText: "Enter 10-digit phone",
                              hintStyle: TextStyle(
                                fontFamily: AppTypography.fontFamilySans,
                                color: textMuted,
                                fontSize: AppTypography.sizeSm,
                              ),
                              suffixIcon: isOtpVerified
                                  ? Icon(Icons.check_circle, color: activeColor, size: 18)
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space2),
                GestureDetector(
                  onTap: isOtpVerified ? null : (_isPhoneValid ? () => _handleSendOtp(activeColor) : null),
                  child: Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 18),
                    decoration: BoxDecoration(
                      gradient: isOtpVerified
                          ? null
                          : (_isPhoneValid ? activeGradient : null),
                      color: isOtpVerified
                          ? (isDark ? const Color(0xff064E3B) : const Color(0xffD1FAE5))
                          : (_isPhoneValid ? null : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0))),
                      borderRadius: AppRadius.radiusFull,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isOtpVerified ? "Verified ✓" : (isOtpSent ? "Resend" : "Send OTP"),
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isOtpVerified
                            ? AppColors.primary
                            : (_isPhoneValid ? Colors.white : const Color(0xff94A3B8)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            Text(
              "BRAND EMAIL ADDRESS *",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                color: textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: AppSpacing.space1),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: fieldBg,
                      borderRadius: AppRadius.radiusFull,
                      border: Border.all(
                        color: isOtpVerified ? activeColor : borderColor,
                        width: isOtpVerified ? 1.6 : 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: isOtpVerified,
                      onChanged: (_) => setState(() {}),
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeSm,
                        color: textColor,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined, size: 18, color: textMuted),
                        suffixIcon: isOtpVerified
                            ? Icon(Icons.check_circle, color: activeColor, size: 18)
                            : null,
                        hintText: "contact@brand.com",
                        hintStyle: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: textMuted,
                          fontSize: AppTypography.sizeSm,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space2),
                GestureDetector(
                  onTap: isOtpVerified ? null : (_isEmailValid ? () => _handleSendOtp(activeColor) : null),
                  child: Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 18),
                    decoration: BoxDecoration(
                      gradient: isOtpVerified
                          ? null
                          : (_isEmailValid ? activeGradient : null),
                      color: isOtpVerified
                          ? (isDark ? AppColors.accentNavy.withValues(alpha: 0.35) : const Color(0xffEFF6FF))
                          : (_isEmailValid ? null : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0))),
                      borderRadius: AppRadius.radiusFull,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isOtpVerified ? "Verified ✓" : (isOtpSent ? "Resend" : "Send OTP"),
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isOtpVerified
                            ? activeColor
                            : (_isEmailValid ? Colors.white : const Color(0xff94A3B8)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],

          // ── 6-Digit Simple OTP Input Row
          if (isOtpSent && !isOtpVerified) ...[
            const SizedBox(height: AppSpacing.space3),
            Text(
              "ENTER 6-DIGIT OTP *",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                color: textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: AppSpacing.space1),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: fieldBg,
                      borderRadius: AppRadius.radiusFull,
                      border: Border.all(
                        color: _isOtpValid ? activeColor : borderColor,
                        width: _isOtpValid ? 1.6 : 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: otpCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      onChanged: (_) => setState(() {}),
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeSm,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter 6-digit OTP",
                        hintStyle: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          color: textMuted,
                          fontSize: AppTypography.sizeSm,
                          letterSpacing: 0,
                        ),
                        prefixIcon: Icon(Icons.shield_outlined, size: 20, color: textMuted),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space2),
                GestureDetector(
                  onTap: _isOtpValid ? () => _handleVerifyOtp(activeColor) : null,
                  child: Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 14 : 18),
                    decoration: BoxDecoration(
                      gradient: _isOtpValid ? activeGradient : null,
                      color: _isOtpValid ? null : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0)),
                      borderRadius: AppRadius.radiusFull,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _isOtpValid ? Colors.white : const Color(0xff94A3B8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.space4),

          // ── Password Field
          Text(
            "PASSWORD *",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              color: textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space1),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: AppRadius.radiusFull,
              border: Border.all(
                color: passwordCtrl.text.isNotEmpty ? activeColor : borderColor,
                width: passwordCtrl.text.isNotEmpty ? 1.6 : 1.0,
              ),
            ),
            child: TextField(
              controller: passwordCtrl,
              obscureText: obscurePassword,
              onChanged: (_) => setState(() {}),
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: AppTypography.sizeSm,
                color: textColor,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline_rounded, size: 18, color: textMuted),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 18,
                    color: textMuted,
                  ),
                  onPressed: () => setState(() => obscurePassword = !obscurePassword),
                ),
                hintText: "Create password",
                hintStyle: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: textMuted,
                  fontSize: AppTypography.sizeSm,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Min 8 chars, including letters, numbers & special symbols (!@#\$%^&*)",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: 11,
              color: textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),

          // ── Confirm Password Field
          Text(
            "CONFIRM PASSWORD *",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              color: textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: AppSpacing.space1),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: AppRadius.radiusFull,
              border: Border.all(
                color: confirmPasswordCtrl.text.isNotEmpty ? activeColor : borderColor,
                width: confirmPasswordCtrl.text.isNotEmpty ? 1.6 : 1.0,
              ),
            ),
            child: TextField(
              controller: confirmPasswordCtrl,
              obscureText: obscureConfirmPassword,
              onChanged: (_) => setState(() {}),
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: AppTypography.sizeSm,
                color: textColor,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline_rounded, size: 18, color: textMuted),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 18,
                    color: textMuted,
                  ),
                  onPressed: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
                ),
                hintText: "Confirm password",
                hintStyle: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: textMuted,
                  fontSize: AppTypography.sizeSm,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space4),

          // ── Social Divider
          Row(
            children: [
              Expanded(child: Divider(color: borderColor)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "or continue with",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: textMuted,
                    fontSize: 11,
                  ),
                ),
              ),
              Expanded(child: Divider(color: borderColor)),
            ],
          ),
          const SizedBox(height: AppSpacing.space3),

          // ── Social Buttons Row
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: surfaceColor,
                    side: BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const _GoogleLogo(size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Google",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeSm,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space3),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: surfaceColor,
                    side: BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.apple, color: textColor, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        "Apple",
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeSm,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space5),

          // ── Submit Button (Gradient Matches Selected Track)
          PrimaryGradientButton(
            label: "Create Account & Continue",
            gradient: activeGradient,
            onPressed: _isFormValid ? widget.onAccountCreated : null,
            icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 16),
          ),
          const SizedBox(height: AppSpacing.space3),
        ],
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required bool isCardBusiness,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    // Specific theme per card track
    final Color activeBorder = isCardBusiness
        ? (isDark ? AppColors.accentBlue : AppColors.accentNavy)
        : (isDark ? AppColors.selectionCardSelectedBorderDark : AppColors.primary);

    final Color activeBg = isCardBusiness
        ? (isDark ? AppColors.accentNavy.withValues(alpha: 0.35) : const Color(0xffEFF6FF))
        : (isDark ? const Color(0xff064E3B).withValues(alpha: 0.3) : const Color(0xffE6F7EF));

    final Color activeIconBg = isCardBusiness
        ? (isDark ? AppColors.accentNavy : const Color(0xffDBEAFE))
        : (isDark ? const Color(0xff064E3B) : const Color(0xffD1FAE5));

    final Color inactiveBorder = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color inactiveBg = isDark ? AppColors.surfaceDark : Colors.white;

    final Color iconColor = isSelected ? activeBorder : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight);
    final Color iconBg = isSelected
        ? activeIconBg
        : (isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9));

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(AppSpacing.space3),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : inactiveBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? activeBorder : inactiveBorder,
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(height: AppSpacing.space2),
            Text(
              title,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: AppTypography.sizeSm,
                fontWeight: FontWeight.bold,
                color: isSelected ? activeBorder : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: 10,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Accurate Official Google 4-Color Vector Logo
class _GoogleLogo extends StatelessWidget {
  final double size;
  const _GoogleLogo({this.size = 18.0});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final double scale = size.width / 24.0;
    canvas.scale(scale, scale);

    final bluePath = Path()
      ..moveTo(23.745, 12.27)
      ..cubicTo(23.745, 11.48, 23.68, 10.73, 23.55, 10.0)
      ..lineTo(12.0, 10.0)
      ..lineTo(12.0, 14.51)
      ..lineTo(18.6, 14.51)
      ..cubicTo(18.31, 16.03, 17.46, 17.33, 16.2, 18.19)
      ..lineTo(16.2, 21.24)
      ..lineTo(20.08, 21.24)
      ..cubicTo(22.35, 19.15, 23.745, 16.07, 23.745, 12.27)
      ..close();
    canvas.drawPath(
      bluePath,
      Paint()
        ..color = const Color(0xff4285F4)
        ..style = PaintingStyle.fill,
    );

    final greenPath = Path()
      ..moveTo(12.0, 24.0)
      ..cubicTo(15.24, 24.0, 17.95, 22.92, 19.93, 21.09)
      ..lineTo(16.05, 18.04)
      ..cubicTo(14.97, 18.76, 13.6, 19.2, 12.0, 19.2)
      ..cubicTo(8.88, 19.2, 6.23, 17.1, 5.28, 14.27)
      ..lineTo(1.25, 14.27)
      ..lineTo(1.25, 17.42)
      ..cubicTo(3.26, 21.36, 7.33, 24.0, 12.0, 24.0)
      ..close();
    canvas.drawPath(
      greenPath,
      Paint()
        ..color = const Color(0xff34A853)
        ..style = PaintingStyle.fill,
    );

    final yellowPath = Path()
      ..moveTo(5.28, 14.27)
      ..cubicTo(5.03, 13.55, 4.9, 12.78, 4.9, 12.0)
      ..cubicTo(4.9, 11.22, 5.03, 10.45, 5.28, 9.73)
      ..lineTo(5.28, 6.58)
      ..lineTo(1.25, 6.58)
      ..cubicTo(0.45, 8.18, 0.0, 9.99, 0.0, 12.0)
      ..cubicTo(0.0, 14.01, 0.45, 15.82, 1.25, 17.42)
      ..lineTo(5.28, 14.27)
      ..close();
    canvas.drawPath(
      yellowPath,
      Paint()
        ..color = const Color(0xffFBBC05)
        ..style = PaintingStyle.fill,
    );

    final redPath = Path()
      ..moveTo(12.0, 4.75)
      ..cubicTo(13.77, 4.75, 15.35, 5.36, 16.6, 6.55)
      ..lineTo(20.02, 3.13)
      ..cubicTo(17.95, 1.19, 15.24, 0.0, 12.0, 0.0)
      ..cubicTo(7.33, 0.0, 3.26, 2.64, 1.25, 6.58)
      ..lineTo(5.28, 9.73)
      ..cubicTo(6.23, 6.9, 8.88, 4.75, 12.0, 4.75)
      ..close();
    canvas.drawPath(
      redPath,
      Paint()
        ..color = const Color(0xffEA4335)
        ..style = PaintingStyle.fill,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}