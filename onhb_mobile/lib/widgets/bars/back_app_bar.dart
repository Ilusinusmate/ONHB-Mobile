import 'package:flutter/material.dart';
import 'package:onhb_mobile/widgets/buttons/back_previous_screen_btn.dart';
import 'package:onhb_mobile/widgets/buttons/switch_theme_mode_btn.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      title: Center(
        child: Text(
          'ONHB Mobile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            fontStyle: FontStyle.normal
          ),
        ),
      ),

      leading: BackPreviousScreenBtn(),

      actions: [
        Padding(padding: EdgeInsets.all(8), child: SwitchThemeModeBtn()),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 70);
}
