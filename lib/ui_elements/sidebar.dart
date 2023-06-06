import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'package:sidebarx/sidebarx.dart';

class MySidebar extends StatefulWidget {
  final int index;

  const MySidebar({super.key, required this.index});

  @override
  State<MySidebar> createState() => _MySidebarState();
}

class _MySidebarState extends State<MySidebar> {
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: SidebarXController(selectedIndex: widget.index),
      items: [
        SidebarXItem(icon: Icons.home, label: 'home', onTap: () => GoRouter.of(context).go('/'),),
        SidebarXItem(icon: Icons.search, label: 'search', onTap: () => GoRouter.of(context).go('/search'),),
      ],
      theme: SidebarXTheme(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(227, 1, 84, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        hoverColor: Colors.white,
        selectedItemDecoration: BoxDecoration(
          color: Color.fromRGBO(148, 1, 55, 1),
          borderRadius: BorderRadius.circular(300),
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),

      ),
      headerBuilder:(context, extended) {
        return LottieBuilder.network('https://assets7.lottiefiles.com/packages/lf20_cnFQBho5vj.json', fit: BoxFit.cover,);
      },
    );
  }
}
