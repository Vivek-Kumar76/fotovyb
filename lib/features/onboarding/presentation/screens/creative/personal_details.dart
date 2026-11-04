import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:p1/core/tokens/tokens.dart';
import 'package:p1/shared/widgets/primary_gradient_button.dart';

class PersonalDetailStep extends StatefulWidget {
  final bool isModel;
  final Function(Map<String, dynamic> data) onProceedToVerify;

  const PersonalDetailStep({
    super.key,
    this.isModel = false,
    required this.onProceedToVerify,
  });

  @override
  State<PersonalDetailStep> createState() => _PersonalDetailStepState();
}

class _PersonalDetailStepState extends State<PersonalDetailStep> {
  final TextEditingController nameCtrl = TextEditingController();
  String? selectedGender;
  final TextEditingController dobCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController otpCtrl = TextEditingController();

  bool isOtpSent = false;
  bool isEmailVerified = false;

  static const double kInputHeight = 48.0;

  // Validation Rules
  bool get _isValidEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailCtrl.text.trim());
  bool get _isOtpValid => otpCtrl.text.trim().length == 6;

  bool get _isFormValid =>
      nameCtrl.text.trim().isNotEmpty &&
      (widget.isModel || selectedGender != null) &&
      dobCtrl.text.isNotEmpty &&
      isEmailVerified;

  void _sendEmailOtp() {
    if (!_isValidEmail) return;
    setState(() => isOtpSent = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Verification code sent to ${emailCtrl.text.trim()}"),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _verifyOtp() {
    if (_isOtpValid) {
      setState(() => isEmailVerified = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email address verified successfully ✓"),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    dobCtrl.dispose();
    emailCtrl.dispose();
    otpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight;
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary;
    final Color fieldBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);
    final Color activeBorder = isDark ? AppColors.selectionCardSelectedBorderDark : AppColors.primary;
    final Color activeBg = isDark ? const Color(0xff064E3B).withValues(alpha: 0.35) : const Color(0xffE6F7EF);

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
            "Provide your basic personal credentials to authenticate your creative profile.",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.space5),

          // ── 1. Full Name (Pill Container)
          _buildLabel("WHAT IS YOUR FULL NAME? *", textMuted),
          const SizedBox(height: AppSpacing.space1),
          Container(
            height: kInputHeight,
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: AppRadius.radiusFull,
              border: Border.all(
                color: nameCtrl.text.isNotEmpty ? activeBorder : borderColor,
                width: nameCtrl.text.isNotEmpty ? 1.6 : 1.0,
              ),
            ),
            child: TextField(
              controller: nameCtrl,
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

          // ── 2. Gender Selection (Hidden when Role is Model)
          if (!widget.isModel) ...[
            _buildLabel("GENDER *", textMuted),
            const SizedBox(height: AppSpacing.space1),
            Row(
              children: [
                Expanded(
                  child: _genderTile(
                    label: "Male",
                    isSelected: selectedGender == "Male",
                    onTap: () => setState(() => selectedGender = "Male"),
                    activeColor: activeColor,
                    activeBorder: activeBorder,
                    activeBg: activeBg,
                    borderColor: borderColor,
                    fieldBg: fieldBg,
                    textColor: textColor,
                  ),
                ),
                const SizedBox(width: AppSpacing.space3),
                Expanded(
                  child: _genderTile(
                    label: "Female",
                    isSelected: selectedGender == "Female",
                    onTap: () => setState(() => selectedGender = "Female"),
                    activeColor: activeColor,
                    activeBorder: activeBorder,
                    activeBg: activeBg,
                    borderColor: borderColor,
                    fieldBg: fieldBg,
                    textColor: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space4),
          ],

          // ── 3. Date of Birth Picker (Pill Container)
          _buildLabel("DATE OF BIRTH *", textMuted),
          const SizedBox(height: AppSpacing.space1),
          GestureDetector(
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime(1998, 1, 1),
                firstDate: DateTime(1940),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() {
                  dobCtrl.text =
                      "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                });
              }
            },
            child: Container(
              height: kInputHeight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: fieldBg,
                borderRadius: AppRadius.radiusFull,
                border: Border.all(
                  color: dobCtrl.text.isNotEmpty ? activeBorder : borderColor,
                  width: dobCtrl.text.isNotEmpty ? 1.6 : 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dobCtrl.text.isEmpty ? "dd-mm-yyyy" : dobCtrl.text,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeSm,
                      color: dobCtrl.text.isEmpty ? textMuted : textColor,
                    ),
                  ),
                  Icon(Icons.calendar_today_outlined, size: 18, color: textMuted),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space4),

          // ── 4. Email Address & OTP Trigger (Pill Shaped Row)
          _buildLabel("WHAT IS YOUR EMAIL ADDRESS? *", textMuted),
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
                      color: isEmailVerified ? activeBorder : borderColor,
                      width: isEmailVerified ? 1.6 : 1.0,
                    ),
                  ),
                  child: TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: isEmailVerified,
                    onChanged: (_) => setState(() {}),
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeSm,
                      color: textColor,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined, size: 18, color: textMuted),
                      suffixIcon: isEmailVerified
                          ? const Icon(Icons.check_circle, color: AppColors.success, size: 18)
                          : null,
                      hintText: "sanjay@gmail.com",
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
              SizedBox(
                height: kInputHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEmailVerified
                        ? (isDark ? const Color(0xff064E3B) : const Color(0xffD1FAE5))
                        : (_isValidEmail ? activeColor : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0))),
                    foregroundColor: isEmailVerified
                        ? activeColor
                        : (_isValidEmail ? Colors.white : const Color(0xff94A3B8)),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 18),
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
                  ),
                  onPressed: isEmailVerified ? null : (_isValidEmail ? _sendEmailOtp : null),
                  child: Text(
                    isEmailVerified ? "Verified ✓" : (isOtpSent ? "Resend" : "Send OTP"),
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs + 0.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space4),

          // ── 5. OTP Input Row (Single 6-digit Pill Field)
          if (isOtpSent && !isEmailVerified) ...[
            _buildLabel("ENTER 6-DIGIT EMAIL OTP *", textMuted),
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
                        color: _isOtpValid ? activeBorder : borderColor,
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
                SizedBox(
                  height: kInputHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isOtpValid
                          ? activeColor
                          : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0)),
                      foregroundColor: _isOtpValid ? Colors.white : const Color(0xff94A3B8),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 14 : 18),
                      shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
                    ),
                    onPressed: _isOtpValid ? _verifyOtp : null,
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeXs + 0.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space4),
          ],
          const SizedBox(height: AppSpacing.space8),

          // ── 6. Action Button
          PrimaryGradientButton(
            label: "Proceed to Identity Verification",
            onPressed: _isFormValid
                ? () {
                    widget.onProceedToVerify({
                      'fullName': nameCtrl.text.trim(),
                      if (!widget.isModel && selectedGender != null) 'gender': selectedGender!,
                      'dob': dobCtrl.text,
                      'email': emailCtrl.text.trim(),
                    });
                  }
                : null,
            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
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

  Widget _genderTile({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Color activeColor,
    required Color activeBorder,
    required Color activeBg,
    required Color borderColor,
    required Color fieldBg,
    required Color textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        height: kInputHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : fieldBg,
          borderRadius: AppRadius.radiusFull,
          border: Border.all(
            color: isSelected ? activeBorder : borderColor,
            width: isSelected ? 1.6 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: AppTypography.sizeSm,
                color: isSelected ? activeColor : textColor,
              ),
            ),
            Icon(
              isSelected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isSelected ? activeColor : borderColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}