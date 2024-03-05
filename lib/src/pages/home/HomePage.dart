import 'package:flutter/material.dart';
import 'package:handy/src/pages/home/widgets/widgets//HomeGrid.dart';
import 'package:handy/src/pages/home/widgets/widgets/CarouselSlider.dart';
import 'package:handy/src/pages/home/widgets/widgets/MorePost.dart';
import 'package:handy/src/pages/home/widgets/widgets/ServiceBar.dart';
import 'package:handy/src/pages/widgets/appbar/CustomAppBar.dart';
import 'package:handy/src/pages/widgets/bottombar/CustomBottomBar.dart';
import 'package:handy/src/pages/widgets/drawer/customDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
                const [CustomAppbar(pageTitle: 'Home')],

            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeGrid(),

                    SizedBox(height: 2,),

                    ServiceBar(),

                    SizedBox(height:20),

                    CustomSliderImage(),

                    SizedBox(height:20),

                    Container(
                      height: MediaQuery.of(context).size.width * 0.5,
                      width:  MediaQuery.of(context).size.width * 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage('assets/photos/carpenter2.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height:5),


                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.1,
                          width:  MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blueGrey,
                            image: DecorationImage(
                              image: AssetImage('assets/photos/user.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(width: 5),

                        Expanded(
                          child: SizedBox(
                            child: Text('carpentry',style: TextStyle(
                              fontSize: 10,
                              fontWeight:FontWeight.bold,
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
                          child: Text('100',style: TextStyle(
                            fontSize: 10,
                            fontWeight:FontWeight.bold,
                          ),
                          ),
                        ),

                        SizedBox(width:  MediaQuery.of(context).size.width*0.1),

                        SizedBox(
                          child: Icon(
                            Icons.remove_red_eye_outlined,
                          ),
                        ),
                        SizedBox(
                          child: Text('2.1k',style: TextStyle(
                            fontSize: 10,
                            fontWeight:FontWeight.bold,
                          ),
                          ),
                        ),

                      ],
                    ),



                    SizedBox(height: 20),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Row(
                          children: [
                            Container(
                              height: 300,
                              width: 175,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: AssetImage('assets/photos/cook2.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),

                            Container(
                              height: 300,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: AssetImage('assets/photos/construction3.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            SizedBox(width: 20),

                            Container(
                              height: 300,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: AssetImage('assets/photos/carpenter.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            SizedBox(width: 20),

                            Container(
                              height: 300,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: AssetImage('assets/photos/electrician2.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            SizedBox(width: 20),

                            Container(
                              height: 300,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: AssetImage('assets/photos/labour4.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    MorePosts(),



                  ],
                ),
              ),
            ),
          ),
          const CustomBottomBar(),
        ],
      ),
    );
  }


}

