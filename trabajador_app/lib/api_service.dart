import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'trabajador.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = 'https://finalproyecto.azurewebsites.net/api/People';

  /*Future<List<Trabajador>> getData() async {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<Trabajador> trabajadores = [];
      for (var model in jsonResponse) {
        Trabajador trabajador = Trabajador.fromJson(model);
        trabajadores.add(trabajador);
      }

      return trabajadores;
    } else {
      throw Exception('Error al llamar al API');
    }
  }*/

  Future<List<Trabajador>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    List<Trabajador> trabajadores = [];

    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var model in jsonResponse) {
        Trabajador trabajador = Trabajador.fromJson(model);
        trabajadores.add(trabajador);
      }
    }
    return trabajadores;
  }

  Future<Trabajador> getDataById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.get(Uri.parse(url + id.toString()), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return Trabajador.fromJson(jsonResponse);
    } else {
      throw Exception('Error al llamar al API');
    }
  }

  Future<Trabajador> postData(Trabajador trabajador) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map data = {
      'id': trabajador.id,
      'nombre': trabajador.nombre,
      'especialidad': trabajador.especialidad,
      'nombre': trabajador.nombre,
      'descripcion': trabajador.descripcion,
      'edad': trabajador.edad
    };

    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data));

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      return Trabajador.fromJson(jsonResponse);
    } else {
      throw Exception('Error al llamar al API');
    }
  }

  Future<void> updateData(Trabajador trabajador) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map data = {
      'id': trabajador.id,
      'nombre': trabajador.nombre,
      'especialidad': trabajador.especialidad,
      'nombre': trabajador.nombre,
      'descripcion': trabajador.descripcion,
      'edad': trabajador.edad
    };

    await http.put(Uri.parse(url + trabajador.id.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data));
  }

  Future<void> deleteData(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    await http.delete(Uri.parse(url + id.toString()), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }
}
