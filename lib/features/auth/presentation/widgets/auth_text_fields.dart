import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/tokens/tokens.dart';

class AuthTextFields extends StatelessWidget {
  final String userType; // "creative" or "brand"
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final String selectedCountryCode;
  final String? phoneError;
  final String? emailError;
  final VoidCallback? onCountryCodeTap;
  final ValueChanged<String>? onPhoneChanged;

  const AuthTextFields({
    super.key,
    required this.userType,
    required this.phoneController,
    required this.emailController,
    required this.selectedCountryCode,
    this.phoneError,
    this.emailError,
    this.onCountryCodeTap,
    this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    const Color kFieldGray = Color(0xffF3F4F6);
    const Color kTextGray = Color(0xff6B7280);
    const Color kMint = Color(0xff2EBF91);
    const Color kNavyDark = Color(0xff14213D);

    if (userType == "brand") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter your business email",
              hintStyle: const TextStyle(color: Color(0xffB0B4BA), fontSize: 13),
              prefixIcon: const Icon(Icons.email_outlined, color: kTextGray, size: 20),
              filled: true,
              fillColor: emailError != null ? const Color(0xffFFF0F0) : kFieldGray,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: emailError != null
                    ? const BorderSide(color: Colors.red, width: 1.2)
                    : BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: emailError != null ? Colors.red : kMint,
                  width: 1.5,
                ),
              ),
            ),
          ),
          if (emailError != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 14),
                const SizedBox(width: 6),
                Text(
                  emailError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
            ),
          ],
        ],
      );
    }

    // Creative Pro: Phone + Country Code
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onCountryCodeTap,
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: kFieldGray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      selectedCountryCode,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: kNavyDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, color: kNavyDark, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: onPhoneChanged,
                decoration: InputDecoration(
                  hintText: "Enter 10-digit mobile number",
                  hintStyle: const TextStyle(color: Color(0xffB0B4BA), fontSize: 13),
                  suffixText: phoneController.text.isEmpty
                      ? null
                      : "${phoneController.text.length}/10",
                  suffixStyle: TextStyle(
                    fontSize: 11,
                    color: phoneController.text.length == 10 ? kMint : kTextGray,
                    fontWeight: FontWeight.w600,
                  ),
                  filled: true,
                  fillColor: phoneError != null ? const Color(0xffFFF0F0) : kFieldGray,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: phoneError != null
                        ? const BorderSide(color: Colors.red, width: 1.2)
                        : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: phoneError != null ? Colors.red : kMint,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (phoneError != null) ...[
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xffFFF0F0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, color: Colors.red, size: 14),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    phoneError!,
                    style: const TextStyle(color: Colors.red, fontSize: 11.5, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}