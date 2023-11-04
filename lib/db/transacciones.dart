import 'package:sqflite/sqflite.dart';

class Transacciones {
  static Future<void> crearTabla(Database db) async {
    await db.execute("""
                    CREATE TABLE usuarios(
                        id        INTEGER PRIMARY KEY AUTOINCREMENT,
                        nombres   TEXT,
                        apellidos TEXT,
                        fecha_nac TEXT,
                        peso      DOUBLE,
                        fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                    )                             
                    """);
  }

  static Future<Database> db() async {
    return openDatabase('bdusuarios.db', version: 1,
        onCreate: ((database, version) async {
      await crearTabla(database);
    }));
  }

  static Future<int> regUsuario(
      String nombres, String apellidos, String fecha_nac, double peso) async {
    final con = await db();
    final datos = {
      "nombres": nombres,
      "apellidos": apellidos,
      "fecha_nac": fecha_nac,
      "peso": peso
    };
    final id = await con.insert("usuarios", datos);
    return id;
  }

  static Future<int> edtUsuario(String nombres, String apellidos,
      String fecha_nac, double peso, int idU) async {
    final con = await db();
    final datos = {
      "nombres": nombres,
      "apellidos": apellidos,
      "fecha_nac": fecha_nac,
      "peso": peso
    };
    final id = await con
        .update("usuarios", datos, where: " id = ? ", whereArgs: [idU]);
    return id;
  }

  static Future<int> eliUsuario(int id) async {
    final con = await db();
    final r = await con.delete("usuarios", where: "id = ?", whereArgs: [id]);
    return r;
  }

  static Future<List<Map<String, dynamic>>> lisUsuarios() async {
    final con = await db();
    return await con.query("usuarios", orderBy: "id");
  }
}

// let funcion = async () => {
//    var x = await proceso.insertarBD()
//    console.log(x)
//    console.log(x)
//    console.log(x)
//    console.log(x)
// }