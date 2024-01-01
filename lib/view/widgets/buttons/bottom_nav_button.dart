/*
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {

  BottomNavBar({super.key, required this.currentIndex});

  late int currentIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {


  @override
  void initState() {
    super.initState();
  }

  static  List<Widget> screens = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {

    List<BottomNavigationBarItem> bottomBarItem=[
      BottomNavigationBarItem(icon:Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomImage(imageSrc:widget.currentIndex==0?AppIcons.home:AppIcons.homeOutline,),
      ),label:"Home"),
      BottomNavigationBarItem(icon:Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomImage(imageSrc:widget.currentIndex==1?AppIcons.search:AppIcons.search,imageColor: AppColors.red_500),
      ),label:"Search"),
      BottomNavigationBarItem(icon:Padding(
        padding: const EdgeInsets.all(12.0),
        child:widget.currentIndex ==2 ?Icon(Icons.settings,color: AppColors.red_500,) : Icon(Icons.settings,color: AppColors.red_500,),
      ),label:"Settings",),
    ];


    return SafeArea(
      bottom: false,
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xffffffff),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.red_500,
          showUnselectedLabels: false,
          currentIndex: widget.currentIndex,
          selectedLabelStyle: const TextStyle(fontWeight:FontWeight.w500,),
          items:bottomBarItem,
          onTap: (value){
            setState(() {
              widget.currentIndex=value;
            });
          },
        ),
        body: screens[widget.currentIndex],
      ),
    );
  }
}*/
