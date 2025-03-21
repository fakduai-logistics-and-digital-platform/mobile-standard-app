import 'package:flutter/material.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';

class PStyle {
  static ButtonStyle get btnPrimary {
    return ElevatedButton.styleFrom(
      backgroundColor: PColor.primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
    );
  }

  static ButtonStyle get btnSecondary {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: PColor.contentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
    );
  }
}
