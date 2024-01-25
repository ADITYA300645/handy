import 'package:flutter/material.dart';
import 'package:handy/pages/widgets/appbar/CustomAppBar.dart';
import 'package:handy/pages/widgets/bottombar/CustomBottomBar.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({Key? key}) : super(key: key);

  Widget styledText(String text, {double fontSize = 15, FontWeight fontWeight = FontWeight.w500}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget clientInfoContainer(BuildContext context, String title, String contact, String username, String monthly) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                styledText(title, fontSize: 25, fontWeight: FontWeight.bold),
                SizedBox(height: 10),
                styledText('Mr sascnlsch'),
                styledText('contact-7848243455'),
                styledText('@fhdg22'),
                styledText('monthly-10000'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'approach now',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => const [CustomAppbar(pageTitle: 'Client')],
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  styledText('Top results', fontSize: 20, fontWeight: FontWeight.bold),
                  const Divider(
                    height: 5,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  styledText('1-20 of 1M results'),
                  const SizedBox(height: 20),
                  for (int i = 1; i <= 10; i++)
                    clientInfoContainer(
                      context,
                      "Need of cook ",
                      "7848243455",
                      "@fhdg22",
                      "10000",
                    ),
                ],
              ),
            ),
          ),
           CustomBottomBar(),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ClientPage(),
  ));
}
