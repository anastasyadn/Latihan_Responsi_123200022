import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihanresponsi_123200022/model/karaktermodel.dart';
import 'package:latihanresponsi_123200022/model/weaponmodel.dart';

class APIGenshin {
  Future<List<dynamic>> getKarakter() async {
    var url = Uri.parse('https://api.genshin.dev/characters');
    var response = await http.get(url);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return data;
  }

  Future<List<dynamic>> getWeapon() async {
    var url = Uri.parse('https://api.genshin.dev/weapons');
    var response = await http.get(url);

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return data;
  }

  Future<KarakterModel> getDetailKarakter(String name) async {
    var url = Uri.parse('https://api.genshin.dev/characters/$name');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return KarakterModel.fromJson(data);
  }

  Future<WeaponModel> getDetailWeapon(String name) async {
    print(name);
    var url = Uri.parse('https://api.genshin.dev/weapons/$name');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return WeaponModel.fromJson(data);
  }
}
