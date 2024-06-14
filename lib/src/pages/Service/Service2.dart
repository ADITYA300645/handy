import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/src/pages/widgets/appbar/CustomAppBar.dart';
import 'package:handy/src/pages/widgets/appbar/SimpleAppBar.dart';

class Service2 extends StatefulWidget {
  String service;
  Service2({super.key,this.service=""});


  @override
  State<Service2> createState() => _Service2State();
}

class _Service2State extends State<Service2> {



  Widget getRating(String rating) {
    double ratingValue = double.tryParse(rating) ?? 4; // Default to 4 stars if parsing fails
    List
    <Widget> stars = [];

    // Whole stars
    for (int i = 0; i < ratingValue.floor(); i++) {
      stars.add(Icon(Icons.star, color: Colors.yellow));
    }

    // Half star
    if (ratingValue % 1 != 0) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow));
    }

    // Empty stars
    int remainingStars = 5 - stars.length;
    for (int i = 0; i < remainingStars; i++) {
      stars.add(Icon(Icons.star_border, color: Colors.yellow));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(pageTitle: "Service"),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('workers').where('service',isEqualTo: Get.arguments).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final userData = documents[index].data() as Map<String, dynamic>?; // Cast to Map<String, dynamic> or null
                return Column(
                  children: [
                    SizedBox(height: 20),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage("https://imgs.search.brave.com/36Yk4wYWXf62iqt4iTqG-CQDRzOG9K0-1PyF-6uFH5s/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA1LzE0LzE4LzQ2/LzM2MF9GXzUxNDE4/NDY1MV9XNXJWQ2Fi/S0tSSDZIM21WYjYy/allXZnVYaW84Yzhz/aS5qcGc"),
                    ),

                      title: Text(userData?['username']??"",style:TextStyle(
                        fontSize: 25,
                      ),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userData?['service']??Get.arguments,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(userData?['email']??"ddj@gmail.com"),
                          Text(userData?['phone']??"9785653677"),
                          Text(userData?['exp']??"4.5 years"),
                          // Add your expertise and specialization here
                          Container(
                            height: MediaQuery.sizeOf(context).height*0.04,
                            width:MediaQuery.sizeOf(context).width*0.7,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () {
                                Get.defaultDialog(
                                  title: 'Thankyou',
                                  middleText: 'wait for respond',
                                  textConfirm: 'ok',
                                  buttonColor: Colors.black,
                                  onConfirm: Get.back,
                                );
                              },
                              child: Center(
                                child: Text('book now',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(userData?['price']??"930/day",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star_half, color: Colors.yellow),
                              Text(userData!['rating']??'4.5'.toString()),

                              // Add your rating stars here
                            ],
                          ),// Replace with the actual price per day

                        ],
                      ),



                    ),
                    Divider(),
                  ],

                );
              },
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}



/*Center(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
              SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://imgs.search.brave.com/CjutP_8ejXylJimptgn-TGmC1vym4a-4R9wDBqEcXeQ/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTE0/NTA4MTUxOC9waG90/by9pbmRpYW4tbWFu/LXBvcnRyYWl0LW91/dGRvb3JzLmpwZz9z/PTYxMng2MTImdz0w/Jms9MjAmYz1WWFds/WUN5cEFLLVF0X0dr/T0xmRjJISy0wRkM5/VXVNbFJZWWEwSVhU/Yy1RPQ'), // Replace with your avatar image URL
                    ),
                    title: Text('Mohan Mishra'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Get.arguments,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text('mm@gmail.com'),
                        Text('8965946585'),
                        Text('Exp 4yrs'),
                        // Add your expertise and specialization here
                        Container(
                          height: MediaQuery.sizeOf(context).height*0.04,
                          width:MediaQuery.sizeOf(context).width*0.7,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Thankyou',
                                middleText: 'wait for respond',
                                textConfirm: 'ok',
                                buttonColor: Colors.black,
                                onConfirm: Get.back,
                              );
                              },
                            child: Center(
                              child: Text('book now',style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹450 per day',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ), // Replace with the actual price per day
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star_half, color: Colors.yellow),
                            // Add your rating stars here
                          ],
                        ),
                      ],
                    ),



                  ),
                  Divider(),
                ],

              );
            },
          ),
        ),*/