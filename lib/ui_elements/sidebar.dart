// Importing packages
import 'package:flutter/material.dart'; // <-- Flutter Package for Dart
import 'package:go_router/go_router.dart'; // <-- Go_Router for easier, quicker page routing
import 'package:lottie/lottie.dart'; // <-- For little octopus animation ontop of the sidebar :)

import 'package:sidebarx/sidebarx.dart'; // <-- SideBarX Package to simplify sidebar creation process

// State Initialisation
class MySidebar extends StatefulWidget { // <-- Flutter Stateful widget, means that the build method (the visuals) can be updated with the buildt-in function setState
  final int index; // <-- index for selected menu_item

  const MySidebar({super.key, required this.index}); // <-- asking for current index from screen that is using this widget

  @override
  State<MySidebar> createState() => _MySidebarState(); // <-- creating starting state for the SideBar
}

// Main Body
class _MySidebarState extends State<MySidebar> { // <-- Giving the custom widget a name
  @override
  Widget build(BuildContext context) { // <-- Creating custom widget
    return SidebarX( // <-- Displaying the SidebarX widget
      controller: SidebarXController(selectedIndex: widget.index), // <-- Creating a controller for the sidebar, and giving it it's current index
      items: [
        SidebarXItem(icon: Icons.home, label: 'home', onTap: () => GoRouter.of(context).go('/'),), // <-- Menu Item 1, Home Screen where trending and recommendations are
        SidebarXItem(icon: Icons.search, label: 'search', onTap: () => GoRouter.of(context).go('/search'),), // <-- Menu Item 2, Search Screen, Where Videos and Channels can be searched for
      ],
      theme: SidebarXTheme( // <-- Theming the SideBarX Widget
        margin: EdgeInsets.all(10), // <-- Giving Some padding around the widget to keep it visually pleasing
        decoration: BoxDecoration( // <-- Decorating it
          color: Color.fromRGBO(227, 1, 84, 1), // <-- Giving the widget a pinky, red custom colour
          borderRadius: BorderRadius.circular(15), // <-- Rounding of the design to keep it modern
        ),
        hoverColor: Colors.white, // <-- Hovering over a menu item with your mouse will give it a white tinge to let you know you're about to do something.
        selectedItemDecoration: BoxDecoration( // <-- Guess what? More decorating
          color: Color.fromRGBO(148, 1, 55, 1), // <-- Giving the selectedItem a pleasing darker colour
          borderRadius: BorderRadius.circular(300), // <-- Giving it tasteful rounded off corners
        ),
        selectedIconTheme: const IconThemeData( // <-- Theming the selected icon
          color: Colors.white, // <-- Making the Icon White
          size: 20, // <-- Making it biiig
        ),

      ),
      headerBuilder:(context, extended) { // <-- Making a header
        return LottieBuilder.network('https://assets7.lottiefiles.com/packages/lf20_cnFQBho5vj.json', fit: BoxFit.cover,); // <-- Remember that octopus that I mentioned earlier? Here is he is!
      },
    );
  }
}
