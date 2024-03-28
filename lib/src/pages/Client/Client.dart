import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:handy/src/pages/widgets/appbar/CustomAppBar.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
            const [CustomAppbar(pageTitle: 'Client')],
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: 1, // Set the itemCount to the number of items you want to display
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
                                  'Hi! \n''I need a driver',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                              ),
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
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: FloatingActionButton(
              onPressed: () {
                showDropDownTextField(context);
                    },
              child: Icon(Icons.search),
            ),
          ),


        ],
      ),
    );
  }
}

void showDropDownTextField(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: DropDownTextField(
          textFieldDecoration: InputDecoration(
            hintText: 'deals',
          ),
          clearOption: true,
          enableSearch: true,
          dropDownItemCount: 6,
          dropDownList: const [
            DropDownValueModel(name: '', value: ''),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
