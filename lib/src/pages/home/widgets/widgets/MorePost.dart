import 'package:flutter/material.dart';

import 'SideScroll.dart';

class MorePosts extends StatefulWidget {
  const MorePosts({super.key});

  @override
  State<MorePosts> createState() => _MorePostsState();
}

class _MorePostsState extends State<MorePosts> {
  bool showMorePost  = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(showMorePost)
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                          image: DecorationImage(
                            image: AssetImage('assets/photos/cook5.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      SideScroll(),
                    ]
                ),
              );
            },
          ),
        Padding(
          padding: const EdgeInsets.only(bottom:80.0),
          child: GestureDetector(
            onTap: () => setState(() {
              showMorePost = !showMorePost;
            }),
            child: Container(
              height: 25,
              width: 225,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              child: Text('see more ↓',textAlign: TextAlign.center,),
            ),
          ),
        ),
      ],
    );
  }
}
