import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/tokens/tokens.dart';
import '../../../../../shared/widgets/primary_gradient_button.dart';

class BizVerifyStep extends StatefulWidget {
  final VoidCallback onFinishOnboarding;

  const BizVerifyStep({super.key, required this.onFinishOnboarding});

  @override
  State<BizVerifyStep> createState() => _BizVerifyStepState();
}

class _BizVerifyStepState extends State<BizVerifyStep> {
  final TextEditingController gstinCtrl = TextEditingController();
  final TextEditingController gstOtpCtrl = TextEditingController();

  bool gstOtpSent = false;
  bool gstVerified = false;
  File? docImage;

  final ImagePicker _picker = ImagePicker();

  static const double kInputHeight = 48.0;

  // Validation rules (15-character GSTIN format)
  bool get canSendOtp => gstinCtrl.text.trim().length == 15;
  bool get canVerifyOtp => gstOtpCtrl.text.trim().length == 6;
  bool get isVerificationComplete => gstVerified;

  Future<void> _pickBusinessDocument() async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      setState(() {
        docImage = File(file.path);
      });
    }
  }

  void _sendGstOtp() {
    if (!canSendOtp) return;
    setState(() => gstOtpSent = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("OTP sent to mobile registered with GSTIN ${gstinCtrl.text.trim()}"),
        backgroundColor: AppColors.accentNavy,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _verifyGstOtp() {
    if (canVerifyOtp) {
      setState(() => gstVerified = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("GSTIN verified successfully ✓"),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    gstinCtrl.dispose();
    gstOtpCtrl.dispose();
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
    final Color activeColor = isDark ? AppColors.accentBlue : AppColors.accentNavy;
    final Color fieldBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color borderColor = isDark ? AppColors.borderDark : const Color(0xffE2E8F0);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space5,
        vertical: AppSpacing.space4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Verify Business Identity",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.size2Xl,
              fontWeight: AppTypography.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: AppSpacing.space1),
          Text(
            "Verify your registered GSTIN and attach incorporation documents to unlock client badge credentials.",
            style: TextStyle(
              fontFamily: AppTypography.fontFamilySans,
              fontSize: AppTypography.sizeSm,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.space5),

          // ── 1. GSTIN Input Section (Pill Shaped Container)
          _buildLabel("GSTIN NUMBER *", textMuted),
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
                      color: gstVerified ? activeColor : borderColor,
                      width: gstVerified ? 1.6 : 1.0,
                    ),
                  ),
                  child: TextField(
                    controller: gstinCtrl,
                    keyboardType: TextInputType.text,
                    readOnly: gstVerified,
                    textCapitalization: TextCapitalization.characters,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilyMono,
                      fontSize: AppTypography.sizeSm,
                      letterSpacing: 1.2,
                      fontWeight: AppTypography.semibold,
                      color: textColor,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                      _UpperCaseTextFormatter(),
                    ],
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: "22AAAAA0000A1Z5",
                      hintStyle: TextStyle(
                        fontFamily: AppTypography.fontFamilyMono,
                        color: textMuted,
                        fontSize: AppTypography.sizeSm,
                        letterSpacing: 0.5,
                      ),
                      prefixIcon: Icon(Icons.badge_outlined, size: 20, color: textMuted),
                      suffixIcon: gstVerified
                          ? const Icon(Icons.check_circle, color: AppColors.success, size: 18)
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space2),
              GestureDetector(
                onTap: gstVerified ? null : (canSendOtp ? _sendGstOtp : null),
                child: Container(
                  height: kInputHeight,
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 16),
                  decoration: BoxDecoration(
                    gradient: gstVerified
                        ? null
                        : (canSendOtp ? AppColors.buttonGradientBusiness : null),
                    color: gstVerified
                        ? (isDark ? const Color(0xff064E3B) : const Color(0xffD1FAE5))
                        : (canSendOtp ? null : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0))),
                    borderRadius: AppRadius.radiusFull,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    gstVerified ? "Verified ✓" : (gstOtpSent ? "Resend" : "Send OTP"),
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilySans,
                      fontSize: AppTypography.sizeXs + 0.5,
                      fontWeight: FontWeight.bold,
                      color: gstVerified
                          ? AppColors.success
                          : (canSendOtp ? Colors.white : const Color(0xff94A3B8)),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── 2. OTP Verification Row
          if (gstOtpSent) ...[
            const SizedBox(height: AppSpacing.space3),
            _buildLabel("ENTER 6-DIGIT GST OTP *", textMuted),
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
                        color: canVerifyOtp ? activeColor : borderColor,
                      ),
                    ),
                    child: TextField(
                      controller: gstOtpCtrl,
                      keyboardType: TextInputType.number,
                      readOnly: gstVerified,
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeSm,
                        letterSpacing: 2.0,
                        fontWeight: AppTypography.bold,
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
                  onTap: canVerifyOtp && !gstVerified ? _verifyGstOtp : null,
                  child: Container(
                    height: kInputHeight,
                    padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 14 : 18),
                    decoration: BoxDecoration(
                      gradient: (canVerifyOtp && !gstVerified)
                          ? AppColors.buttonGradientBusiness
                          : null,
                      color: gstVerified
                          ? (isDark ? const Color(0xff064E3B) : const Color(0xffD1FAE5))
                          : ((canVerifyOtp && !gstVerified)
                              ? null
                              : (isDark ? AppColors.disabledDark : const Color(0xffE2E8F0))),
                      borderRadius: AppRadius.radiusFull,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      gstVerified ? "Verified ✓" : "Verify OTP",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeXs + 0.5,
                        fontWeight: FontWeight.bold,
                        color: gstVerified
                            ? AppColors.success
                            : (canVerifyOtp ? Colors.white : const Color(0xff94A3B8)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.space5),

          // ── 3. Business Document Upload (Optional)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel("Upload Business Proof / GST Certificate", textMuted),
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
                    fontWeight: FontWeight.bold,
                    color: textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space2),

          Container(
            width: double.infinity,
            height: 124,
            decoration: BoxDecoration(
              color: fieldBg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: docImage != null ? activeColor : borderColor,
                width: docImage != null ? 1.6 : 1.0,
              ),
            ),
            child: docImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Image.file(docImage!, fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_file_outlined, color: textMuted, size: 36),
                      const SizedBox(height: AppSpacing.space1 + 2),
                      Text(
                        "Upload GST Certificate, COI or MSME Document",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamilySans,
                          fontSize: AppTypography.sizeXs + 1,
                          color: textMuted,
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: AppSpacing.space2),

          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
              side: BorderSide(color: docImage != null ? activeColor : borderColor),
              shape: RoundedRectangleBorder(borderRadius: AppRadius.radiusFull),
            ),
            onPressed: _pickBusinessDocument,
            icon: Icon(
              docImage != null ? Icons.refresh_rounded : Icons.file_upload_outlined,
              color: activeColor,
              size: 18,
            ),
            label: Text(
              docImage != null ? "Change Document" : "Select Document from Gallery",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                color: activeColor,
                fontSize: AppTypography.sizeSm,
                fontWeight: AppTypography.semibold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space5),

          // ── 4. Trust & Compliance Info Card (Bluish Business Style)
          Container(
            padding: const EdgeInsets.all(AppSpacing.space4),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.accentNavy.withValues(alpha: 0.25)
                  : const Color(0xffEFF6FF),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark
                    ? AppColors.accentBlue.withValues(alpha: 0.3)
                    : AppColors.accentNavy.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      color: activeColor,
                      size: 18,
                    ),
                    const SizedBox(width: AppSpacing.space2),
                    Text(
                      "Business Verification & Trust Policy",
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: AppTypography.sizeSm,
                        fontWeight: AppTypography.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space2),
                _buildInfoBullet(
                  "Verified Business Badge: GST verification unlocks a verified badge on all your gig postings.",
                  textColor,
                  activeColor,
                ),
                _buildInfoBullet(
                  "Anti-Fraud Protection: Validates your company identity to ensure safe collaborations.",
                  textColor,
                  activeColor,
                ),
                _buildInfoBullet(
                  "Data Privacy: GST data is encrypted and strictly used for compliance verification.",
                  textColor,
                  activeColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space8),

          // ── 5. Finish Onboarding Button (Bluish Gradient)
          PrimaryGradientButton(
            label: "Finish Business Onboarding",
            gradient: AppColors.buttonGradientBusiness,
            icon: const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 18,
            ),
            onPressed: isVerificationComplete ? widget.onFinishOnboarding : null,
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

  Widget _buildInfoBullet(String text, Color textColor, Color bulletColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.space1 + 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(
              color: bulletColor,
              fontWeight: FontWeight.bold,
              fontSize: AppTypography.sizeSm,
              height: 1.2,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                fontSize: AppTypography.sizeXs + 1,
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

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}