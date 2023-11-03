import 'package:flutter/material.dart';
import 'db/transacciones.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  List<Map<String, dynamic>> usuarios = [];

  void getLista() async {
    final infoUsers = await Transacciones.lisUsuarios();
    setState(() {
      usuarios = infoUsers;
    });
  }

  @override // este metodo se invoca automaticamente cuando se accede a esta ruta
  void initState() {
    super.initState();
    getLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Listado")),
      body: ListView.builder(
          itemCount: usuarios.length,
          itemBuilder: (context, index) => Card(
                color: Colors.grey.shade600,
                margin: const EdgeInsets.all(3),
                child: ListTile(
                  title: Text(
                    usuarios[index]["nombres"],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    usuarios[index]["apellidos"],
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/Editar', arguments: {
                      "id": usuarios[index]["id"],
                      "nombre": usuarios[index]["nombres"],
                      "apellido": usuarios[index]["apellidos"],
                      "fecha": usuarios[index]["fecha_nac"],
                      "peso": usuarios[index]["peso"],
                    });
                  },
                ),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Registrar');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
