import 'package:game_tracker/screens/login.dart';
import 'package:game_tracker/screens/trackerlist_form.dart';
import 'package:flutter/material.dart';
import 'package:game_tracker/widgets/left_drawer.dart';
import 'package:game_tracker/screens/list_game.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class TrackerItem {
    final String name;
    final IconData icon;

    TrackerItem(this.name, this.icon);
}

class TrackerCard extends StatelessWidget {
    final TrackerItem item;

    const TrackerCard(this.item, {super.key}); // Constructor

    @override
    Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
        color: Colors.indigo,
        child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
            // Memunculkan SnackBar ketika diklik
            ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
                // Navigate ke route yang sesuai (tergantung jenis tombol)
                
                if (item.name == "Tambah Game") {
                Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TrackerFormPage()));
                }
                else if (item.name == "Lihat Game") {
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => const GamePage()
        ),
    );
}
else if (item.name == "Logout") {
    final response = await request.logout(
        "http://10.0.2.2/auth/logout/");
    String message = response["message"];
    if (context.mounted) {
        if (response['status']) {
            String uname = response["username"];
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message Sampai jumpa, $uname."),
            ));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
            );
        } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(message),
                ),
            );
        }
    }
}
                
        },
        child: Container(
            padding: const EdgeInsets.all(8),
            child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(
                    item.icon,
                    color: Colors.white,
                    size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                ),
                ],
            ),
            ),
        ),
        ),
    );
    }
}