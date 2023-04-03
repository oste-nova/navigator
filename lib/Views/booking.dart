import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:navigator/services/remote_services.dart';

import 'dropin.dart';

class book extends StatefulWidget {
  const book({super.key});

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  String selectedOption = 'Face to Face';
  List<String> options = ['Face to Face', 'Virtual', 'On Call'];

  @override
  void initState() {
    super.initState();
    RemoteService().getdrop();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Map<String, dynamic>>> lista = List.generate(
        7,
        (index) => DropdownMenuItem(
              child: Text(
                'category title',
                style: TextStyle(fontSize: 16),
              ),
              value: {"title": 'cat title', "id": index},
            ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                width: double.maxFinite,
                color: Colors.white,
                child: Text(
                  'Navigator Details',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                  title: Text(
                    'John Andersen',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '932 Tennessee Avenue Southfield AZ - ARIZONA 48075',
                      style: TextStyle(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("Select Appointment Type"),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: DropdownButtonHideUnderline(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 40,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: DropdownButton<String>(
                      iconEnabledColor: Colors.transparent,
                      value: selectedOption,
                      isDense: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue ?? 'Face to Face';
                        });
                      },
                      items: options.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Date and Time',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Sun 12 Jul, 04:20 AM',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 40,
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => dropin(),
                            ));
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.deepOrange),
                      child: Text(
                        'Book Appointment',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
