import 'package:flutter/material.dart';
import 'package:handy/src/pages/Auth/Login/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Set the duration of the animation
    );
    _animation = Tween<double>(
      begin: -300.0,
      end: 0.0, // Adjust this value as per your requirement
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    ));

    // Start the animation
    _animationController.forward();

    // Navigate to the login page after the animation finishes
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.71, -0.71),
                      end: Alignment(-0.71, 0.71),
                      colors: [
                        Color(0xFFFFD6FF),
                        Color(0xFFB8C0FF),
                        Color(0xFFE7C6FF),
                      ],
                    ),
                  ),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _animation.value),
                        child: child,
                      );
                    },
                    child: Stack(
                       children: [
                         Center(
                         child: Padding(
                           padding: const EdgeInsets.only(top: 500),
                           child: Column(
                             children: [
                               Container(
                                 height: 200,
                                 width: 310,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   border: Border.all(color: Colors.grey.shade300,width: 4),
                                 ),
                                 child: Center(
                                   child: Text('Handy',style: TextStyle(
                                     fontSize: 90,
                                     color: Colors.deepPurple.shade900,
                                     fontWeight: FontWeight.bold
                                   )),
                                 ),
                               ),
                             ],
                           ),
                         ),

                       ),],

                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
