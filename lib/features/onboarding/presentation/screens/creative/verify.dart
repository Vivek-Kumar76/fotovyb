import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/tokens/tokens.dart'; //[cite: 2]
import '../../../../../shared/widgets/primary_gradient_button.dart';

class VerifyStep extends StatefulWidget {
  final VoidCallback onFinishOnboarding;

  const VerifyStep({super.key, required this.onFinishOnboarding});

  @override
  State<VerifyStep> createState() => _VerifyStepState();
}

class _VerifyStepState extends State<VerifyStep> {
  final TextEditingController aadhaarCtrl = TextEditingController();
  final TextEditingController aadhaarOtpCtrl = TextEditingController();

  bool aadhaarSent = false;
  bool aadhaarOtpVerified = false;
  File? selfieImage;
  bool selfieVerified = false;

  final ImagePicker _picker = ImagePicker();

  static const double kInputHeight = 48.0;

  bool get canSendOtp => aadhaarCtrl.text.replaceAll(' ', '').length == 12; //[cite: 15]
  bool get canVerifyOtp => aadhaarOtpCtrl.text.trim().length == 6; //[cite: 15]
  bool get isVerificationComplete => aadhaarOtpVerified; //[cite: 15]

  Future<void> _captureSelfie() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    ); //[cite: 15]
    if (file != null) {
      setState(() {
        selfieImage = File(file.path);
        selfieVerified = true;
      }); //[cite: 15]
    }
  }

  @override
  void dispose() {
    aadhaarCtrl.dispose();
    aadhaarOtpCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight; //[cite: 1]
    final Color textSecondary = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight; //[cite: 1]
    final Color textMuted = isDark ? AppColors.textMutedDark : AppColors.textMutedLight; //[cite: 1]
    final Color activeColor = isDark ? AppColors.primaryDark : AppColors.primary; //[cite: 1]
    final Color fieldBg = isDark ? AppColors.surfaceDark : Colors.white; //[cite: 1]
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0); //[cite: 1]

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space5, //[cite: 5]
        vertical: AppSpacing.space4, //[cite: 5]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: AppSpacing.space1), //[cite: 5]
          Text(
            "Verify your government identity to earn a trusted creator badge and prevent duplicate profiles.",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans, //[cite: 6]
              fontSize: AppTypography.sizeSm, //[cite: 6]
              color: textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.space5), //[cite: 5]

          // ── 1. Aadhaar Input Section (Pill Shaped Field & Action Button)
          _buildLabel("AADHAAR NUMBER *", textMuted),
          const SizedBox(height: AppSpacing.space1), //[cite: 5]
          Row(
            children: [
              Expanded(
                child: Container(
                  height: kInputHeight,
                  decoration: BoxDecoration(
                    color: fieldBg,
                    borderRadius: AppRadius.radiusFull, //[cite: 3]
                    border: Border.all(
                      color: aadhaarOtpVerified ? activeColor : borderColor,
                      width: aadhaarOtpVerified ? 1.6 : 1.0,
                    ),
                  ),
                  child: TextField(
                    controller: aadhaarCtrl,
                    keyboardType: TextInputType.number,
                    readOnly: aadhaarOtpVerified,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilyMono, //[cite: 6]
                      fontSize: AppTypography.sizeSm, //[cite: 6]
                      letterSpacing: 1.5,
                      fontWeight: AppTypography.semibold, //[cite: 6]
                      color: textColor,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12),
                      _AadhaarFormatter(),
                    ],
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: "____ ____ ____",
                      hintStyle: TextStyle(
                        fontFamily: AppTypography.fontFamilyMono, //[cite: 6]
                        color: textMuted,
                        fontSize: AppTypography.sizeSm, //[cite: 6]
                        letterSpacing: 1.0,
                      ),
                      prefixIcon: Icon(Icons.badge_outlined, size: 20, color: textMuted),
                      suffixIcon: aadhaarOtpVerified
                          ? const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 18) //[cite: 1]
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space2), //[cite: 5]
              SizedBox(
                height: kInputHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: aadhaarOtpVerified
                        ? (isDark ? const Color(0xff064E3B) : const Color(0xffD1FAE5))
                        : (canSendOtp ? activeColor : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0))), //[cite: 1]
                    foregroundColor: aadhaarOtpVerified
                        ? activeColor
                        : (canSendOtp ? Colors.white : const Color(0xff94A3B8)),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16),
                    shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull), //[cite: 3]
                  ),
                  onPressed: canSendOtp ? () => setState(() => aadhaarSent = true) : null, //[cite: 15]
                  child: Text(
                    aadhaarSent ? "Resend" : "Send OTP",
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                      fontSize: AppTypography.sizeXs + 0.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── 2. OTP Input Row (Single 6-digit Pill Field)
          if (aadhaarSent) ...[
            const SizedBox(height: AppSpacing.space3), //[cite: 5]
            _buildLabel("ENTER 6-DIGIT AADHAAR OTP *", textMuted),
            const SizedBox(height: AppSpacing.space1), //[cite: 5]
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: kInputHeight,
                    decoration: BoxDecoration(
                      color: fieldBg,
                      borderRadius: AppRadius.radiusFull, //[cite: 3]
                      border: Border.all(
                        color: canVerifyOtp ? activeColor : borderColor,
                      ),
                    ),
                    child: TextField(
                      controller: aadhaarOtpCtrl,
                      keyboardType: TextInputType.number,
                      readOnly: aadhaarOtpVerified,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                        fontSize: AppTypography.sizeSm, //[cite: 6]
                        letterSpacing: 2.0,
                        fontWeight: AppTypography.bold, //[cite: 6]
                        color: textColor,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "Enter 6-digit OTP",
                        hintStyle: TextStyle(
                          fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                          color: textMuted,
                          fontSize: AppTypography.sizeSm, //[cite: 6]
                          letterSpacing: 0,
                        ),
                        prefixIcon: Icon(Icons.shield_outlined, size: 20, color: textMuted),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.space2), //[cite: 5]
                SizedBox(
                  height: kInputHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: canVerifyOtp
                          ? (aadhaarOtpVerified ? (isDark ? AppColors.surfaceSecondaryDark : const Color(0xffD1FAE5)) : activeColor) //[cite: 1]
                          : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0)), //[cite: 1]
                      foregroundColor: aadhaarOtpVerified
                          ? activeColor
                          : (canVerifyOtp ? Colors.white : const Color(0xff94A3B8)),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 14 : 18),
                      shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull), //[cite: 3]
                    ),
                    onPressed: canVerifyOtp ? () => setState(() => aadhaarOtpVerified = true) : null, //[cite: 15]
                    child: Text(
                      aadhaarOtpVerified ? "Verified ✓" : "Verify OTP",
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                        fontSize: AppTypography.sizeXs + 0.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.space5), //[cite: 5]

          // ── 3. Selfie Verification (Optional) Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Selfie Verification", textMuted),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceSecondaryDark : const Color(0xffF1F5F9), //[cite: 1]
                  borderRadius: AppRadius.radiusFull, //[cite: 3]
                ),
                child: Text(
                  "Optional",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                    fontSize: AppTypography.sizeXs - 1,
                    fontWeight: FontWeight.bold,
                    color: textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space2), //[cite: 5]

          Container(
            width: double.infinity,
            height: 124,
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selfieImage != null ? activeColor : borderColor,
                width: selfieImage != null ? 1.6 : 1.0,
              ),
            ),
            child: selfieImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Image.file(selfieImage!, fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.face_retouching_natural, color: textMuted, size: 36),
                      const SizedBox(height: AppSpacing.space1 + 2), //[cite: 5]
                      Text(
                        "Position your face inside the frame & capture",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                          fontSize: AppTypography.sizeXs + 1, //[cite: 6]
                          color: textMuted,
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: AppSpacing.space2), //[cite: 5]

          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
              side: BorderSide(color: selfieImage != null ? activeColor : borderColor),
              shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull), //[cite: 3]
            ),
            onPressed: _captureSelfie,
            icon: Icon(
              selfieImage != null ? Icons.refresh_rounded : Icons.camera_alt_outlined,
              color: activeColor,
              size: 18,
            ),
            label: Text(
              selfieImage != null ? "Retake Selfie" : "Capture Selfie",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                color: activeColor,
                fontSize: AppTypography.sizeSm, //[cite: 6]
                fontWeight: AppTypography.semibold, //[cite: 6]
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space5), //[cite: 5]

          // ── 4. Trust & Protection Policy Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.space4), //[cite: 5]
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xff064E3B).withValues(alpha: 0.25)
                  : const Color(0xffE6F7EF),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      color: activeColor,
                      size: 18,
                    ),
                    const SizedBox(width: AppSpacing.space2), //[cite: 5]
                    Text(
                      "Data Privacy & Verification Policy",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                        fontSize: AppTypography.sizeSm, //[cite: 6]
                        fontWeight: AppTypography.bold, //[cite: 6]
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space2), //[cite: 5]
                _buildInfoBullet(
                  "Prevent Account Duplication: Identity verification guarantees one unique profile per creator, preventing impersonation.",
                  textColor,
                  activeColor,
                ),
                _buildInfoBullet(
                  "Data Encryption: All credentials are encrypted end-to-end and never displayed publicly or shared with third parties.",
                  textColor,
                  activeColor,
                ),
                _buildInfoBullet(
                  "Trusted Creator Network: Verified creators receive a verified badge and gain priority visibility for client bookings.",
                  textColor,
                  activeColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space8), //[cite: 5]

          // ── 5. Finish Onboarding Button
          PrimaryGradientButton(
            label: "Finish Creative Onboarding",
            icon: const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 18,
            ),
            onPressed: isVerificationComplete ? widget.onFinishOnboarding : null,
          ),
          const SizedBox(height: AppSpacing.space4), //[cite: 5]
        ],
      ),
    );
  }

  Widget _buildLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: AppTypography.fontFamilySans, //[cite: 6]
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: color,
      ),
    );
  }

  Widget _buildInfoBullet(String text, Color textColor, Color bulletColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space1 + 2), //[cite: 5]
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(
              color: bulletColor,
              fontWeight: FontWeight.bold,
              fontSize: AppTypography.sizeSm, //[cite: 6]
              height: 1.2,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans, //[cite: 6]
                fontSize: AppTypography.sizeXs + 1, //[cite: 6]
                color: textColor.withValues(alpha: 0.85),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AadhaarFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue old, TextEditingValue nv) {
    final digits = nv.text.replaceAll(' ', '');
    final buf = StringBuffer();
    for (int i = 0; i < digits.length && i < 12; i++) {
      if (i == 4 || i == 8) buf.write(' ');
      buf.write(digits[i]);
    }
    final str = buf.toString();
    return nv.copyWith(text: str, selection: TextSelection.collapsed(offset: str.length));
  }
}