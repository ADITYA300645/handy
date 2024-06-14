import 'package:flutter/material.dart';
import 'package:handy/src/pages/ServiceProfile/ServiceProfile.dart';


class HomeGrid extends StatefulWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  State<HomeGrid> createState() => _HomeGridState();
}

class _HomeGridState extends State<HomeGrid> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
      },
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: count,
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  print("object");
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300,
                          image: DecorationImage(
                            image: AssetImage('assets/photos/carpenter.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300,
                              image: DecorationImage(
                                image: AssetImage('assets/photos/labour3.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300,
                              image: DecorationImage(
                                image: AssetImage('assets/photos/cook.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (count < 3) {
                    count +=2;
                  }else count = 1;
                });
                print('its working');
              },
              child: Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
                ),
                child: Text('+ more', textAlign: TextAlign.center),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
