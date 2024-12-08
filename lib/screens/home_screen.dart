import 'package:flipr_assignment/screens/home/discover_fragment.dart';
import 'package:flipr_assignment/screens/home/favorite_fragment.dart';
import 'package:flipr_assignment/screens/home/profile_fragment.dart';
import 'package:flipr_assignment/screens/home/restaurant_fragment.dart';
import 'package:flipr_assignment/screens/home/search_fragment.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navBarIndex = 0;

  List<Widget> widgetList = const [
    DiscoverFragment(),
    RestaurantFragment(),
    SearchFragment(),
    FavoriteFragment(),
    ProfileFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: navBarIndex, children: widgetList),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            navBarIndex = index;
          });
        },
        currentIndex: navBarIndex,
        items: const [
        BottomNavigationBarItem(icon: Icon(MingCute.compass_line), label: "Discover", activeIcon: Icon(MingCute.compass_fill)),
        BottomNavigationBarItem(icon: Icon(MingCute.store_2_line), label: "Restaurants", activeIcon: Icon(MingCute.store_2_fill)),
        BottomNavigationBarItem(icon: Icon(MingCute.search_line), label: "Search", activeIcon: Icon(MingCute.search_fill)),
        BottomNavigationBarItem(icon: Icon(MingCute.heart_line), label: "Favorite", activeIcon: Icon(MingCute.heart_fill)),
        BottomNavigationBarItem(icon: Icon(MingCute.user_3_line), label: "Profile", activeIcon: Icon(MingCute.user_3_fill)),
      ],),
    );
  }
}
