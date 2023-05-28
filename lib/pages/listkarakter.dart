import 'package:flutter/material.dart';
import 'package:latihanresponsi_123200022/api/basenetwork.dart';
import 'package:latihanresponsi_123200022/pages/detailkarakter.dart';

class ListKarakter extends StatefulWidget {
  const ListKarakter({super.key});

  @override
  State<ListKarakter> createState() => _ListKarakterState();
}

class _ListKarakterState extends State<ListKarakter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("List Karakter")),
        body: Container(
          child: FutureBuilder(
              future: APIGenshin().getKarakter(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (!snapshot.hasData) {
                  return Container(
                    child: Center(child: Text("Tidak ada data")),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailKarakter(
                                        name:
                                            snapshot.data[index].toLowerCase()),
                                  ));
                            },
                            leading: Image.network(
                              'https://api.genshin.dev/characters/${snapshot.data[index]}/icon',
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                            title: Text(snapshot.data[index].toUpperCase()),
                          ),
                        );
                      });
                }
              }),
        ));
  }
}
