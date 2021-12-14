import 'package:flutter/material.dart';
import 'package:trabajador_app/api_service.dart';
import 'package:trabajador_app/trabajador.dart';
import 'package:trabajador_app/Views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Trabajadores App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}

/*class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiService service = ApiService();
  late Future<List<Trabajador>> futureTrabajadores;

  @override
  void initState() {
    super.initState();
    futureTrabajadores = service.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de trabajadores'),
      ),
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
                            snapshot.data[index].foto,
                            snapshot.data[index].descripcion,
                            snapshot.data[index].especialidad,
                            snapshot.data[index].nombre,
                            snapshot.data[index].numero,
                          );
                        },
                        title: Text(snapshot.data[index].nombre.toString()),
                        subtitle: Text('Profesional: ' +
                            snapshot.data[index].especialidad),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data[index].foto),
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
}

showDialogFunc(context, foto, descripcion, especialidad, nombre, numero) {
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
                    child: Image.network(
                      foto,
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
                ],
              ),
            ),
          ),
        );
      });
}*/
