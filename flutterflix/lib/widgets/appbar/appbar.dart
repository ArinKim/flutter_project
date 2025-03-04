import 'package:flutter/material.dart';
import 'package:flutterflix/core/theme/app_dimensions.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text("Flutterflix", style: TextStyle(color: Colors.deepOrange, fontSize: 24, fontWeight: FontWeight.bold)),
      actions: [
        IconButton(icon: const Icon(Icons.search, color: Colors.deepOrange), onPressed: () {}),
        IconButton(icon: const Icon(Icons.notifications, color: Colors.deepOrange), onPressed: () {}),
        IconButton(icon: const Icon(Icons.account_circle, color: Colors.deepOrange), onPressed: () {}),
      ],
      elevation: 0,
      toolbarHeight: preferredSize.height,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + AppDimensions.paddingM);
}
