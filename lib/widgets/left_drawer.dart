import 'package:flutter/material.dart';
import 'package:game_tracker/screens/menu.dart';
import 'package:game_tracker/screens/trackerlist_form.dart';
import 'package:game_tracker/screens/list_game.dart';

class LeftDrawer extends StatelessWidget 
{
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Drawer
    (
      child: ListView
      (
        children: 
        [
          const DrawerHeader
          (
            decoration: BoxDecoration
            (
              color: Colors.indigo,
            ),
            child: Column(
            children: 
            [
            Text
            (
              'Game Tracker',
              textAlign: TextAlign.center,
              style: TextStyle
              (
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text
            (
              "Catat seluruh progress gaming mu disini!",
              textAlign: TextAlign.center,
              style: TextStyle
              (
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),

            ),
            ],
        ),
    ),
          ListTile
          (
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () 
            {
              Navigator.pushReplacement
              (
                context,
                MaterialPageRoute
                (
                    builder: (context) => MyHomePage(),
                )
              );
            },
          ),
          ListTile
          (
            leading: const Icon(Icons.library_add_rounded),
            title: const Text('Tambah Game'),
            onTap: () 
            {
            
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TrackerFormPage()));
            
            },
          ),
          ListTile(
    leading: const Icon(Icons.library_books_rounded),
    title: const Text('Daftar Buku'),
    onTap: () {
        // Route menu ke halaman buku
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const GamePage()),
        );
    },
),
        ],
      ),
    );
  }
}