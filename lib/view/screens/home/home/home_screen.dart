import 'package:dialogi_app/utils/app_colors.dart';
import 'package:dialogi_app/utils/app_icons.dart';
import 'package:dialogi_app/view/screens/home/home/inner_widgets/home_drawer.dart';
import 'package:dialogi_app/view/widgets/app_bar/custom_app_bar.dart';
import 'package:dialogi_app/view/widgets/image/custom_image.dart';
import 'package:dialogi_app/view/widgets/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.background,
        bottomNavigationBar: NavBar(currentIndex: 0),
      drawer: Drawer(
        backgroundColor: AppColors.background,
        elevation: 0,
        width: MediaQuery.of(context).size.width*.6,
        child: HomeDrawer(),
      ),
      appBar: CustomAppBar(
          appBarContent: Row(
            children: [
              GestureDetector(
                onTap: (){
                  scaffoldKey.currentState!.openDrawer();
                  print("object");
                },
                  child: CustomImage(imageSrc: AppIcons.drawer,size: 32,)),
              Spacer(),
              CustomImage(imageSrc: AppIcons.crown,size: 32,),
              SizedBox(width: 16,),
              GestureDetector(
                  onTap: (){},
                  child: CustomImage(imageSrc: AppIcons.chat,size: 32,)),
            ],
          )
      ),
    ));
  }
}
