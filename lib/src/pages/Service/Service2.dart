import 'package:flutter/material.dart';
import 'package:handy/src/pages/widgets/appbar/CustomAppBar.dart';

class Service2 extends StatefulWidget {
  const Service2({super.key});

  @override
  State<Service2> createState() => _Service2State();
}

class _Service2State extends State<Service2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
            const [CustomAppbar(pageTitle: 'Service')],
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: 20, // Set the itemCount to the number of items you want to display
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            height: 200,
                            width: 400,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                  'hi this is demo purpose\n'
                                      'This is bla it is test that how app look like'),
                            ],
                          ),
                          SizedBox(height: 20)
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
