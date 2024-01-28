import 'package:chit_chat_mob/screens/requriement_Screen.dart';
import 'package:chit_chat_mob/screens/signup.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<StatefulWidget> createState() => _MyBottomNavigationBar();
}

class _MyBottomNavigationBar extends State<MyBottomNavigationBar>
    with SingleTickerProviderStateMixin {
//late keyword is used to declare variables that will be initialized later.
//These variables are called non-nullable variables because they are initialized after the declaration
  late PageController _pageController;
  // set the current index variable for navigation ....
  int _currentIndex = 0;

  // create a list of widget that will be displayed in the Navigation Bar
  final List<Widget> _pages = [
    const RequirementScreen(),
    const Signup(),
    const Signup(),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requirements'),
        backgroundColor: Colors.orangeAccent,
        shadowColor: Colors.black,
        toolbarHeight: 60.60,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25.5),
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.white,
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              selectedFontSize: 15,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInCubic,
                  );
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat, color: Colors.orange),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.visibility, color: Colors.orange),
                  label: 'Status',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.call, color: Colors.orange),
                  label: 'Call',
                ),
              ],
            ),
          ),
          AnimatedContainer(
            height: 2,
            color: Colors.orange, // Underline color
            duration: const Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width / _pages.length,
            margin: EdgeInsets.only(
              left: (_currentIndex *
                      (MediaQuery.of(context).size.width / _pages.length)) +
                  (MediaQuery.of(context).size.width / (_pages.length * 2)) -
                  MediaQuery.of(context).size.width / (_pages.length * 2),
            ),
          ),
        ],
      ),
    );
  }
}
