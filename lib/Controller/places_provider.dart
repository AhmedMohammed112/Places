import 'package:my_places/Utilies/Local_Data_Source/local_data_source.dart';
import 'package:riverpod/riverpod.dart';
import '../../Models/place_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super([]);

  final LocalDataSource localDataSource = LocalDataSource();


  void addPlace(Place place) async {

    openDatabaseAndCreateTables();
    insertData(place: place);
    getData();

    state = [...state, place];
  }

  Future<sql.Database> openDatabaseAndCreateTables() async {
      return await localDataSource.createDatabase();
  }

  void insertData({required Place place}) async {
        localDataSource.insertData(place: place);
  }

  Future<void> getData() async {
    final loadedPlaces = await localDataSource.getData();
    state = loadedPlaces;
  }


  void deletePlace({required Place place}) async
  {
    localDataSource.deleteData(place: place);
    getData();
  } 

void addToFavourites({required Place place}) async
{
  localDataSource.addToFavourites(place: place);
  getData();
}

} 

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifier, List<Place>>(
    (ref) => UserPlaceNotifier());
