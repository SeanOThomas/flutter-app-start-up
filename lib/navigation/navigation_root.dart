import 'package:drop_poet/more/more_page.dart';
import 'package:drop_poet/profile/profile_page.dart';
import 'package:drop_poet/search/search_page.dart';
import 'package:flutter/material.dart';

class NavigationRoot extends StatefulWidget {

  @override
  _NavigationRootState createState() => _NavigationRootState();
}

class _NavigationRootState extends State<NavigationRoot> {

  int _pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColorDark,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            title: Text('More'),
          ),
        ],
        currentIndex: _pageIndex,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _getPage(_pageIndex),
      )
    );
  }

  Widget _getPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return ProfilePage();
      case 1:
        return SearchPage();
      case 2:
        return MorePage();
      default:
        throw Exception("invalid page index");
    }
  }
}