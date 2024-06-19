import 'package:flutter/material.dart';
import 'package:notes/Components/drawer_tile.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          //header
          DrawerHeader(
              child: Icon(Icons.note),
          ),


          //notes tile
          DrawerTile(
              title: "Notes",
              leading: Icon(Icons.home),
              onTap: (){}
          ),



          //setting tile

        ],
      ),
    );
  }

}