import 'package:flutter/material.dart';
import 'gMap.dart';

import 'image.dart';
import 'map_navi.dart';

class Home extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _HomeState();
  }
}


class _HomeState extends State<Home> {
   
  final List<Widget> _children = [GMAP(),ImageCapture(),Navi(),ImageCapture()];
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
 int _currentIndex = 0;
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: _children[_currentIndex], 
     bottomNavigationBar: BottomNavigationBar(
       onTap: onTabTapped, // new
       currentIndex: _currentIndex, 
       
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.home),
           title: Text('Home'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.photo_camera),
           title: Text('Upload'),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.navigation),
           title: Text('Maps'),
         )
       ],
     ),
   );
 }
}