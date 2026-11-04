import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../../../shared/widgets/primary_gradient_button.dart';

class BizDetailStep extends StatefulWidget {
  final Function(Map<String, dynamic> data) onProceedToVerify;

  const BizDetailStep({super.key, required this.onProceedToVerify});

  @override
  State<BizDetailStep> createState() => _BizDetailStepState();
}

class _BizDetailStepState extends State<BizDetailStep> {
  final TextEditingController contactPersonCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController otpCtrl = TextEditingController();
  final TextEditingController incDateCtrl = TextEditingController();

  bool isOtpSent = false;
  bool isPhoneVerified = false;

  static const double kInputHeight = 48.0;

  // Validation Checks
  bool get _isNameValid => contactPersonCtrl.text.trim().isNotEmpty;
  bool get _isPhoneValid => RegExp(r'^[6-9]\d{9}$').hasMatch(phoneCtrl.text.trim());
  bool get _isOtpValid => otpCtrl.text.trim().length == 6;

  bool get _isFormValid => _isNameValid && isPhoneVerified;

  void _sendPhoneOtp() {
    if (!_isPhoneValid) return;
    setState(() => isOtpSent = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("OTP sent to +91 ${phoneCtrl.text.trim()}"),
        backgroundColor: AppColors.accentNavy,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _verifyOtp() {
    if (_isOtpValid) {
      setState(() => isPhoneVerified = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Phone number verified successfully ✓"),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    contactPersonCtrl.dispose();
    phoneCtrl.dispose();
    otpCtrl.dispose();
    incDateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final Color fieldBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color activeColor = isDark ? AppColors.accentBlue : AppColors.accentNavy;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space5,
        vertical: AppSpacing.space4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.space1),
          Text(
            "Provide the primary point of contact and phone number for booking coordination.",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.space5),

          // ── 1. Primary Contact Person Name (Pill Input)
          _buildLabel("PRIMARY CONTACT PERSON NAME *", textMuted),
          const SizedBox(height: AppSpacing.space1),
          Container(
            height: kInputHeight,
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: AppRadius.radiusFull,
              border: Border.all(
                color: contactPersonCtrl.text.isNotEmpty ? activeColor : borderColor,
                width: contactPersonCtrl.text.isNotEmpty ? 1.6 : 1.0,
              ),
            ),
            child: TextField(
              controller: contactPersonCtrl,
              onChanged: (_) => setState(() {}),
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: AppTypography.sizeSm,
                color: textColor,
              ),
              decoration: InputDecoration(
                hintText: "e.g. Sanjay Verma",
                hintStyle: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: textMuted,
                  fontSize: AppTypography.sizeSm,
                ),
                prefixIcon: Icon(Icons.person_outline_rounded, size: 20, color: textMuted),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space4),

          // ── 2. Phone Number Input + Send OTP Button (Bluish Gradient for Business)
          _buildLabel("CONTACT PHONE NUMBER *", textMuted),
          const SizedBox(height: AppSpacing.space1),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: kInputHeight,
                  decoration: BoxDecoration(
                    color: fieldBg,
                    borderRadius: AppRadius.radiusFull,
                    border: Border.all(
                      color: isPhoneVerified ? activeColor : borderColor,
                      width: isPhoneVerified ? 1.6 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14, right: 8),
                        child: Row(
                          children: [
                            const Text("🇮🇳", style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 4),
                            Text(
                              "+91",
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
                      Container(width: 1, height: 22, color: borderColor),
                      Expanded(
                        child: TextField(
                          controller: phoneCtrl,
                          keyboardType: TextInputType.phone,
                          readOnly: isPhoneVerified,
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
                            hintText: "10-digit phone",
                            hintStyle: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: textMuted,
                              fontSize: AppTypography.sizeSm,
                            ),
                            suffixIcon: isPhoneVerified
                                ? const Icon(Icons.check_circle, color: AppColors.success, size: 18)
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space2),
              GestureDetector(
                onTap: isPhoneVerified ? null : (_isPhoneValid ? _sendPhoneOtp : null),
                child: Container(
                  height: kInputHeight,
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16),
                  decoration: BoxDecoration(
                    gradient: isPhoneVerified
                        ? null
                        : (_isPhoneValid ? AppColors.buttonGradientBusiness : null),
                    color: isPhoneVerified
                        ? (isDark ? const Color(0xff064E3B) : const Color(0xffD1FAE5))
                        : (_isPhoneValid ? null : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0))),
                    borderRadius: AppRadius.radiusFull,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    isPhoneVerified ? "Verified ✓" : (isOtpSent ? "Resend" : "Send OTP"),
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs + 0.5,
                      fontWeight: FontWeight.bold,
                      color: isPhoneVerified
                          ? AppColors.success
                          : (_isPhoneValid ? Colors.white : const Color(0xff94A3B8)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space4),

          // ── 3. OTP Input Row (Appears when OTP is sent)
          if (isOtpSent && !isPhoneVerified) ...[
            _buildLabel("ENTER 6-DIGIT OTP *", textMuted),
            const SizedBox(height: AppSpacing.space1),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: kInputHeight,
                    decoration: BoxDecoration(
                      color: fieldBg,
                      borderRadius: AppRadius.radiusFull,
                      border: Border.all(
                        color: _isOtpValid ? activeColor : borderColor,
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
                  onTap: _isOtpValid ? _verifyOtp : null,
                  child: Container(
                    height: kInputHeight,
                    padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 14 : 18),
                    decoration: BoxDecoration(
                      gradient: _isOtpValid ? AppColors.buttonGradientBusiness : null,
                      color: _isOtpValid ? null : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0)),
                      borderRadius: AppRadius.radiusFull,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Verify",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeXs + 0.5,
                        fontWeight: FontWeight.bold,
                        color: _isOtpValid ? Colors.white : const Color(0xff94A3B8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space4),
          ],

          // ── 4. Date of Incorporation (Optional Pill Input)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("DATE OF INCORPORATION", textMuted),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9),
                  borderRadius: AppRadius.radiusFull,
                ),
                child: Text(
                  "Optional",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    fontSize: AppTypography.sizeXs - 1,
                    fontWeight: FontWeight.w700,
                    color: textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space1),
          GestureDetector(
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(() {
                  incDateCtrl.text =
                      "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
                });
              }
            },
            child: Container(
              height: kInputHeight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: fieldBg,
                borderRadius: AppRadius.radiusFull,
                border: Border.all(color: borderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    incDateCtrl.text.isEmpty ? "dd-mm-yyyy" : incDateCtrl.text,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeSm,
                      color: incDateCtrl.text.isEmpty ? textMuted : textColor,
                    ),
                  ),
                  Icon(Icons.calendar_today_outlined, size: 18, color: textMuted),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space8),

          // ── 5. Action Button (Bluish Gradient)
          PrimaryGradientButton(
            label: "Proceed to Business Verification",
            gradient: AppColors.buttonGradientBusiness,
            onPressed: _isFormValid
                ? () {
                    widget.onProceedToVerify({
                      'contactPerson': contactPersonCtrl.text.trim(),
                      'phone': phoneCtrl.text.trim(),
                      'incorporationDate': incDateCtrl.text,
                    });
                  }
                : null,
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.textOnPrimary,
              size: 18,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: AppTypography.fontFamilySans,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: color,
      ),
    );
  }
}