import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomSliderImage extends StatefulWidget {
  const CustomSliderImage({super.key});

  @override
  State<CustomSliderImage> createState() => CustomSliderImageState();
}

class CustomSliderImageState extends State<CustomSliderImage> {
  @override
  Widget build(BuildContext context) {
    return
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
      );
  }
}
