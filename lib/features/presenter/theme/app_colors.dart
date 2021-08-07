part of 'app_theme.dart';

abstract class AppColors {
  Color get background;

  Color get backgroundAppBar;

  Color get iconAppBar;
}

class AppColorsImpl implements AppColors {
  @override
  Color get background => const Color(0xFFe4ddd9);

  @override
  Color get backgroundAppBar => const Color(0xFF000000);

  @override
  Color get iconAppBar => const Color(0xFFFFFFFF);
}
