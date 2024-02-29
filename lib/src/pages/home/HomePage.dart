import 'package:flutter/material.dart';
import 'package:handy/src/pages/Service/Service2.dart';
import 'package:handy/src/pages/home/widgets/HomeGrid/HomeGrid.dart';
import 'package:handy/src/pages/widgets/appbar/CustomAppBar.dart';
import 'package:handy/src/pages/widgets/bottombar/CustomBottomBar.dart';
import 'package:handy/src/pages/widgets/drawer/customDrawer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  bool showMorePost  = false;
  bool more = false;

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

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                          child: Text('Service near me :-',style:
                          TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: InkWell(
                        onTap: () => Service2(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.08,
                              width:  MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                              child: Text('carpenter',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontSize: 13,
                              ),
                              ),
                            ),

                            Container(
                              height: MediaQuery.of(context).size.width * 0.08,
                              width:  MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                              child: Text('labour',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),

                            Container(
                              height: MediaQuery.of(context).size.width * 0.08,
                              width:  MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                              child: Text('cook',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),),


                            Container(
                              height: MediaQuery.of(context).size.width * 0.08,
                              width:  MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey,
                              ),
                              child: Text('plumber',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height:20),

                    SizedBox(
                      child: CarouselSlider(
                        items: [
                          Container(decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/photos/construction.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          ),

                          Container(decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/photos/labour2.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          ),

                          Container(decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/photos/labour.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          ),

                          Container(decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/photos/electrician.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          ),
                         Container(decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/photos/cook2.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          ),

                        ],
                        options: CarouselOptions(
                          height: 200,
                          aspectRatio: 16/9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          reverse: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.linear,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),

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
                              Row(
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
                              ),

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
                            color: Colors.grey,
                          ),
                          child: Text('see more ↓',textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
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

