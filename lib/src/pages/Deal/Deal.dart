import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/src/pages/widgets/appbar/SimpleAppBar.dart';
import 'package:handy/src/pages/widgets/bottombar/CustomBottomBar.dart';
import 'package:http/http.dart';

class Deals extends StatefulWidget {
  const Deals({super.key});

  @override
  State<Deals> createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  final userData = Get.arguments as Map<String, dynamic>?;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(pageTitle: 'Deals',),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 270,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(40),
                    image: DecorationImage(
                     image: NetworkImage (userData?['photoURL']),
                      fit: BoxFit.fill,
                    ),
                  ),

              ),

              ListTile(
                title: const Text('username'),
                subtitle: Text( userData?['username']),
                leading: const Icon(Icons.account_circle),
              ),
              const Divider(height: 2,),
              ListTile(
                title: const Text('required'),
                subtitle: Text( userData?['service']),
                leading: const Icon(Icons.workspaces_filled),
              ),
              const Divider(height: 2,),
              ListTile(
                title: const Text('descripition'),
                subtitle: Text(userData?['optional']),
                leading: const Icon(Icons.description),
              ),
              const Divider(height: 2,),
              ListTile(
                title: const Text('location'),
                subtitle: Text("BH1 A108,LPU.1412132"),
                leading: const Icon(Icons.location_on_sharp),
              ),
              const Divider(height: 2,),
              ListTile(
                title: const Text('phone'),
                subtitle: Text(userData?['phone']),
                leading: const Icon(Icons.call),
              ),
              Column(
                children: [
               /* Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('Reject',style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),)),
                ),
                  SizedBox(width: 130),*/

                ],
              ),

            Container(
                  height: MediaQuery.sizeOf(context).height*0.06,
                  width:MediaQuery.sizeOf(context).width*0.7,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: (){
                        Get.defaultDialog(
                          title: 'Thankyou',
                          middleText: 'wait for the response',
                          buttonColor: Colors.black,
                          textConfirm: 'ok',
                          onConfirm: (){
                            Get.back();
                          },
                        );
                      },
                      child: Text('contact now',style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                )


            ],

          ),
        ),
      ),
    );
  }
}
