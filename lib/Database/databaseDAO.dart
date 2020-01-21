import 'package:ims/Database/UserData.dart';
import 'package:ims/Database/app_Database.dart';
import 'package:sembast/sembast.dart';

class DatabaseDAO {
  static const String STORE_NAME = 'login';
  final _userData = intMapStoreFactory.store(STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(UserData userData) async {
    var result = await _userData.add(await _db, userData.toMap());
    print(result);
  }

  Future deleteAll() async {
    await _userData.delete(await _db);
  }

  Future<List<UserData>> getAllSortedByID() async {
    final finder = Finder(sortOrders: [SortOrder('id')]);
    final recordSnapshots = await _userData.find(await _db, finder: finder);
    return recordSnapshots.map((snapshot) {
      final userData = UserData.fromMap(snapshot.value);
      userData.id = snapshot.key;
      return userData;
    }).toList();
  }
}
