import 'package:flutter/material.dart';
import 'package:notes/Components/drawer_tile.dart';
import 'package:notes/pages/settings_page.dart';

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
              child: Icon(Icons.edit),
          ),


          //notes tile
          DrawerTile(
              title: "Notes",
              leading: Icon(Icons.home),
              onTap: () => Navigator.pop(context),
          ),



          //setting tile
          DrawerTile(
              title: "Configurações",
              leading: Icon(Icons.settings),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),
                )
                );
              },
          ),

        ],
      ),
    );
  }

}