import 'package:flutter/material.dart';
import 'package:latihanresponsi_123200022/pages/detailkarakter.dart';
import 'package:latihanresponsi_123200022/pages/detailweapon.dart';
import 'package:latihanresponsi_123200022/pages/listkarakter.dart';
import 'package:latihanresponsi_123200022/pages/listweapon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _lastseen;
  String? _menu;

  Future<void> _getLastSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastseen = prefs.getString("last_seen");
      _menu = prefs.getString("menu");
    });
  }

  @override
  void initState() {
    super.initState();
    _lastseen = "";
    _menu = "";
    _getLastSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.srcOver),
                image: NetworkImage(
                    'https://4.bp.blogspot.com/-iz7Z_jLPL6E/XQ8eHVZTlnI/AAAAAAAAHtA/rDn9sYH174ovD4rbxsC8RSBeanFvfy75QCKgBGAs/w1440-h2560-c/genshin-impact-characters-uhdpaper.com-4K-2.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_lastseen != null && _lastseen != "")
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Card(
                  child: ListTile(
                    onTap: () async {
                      if (_menu == "characters") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailKarakter(name: _lastseen!),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailWeapon(
                                name: _lastseen!,
                              ),
                            ));
                      }
                    },
                    leading: Image.network(
                        'https://api.genshin.dev/${_menu}/${_lastseen!.toLowerCase()}/icon'),
                    title: Text(_lastseen.toString().toUpperCase()),
                  ),
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: 150,
              height: 60,
              child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListKarakter(),
                        ));
                    _getLastSeen();
                  },
                  child: Text("Karakter")),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: 150,
                height: 60,
                child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListWeapon(),
                          ));
                      _getLastSeen();
                    },
                    child: Text("Weapon")))
          ],
        ),
      ),
    );
  }
}
