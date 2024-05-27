import 'package:flutter/material.dart';
import 'package:game_tracker/widgets/left_drawer.dart';
import 'package:game_tracker/widgets/tracker_card.dart';


class MyHomePage extends StatelessWidget 
{
  // ignore: use_super_parameters
  MyHomePage({Key? key}) : super(key: key);
  final List<TrackerItem> items = 
  [
    TrackerItem("Lihat Game", Icons.library_books_rounded),
    TrackerItem("Tambah Game", Icons.library_add_rounded),
    TrackerItem("Logout", Icons.logout),
  ];
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
        appBar: AppBar(
        title: const Text(
            'Game Tracker',
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        ),
       
        drawer: const LeftDrawer(),
        body: SingleChildScrollView(

        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
            
            children: <Widget>[
                const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                
                child: Text(
                    'PBP\'s Tracker', 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    ),
                ),
                ),
                GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((TrackerItem item) {
                    return TrackerCard(item);
                }).toList(),
                ),
            ],
            ),
        ),
        ),
    );
  }
}

