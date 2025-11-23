import 'package:evently/ui/home_screen/add_event/add_event.dart';
import 'package:evently/ui/home_screen/tabs/favourite_tab/favourite_tab.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/home_tab.dart';
import 'package:evently/ui/home_screen/tabs/map_tab/map_tab.dart';
import 'package:evently/ui/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> tabs = const [
    HomeTab(),
    MapTab(),
    FavouriteTab(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (value) {
              selectedIndex = value;
              setState(() {});
            },
            selectedItemColor: AppColor.white,
            unselectedItemColor: AppColor.white,
            items: [
              buildBottomNavigationBarItem(
                  index: 0,
                  selectedIcon: AssetsManager.iconHomeSelected,
                  icon: AssetsManager.iconHome,
                  label: AppLocalizations.of(context)!.home),
              buildBottomNavigationBarItem(
                  index: 1,
                  selectedIcon: AssetsManager.iconMapSelected,
                  icon: AssetsManager.iconMap,
                  label: AppLocalizations.of(context)!.map),
              buildBottomNavigationBarItem(
                  index: 2,
                  selectedIcon: AssetsManager.iconFavoriteSelected,
                  icon: AssetsManager.iconFavorite,
                  label: AppLocalizations.of(context)!.favorite),
              buildBottomNavigationBarItem(
                  index: 3,
                  selectedIcon: AssetsManager.iconProfileSelected,
                  icon: AssetsManager.iconProfile,
                  label: AppLocalizations.of(context)!.profile),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEvent.routeName);
        },
        child: Icon(
          Icons.add,
          color: AppColor.white,
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required int index,
    required String selectedIcon,
    required String icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(selectedIndex == index ? selectedIcon : icon)),
      label: label,
    );
  }
}
