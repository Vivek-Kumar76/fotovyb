import 'package:flutter/material.dart';
import '../../../../core/tokens/tokens.dart';

class UserTypeToggle extends StatelessWidget {
  final String selectedType; // "creative" or "brand"
  final ValueChanged<String> onTypeChanged;

  const UserTypeToggle({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  static const Gradient kButtonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xff2EBF91), Color(0xff14213D)],
  );

  Widget _option({
    required String value,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = selectedType == value;
    const Color kBorderGray = Color(0xffE5E7EB);
    const Color kTextGray = Color(0xff6B7280);

    return Expanded(
      child: GestureDetector(
        onTap: () => onTypeChanged(value),
        child: Container(
          height: 46,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            gradient: isSelected ? kButtonGradient : null,
            color: isSelected ? null : Colors.white,
            border: isSelected ? null : Border.all(color: kBorderGray),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSelected ? Colors.white : kTextGray),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontFamily: AppTypography.fontFamilySans,
                  color: isSelected ? Colors.white : kTextGray,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _option(
          value: "creative",
          icon: Icons.camera_alt_outlined,
          label: "Creative Pro",
        ),
        _option(
          value: "brand",
          icon: Icons.work_outline_rounded,
          label: "Brand / Business",
        ),
      ],
    );
  }
}