import 'package:flutter/material.dart';
import 'jobs.dart';
import 'profile.dart';
import 'spareparts.dart';
import 'workers.dart';
import 'other.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Welcome to Home Page')), // Placeholder for home content
    JobsPage(),
    WorkerPage(),
    SparepartPage(),
    ProfilePage(),
    OtherPage()
  ];

  void _onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTappedBar,
        currentIndex: _currentIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Workers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Spareparts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}