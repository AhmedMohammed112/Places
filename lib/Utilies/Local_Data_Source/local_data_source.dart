import 'dart:convert';
import 'dart:io';

import '../../Models/place_model.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

abstract class DataSource {
  Future<dynamic> createDatabase();
  void insertData({required Place place});
  Future<List<dynamic>> getData();
  void deleteData({required Place place});
  void addToFavourites({required Place place});
}

class LocalDataSource implements DataSource {
  @override
  Future<sql.Database> createDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(path.join(dbPath, 'place.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT,description TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT,is_favourite INTEGER,types TEXT)',
          );
        }, version: 4);

    return db;
  }

  @override
  void deleteData({required place}) async {
    //delete from database
    final db = await createDatabase();
    db.delete('user_places',where: 'id = ?',whereArgs: [place.id]);
    getData();
  }

  @override
  Future<List<Place>> getData() async {
    final db = await createDatabase();
    final List<Map<String, dynamic>> data = await db.query('user_places');
    final List<Place> loadedPlaces = [];
    for (var element in data) {
      final decodedData = json.decode(element['image']);
      final decodedTypes = json.decode(element['types']);
      List<String> dataDecodedList = decodedData['image'].cast<String>();
      List<String> typesDecodedList = decodedTypes['types'].cast<String>();
      loadedPlaces.add(Place(
        id: element['id'],
        name: element['title'],
        image: dataDecodedList.map((e) => File(e)).toList(),
        description: element['description'],
        location: PlaceLocation(
          latitude: element['loc_lat'],
          longitude: element['loc_lng'],
          address: element['address'],
        ),
        isFavourite: element['is_favourite'] == 0 ? false : true,
        types: typesDecodedList.map((e) => (e)).toList(),
      ));
    }

    return loadedPlaces;
  }

  @override
  void insertData({required Place place}) async {
        try {
          final List<String> paths = place.image!.map((e) => e.path).toList();

          final images = {
            'image': paths,
          };

          final types = {
            'types': place.types,
          };

          final String encodedImages = json.encode(images);
          final String encodedTypes = json.encode(types);
          print("encodedImages: $encodedImages");
          print("encodedTypes: $encodedTypes");
          final sql.Database db = await createDatabase();
          db.insert('user_places', {
            'id': place.id,
            'title': place.name,
            'description': place.description,
            'image': encodedImages,
            'loc_lat': place.location.latitude,
            'loc_lng': place.location.longitude,
            'address': place.location.address,
            'is_favourite': place.isFavourite == true ? 1 : 0,
            'types': encodedTypes,
          });
        } catch (e) {
          print(e);
        }
  }

  @override
  void addToFavourites({required Place place}) async {
    final db = await createDatabase();
    print("place.id: ${place.id}");
    print("place.isFavourite: ${place.isFavourite}");
    db.update('user_places', {'is_favourite': place.isFavourite == true ? 0 : 1},where: 'id = ?',whereArgs: [place.id]);
    getData();
  }

}