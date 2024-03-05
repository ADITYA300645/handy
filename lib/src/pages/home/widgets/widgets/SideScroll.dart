import 'package:flutter/material.dart';

class SideScroll extends StatefulWidget {
  const SideScroll({super.key});

  @override
  State<SideScroll> createState() => _SideScrollState();
}

class _SideScrollState extends State<SideScroll> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.blueGrey,
            image: DecorationImage(
              image: AssetImage('assets/photos/user2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: SizedBox(
            child: Text(
              'carpentry',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width:5),
        SizedBox(
          child: Icon(
            Icons.shopping_bag_outlined,
          ),
        ),
        SizedBox(
          child: Text(
            '150',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 5),
        SizedBox(
          child: Icon(
            Icons.remove_red_eye_outlined,
          ),
        ),
        SizedBox(
          child: Text(
            '2.1k',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );

  }
}
