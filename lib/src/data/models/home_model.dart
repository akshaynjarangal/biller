import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomeGrid {
  final String title;
  final IconData icon;
  final IconData selectedIcon;
  HomeGrid({required this.selectedIcon,required this.title, required this.icon});
}

final List<HomeGrid> homeGridItems = [
  HomeGrid(title: 'Customers', icon: IconlyLight.user_1, selectedIcon: IconlyBold.user_3),
  HomeGrid(title: 'Products', icon: CupertinoIcons.cube_box, selectedIcon: CupertinoIcons.cube_box_fill),
  HomeGrid(title: 'New Order', icon: IconlyLight.plus, selectedIcon: IconlyBold.plus),
  HomeGrid(title: 'Return Order', icon: IconlyLight.logout, selectedIcon: IconlyBold.logout),
  HomeGrid(title: 'Add Payment', icon: IconlyLight.wallet, selectedIcon: IconlyBold.wallet),
  HomeGrid(title: 'Today\'s Order', icon: CupertinoIcons.doc_checkmark, selectedIcon: CupertinoIcons.doc_checkmark_fill),
  HomeGrid(title: 'Today\'s Summary', icon: IconlyLight.document, selectedIcon: IconlyBold.document),
  HomeGrid(title: 'Route', icon: Icons.route_outlined, selectedIcon: Icons.route),
  
];