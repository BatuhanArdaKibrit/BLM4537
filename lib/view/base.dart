import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/view/accountsettings.dart';
import 'package:cookingrecipes/view/favoriesview.dart';
import 'package:cookingrecipes/view/fooddetail.dart';
import 'package:cookingrecipes/view/homeview.dart';
import 'package:cookingrecipes/view/profileview.dart';
import 'package:cookingrecipes/view/userrecipesview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseView extends StatefulWidget {
  int? tab;
  BaseView({super.key,this.tab});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int selectedTabIndex = 0;
  List<Widget> _pages = [
    HomeView(),
    FavoriesView(),
    UserRecipesView(),
    ProfileView()
  ];
  @override
  void initState() {
    if(widget.tab != null){
      selectedTabIndex = widget.tab!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedItemColor: Globals.unselectButtonColor,
          selectedItemColor: Globals.mainColor,
          unselectedLabelStyle: TextStyle(color: Globals.unselectButtonColor),
          selectedLabelStyle: TextStyle(color: Globals.unselectButtonColor),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: selectedTabIndex,
          onTap: (int value) {
            setState(() {
              selectedTabIndex = value;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/bottomicons/home_pasive.svg"),
              activeIcon:
                  SvgPicture.asset("assets/bottomicons/home_active.svg"),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/bottomicons/fav_pasive.svg"),
              activeIcon: SvgPicture.asset("assets/bottomicons/fav_active.svg"),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/bottomicons/menu_book_pasive.svg",
              height: 35,),
              activeIcon: SvgPicture.asset("assets/bottomicons/menu_book_active.svg",
              height: 35,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/bottomicons/profile_pasive.svg",
                  height: 35),
              activeIcon: SvgPicture.asset(
                "assets/bottomicons/profile_active.svg",
                height: 35,
              ),
              label: '',
            ),
          ],
        ),
        body: _pages[selectedTabIndex],
      ),
    );
  }
}
