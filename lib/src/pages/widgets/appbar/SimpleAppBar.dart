import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final double barHeight;

  const SimpleAppBar({Key? key, required this.pageTitle, this.barHeight = kToolbarHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(pageTitle),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.message),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Notifications', textAlign: TextAlign.center),
                );
              },
            );
          },
          icon: Icon(Icons.notifications),
        )
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.71, -0.71),
            end: Alignment(-0.71, 0.71),
            colors: [Color(0xFFFFD6FF), Color(0xFFE7C6FF), Color(0xFFB8C0FF)],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(barHeight);
}
