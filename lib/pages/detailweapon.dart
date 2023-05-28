import 'package:flutter/material.dart';
import 'package:latihanresponsi_123200022/api/basenetwork.dart';
import 'package:latihanresponsi_123200022/model/weaponmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailWeapon extends StatefulWidget {
  final String name;
  const DetailWeapon({super.key, required this.name});

  @override
  State<DetailWeapon> createState() => _DetailWeaponState();
}

class _DetailWeaponState extends State<DetailWeapon> {
  Future<void> _setLastSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last_seen', widget.name);
    prefs.setString('menu', 'weapons');
  }

  @override
  void initState() {
    super.initState();
    _setLastSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
            "Detail ${widget.name[0].toUpperCase()}${widget.name.substring(1).toLowerCase()}"),
      ),
      body: FutureBuilder(
        future: APIGenshin().getDetailWeapon(widget.name),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: Text("Tidak ada data"),
              ),
            );
          } else {
            WeaponModel weapon = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://api.genshin.dev/weapons/${widget.name}/icon'),
                              fit: BoxFit.contain)),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      weapon.name,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < weapon.rarity; i++)
                          Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
