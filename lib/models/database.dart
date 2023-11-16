import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  bool isLoggedIn = false;

  DatabaseHelper.internal();

  Future<Database?> get db async {
    if (_db != null) return _db;

    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'your_database_name.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY,
            name TEXT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertUser(User user) async {
    final db = await this.db;
    return await db!.insert('users', user.toMap());
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db!.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<User?> getUserByPassword(String email, String password) async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db!.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      final storedPassword = maps.first['password'] as String;

      if (storedPassword == password) {
        return User.fromMap(maps.first);
      }
    }

    return null;
  }

  Future<void> checkLoginStatus(String email, String password) async {
    final db = await this.db;
    final user = await getUserByPassword(email, password);
    if (user != null) {
      isLoggedIn = true;
    }
  }

  // void addUserToFirestore(
  //     String email, String displayName, String password) async {
  //   try {
  //     CollectionReference users =
  //         FirebaseFirestore.instance.collection('users');

  //     await users.add({
  //       'email': email,
  //       'displayName': displayName,
  //       'password': password,
  //     });

  //     print('Data pengguna berhasil ditambahkan ke Firestore.');
  //   } catch (e) {
  //     print('Terjadi kesalahan saat menambahkan data ke Firestore: $e');
  //   }
  // }
}
