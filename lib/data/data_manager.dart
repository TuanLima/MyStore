

import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mystore/model/fooditem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataManager {
  Future<FoodItemList> _foodItemList;
  Reference _ref;
  Future<SharedPreferences> _futurePrefs;

  DataManager() {
    _ref = FirebaseStorage.instance.ref().child('storeItems').child('storeItems.txt');
    loadPrefs();
    syncLocalFromRemote();
    _foodItemList = loadList();
  }

  Future<FoodItemList> getList(){
    return _foodItemList;
  }

  Future<FoodItemList> loadList() async {
    SharedPreferences prefs = await _futurePrefs;
    final dynamic localJson = prefs.getString('storeItems');
    return FoodItemList.fromJson(json.decode(localJson));
  }

  void syncLocalFromRemote() async {
    SharedPreferences prefs = await _futurePrefs;
    String remoteItemsList = String.fromCharCodes(await _ref.getData());
    prefs.setString('storeItems', remoteItemsList);
  }

  Future<void> loadPrefs() async {
    _futurePrefs = SharedPreferences.getInstance();
  }
}
