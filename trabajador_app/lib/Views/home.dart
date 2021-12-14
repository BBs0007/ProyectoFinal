//import 'package:trabajador_app/Models/book.dart';
import 'package:trabajador_app/api_service.dart';
//import 'package:trabajador_app/Views/create.dart';
import 'package:trabajador_app/trabajador.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../trabajador.dart';
import 'Auth/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences prefs;
  var service = ApiService();
  late Future<List<Trabajador>> futureTrabajadores;

  @override
  void initState() {
    super.initState();
    checkLogin();
    futureTrabajadores = service.getData();
    _agregar();
  }

  int _lastItem = 0;
  List<int> imagenes = [];

  _onRefresh() async {
    setState(() {
      futureTrabajadores = service.getData();
    });
  }

  checkLogin() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Worker'),
        actions: [
          TextButton(
              onPressed: () {
                prefs.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false);
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      // body: RefreshIndicator(
      // onRefresh: () => _onRefresh(),
      // child: SafeArea(child: BooksList(books: books)),
      //),
      //floatingActionButton: FloatingActionButton.extended(
      //onPressed: () {
      //Navigator.push(context,
      //  MaterialPageRoute(builder: (context) => const CreatePage()));
      //},
      //label: const Text('Add Book'),
      //icon: const Icon(Icons.add),
      //));

      body: Container(
          child: FutureBuilder<List<Trabajador>>(
              future: futureTrabajadores,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          showDialogFunc(
                            context,
                            snapshot.data[index].edad,
                            snapshot.data[index].descripcion,
                            snapshot.data[index].especialidad,
                            snapshot.data[index].nombre,
                            snapshot.data[index].numero,
                            imagenes[index],
                          );
                        },
                        title: Text(snapshot.data[index].nombre.toString()),
                        subtitle: Text('Profesional: ' +
                            snapshot.data[index].especialidad),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/${imagenes[index]}.png'),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Ocurrio un error: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }

  void _agregar() {
    for (var i = 0; i < 9; i++) {
      _lastItem++;
      imagenes.add(_lastItem);

      setState(() {});
    }
  }

  showDialogFunc(
      context, edad, descripcion, especialidad, nombre, numero, imagenes) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black87),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/${imagenes}.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Nombre: " + nombre,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Profesion: " + especialidad,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Numero: " + numero,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Especialidad: " + descripcion,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      disabledColor: Colors.amber,
                      child: Text("CONTRATAR"),
                      splashColor: Colors.amber,
                      color: Colors.blueAccent,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                'EN UNOS MOMENTOS EL TRABAJOR SE COMUNICARA CONTIGO, CASO CONTRARIA HAGA SU RECLAMO AL TEL: 123452345'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
