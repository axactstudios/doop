import 'package:flutter/material.dart';

class AddVoulnteer extends StatefulWidget {
  @override
  _AddVoulnteerState createState() => _AddVoulnteerState();
}

class _AddVoulnteerState extends State<AddVoulnteer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e2d2d),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        backgroundColor: Color(0xFFfab300),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Add A Volunteer',
                style: TextStyle(color: Color(0xFFfab300), fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
