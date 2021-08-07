part of 'app_theme.dart';

abstract class AppTextStyles {
  TextStyle get headline5;

  TextStyle get subtitle2;

  TextStyle get body2;
}

class AppTextStylesImpl implements AppTextStyles {
  @override
  TextStyle get body2 => const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF333333));

  @override
  TextStyle get headline5 => const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF));

  @override
  TextStyle get subtitle2 => const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF333333));
}
