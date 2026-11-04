import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class OtpGradientHeader extends StatelessWidget {
  final String userType;
  final String contactDisplay;
  final VoidCallback onBackTap;
  final VoidCallback onEditTap;

  const OtpGradientHeader({
    super.key,
    required this.userType,
    required this.contactDisplay,
    required this.onBackTap,
    required this.onEditTap,
  });

  static const Gradient kHeaderGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff15503F), Color(0xff14213D)],
  );

  Widget _blurCircle(double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.05),
        ),
      );

  Widget _dot({required bool active}) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: active ? 20 : 6,
        height: 6,
        decoration: BoxDecoration(
          color: active ? const Color(0xff2EBF91) : Colors.white24,
          borderRadius: BorderRadius.circular(4),
        ),
      );

  @override
  Widget build(BuildContext context) {
    const Color kMint = Color(0xff2EBF91);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: kHeaderGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Stack(
                children: [
                  Positioned(top: -40, right: -30, child: _blurCircle(120)),
                  Positioned(bottom: -30, left: -20, child: _blurCircle(90)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onBackTap,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "STEP 2 OF 4",
                            style: TextStyle(
                              fontFamily: AppTypography.fontFamilySans,
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 36),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: kMint.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    userType == "brand"
                        ? Icons.mark_email_unread_outlined
                        : Icons.verified_user_outlined,
                    color: kMint,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  userType == "brand" ? "Verify Your Email" : "Verify Your Number",
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  userType == "brand"
                      ? "We sent a 6-digit code to"
                      : "We sent a 6-digit OTP to",
                  style: const TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: Colors.white60,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      contactDisplay,
                      style: const TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onEditTap,
                      child: const Text(
                        "Edit",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _dot(active: false),
                    const SizedBox(width: 6),
                    _dot(active: true),
                    const SizedBox(width: 6),
                    _dot(active: false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}