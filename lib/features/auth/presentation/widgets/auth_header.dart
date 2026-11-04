import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

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

  Widget _professionalsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 88,
          height: 34,
          child: Stack(
            children: List.generate(4, (i) {
              final colors = [Colors.orange, Colors.blueGrey, Colors.teal, Colors.indigo];
              return Positioned(
                left: i * 20.0,
                child: CircleAvatar(
                  radius: 17,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: colors[i],
                    child: const Icon(Icons.person, color: Colors.white, size: 16),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "12,400+ Professionals",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "Already on FOTOVYB",
              style: TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statPill(String value, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontFamily: AppTypography.fontFamilySans,
                color: Colors.white60,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        _statPill("28", "Cities"),
        _statPill("3,200+", "Active Jobs"),
        _statPill("9K+", "Collaborations"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: AppTypography.fontFamilySans,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                      children: [
                        TextSpan(text: "FOTO", style: TextStyle(color: Color(0xff14213D))),
                        TextSpan(text: "VYB", style: TextStyle(color: Color(0xff2EBF91))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "CREATIVE · CONNECT · COLLABORATE",
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: Colors.white70,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  "Where Creative India\nComes Together",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Connect with photographers, stylists,\nmodels, MUAs and brands across India.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTypography.fontFamilySans,
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                _professionalsRow(),
                const SizedBox(height: 20),
                _statsRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}