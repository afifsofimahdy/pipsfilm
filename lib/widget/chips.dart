import 'package:flutter/material.dart';

class ChipsCustom extends StatelessWidget {
  const ChipsCustom({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Chip(
              label: Text("All ", style: TextStyle(
                color:Colors.white,
              ),),
              backgroundColor:Colors.orange
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Chip(
              label: Text("Action", style: TextStyle(
                color:Colors.white,
              ),),
              backgroundColor:Colors.blueGrey,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Chip(
              label: Text("Romance ", style: TextStyle(
                color:Colors.white,
              ),),
              backgroundColor:Colors.blueGrey
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Chip(
              label: Text("Horor ", style: TextStyle(
                color:Colors.white,
              ),),
              backgroundColor:Colors.blueGrey
            ),
          ),
        ],
      ),
    );
  }
}