import 'package:dinero/models/dinero_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DineroService {
  Future<List<DineroModel>> getDinero() async {
    try {
      final response = await http
          .get(Uri.parse('https://app.colecciondedineros.com/api/Expo/V1'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        List<DineroModel> dineros = [];

        for (dynamic mostrador in data['mostradores']) {
          for (dynamic grupo in mostrador['grupos']) {
            dineros.add(DineroModel.fromJson(grupo['piezas'][0]));
          }
        }
        return dineros;
        // return data['data'].map((e) => DineroModel.fromJson(e)).toList();
      } else {
        print(response.reasonPhrase);
      }
      return [];
    } catch (e) {
      throw Exception('Falló la conexión con el servidor');
    }
  }
}
