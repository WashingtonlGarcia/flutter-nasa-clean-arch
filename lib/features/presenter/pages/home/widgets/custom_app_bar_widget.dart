import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class CustomAppBarWidget extends AppBar {
  CustomAppBarWidget({required VoidCallback onTap})
      : super(
          backgroundColor: AppTheme.colors.backgroundAppBar,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40, width: 40, child: Image.asset('lib/features/presenter/assets/images/nasa.png', fit: BoxFit.cover)),
              const SizedBox(width: 4),
              Text('APOD', style: AppTheme.textStyles.headline5)
            ],
          ),
          actions: [IconButton(onPressed: onTap, icon: Icon(Icons.calendar_today, color: AppTheme.colors.iconAppBar))],
        );
}
